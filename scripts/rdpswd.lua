#!/usr/bin/env lua
-- [a-z], [A-Z], [0-9], [()`~!@#$%^&*-+=_|{}[]:;'<>,.?/]
local pw_constraint = {
    { chars = 'abcdefghijklmnopqrstuvwxyz', repeat_times = 2 },
    { chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', repeat_times = 2 },
    { chars = '0123456789', repeat_times = 2 },
    { chars = '_+-&=!@#$%^*()', repeat_times = 2 },
}

local argparse = require "argparse"
local parser = argparse("rdpswd", "generate random password")
parser:argument("length", "the password length.", "16")
parser:flag("-w --weak", "donot contains the specific characters", false)
local args = parser:parse()

local pw_len = tonumber(args.length)
if pw_len == nil then
    print("wrong length, must be int")
    os.exit(1)
end

if args.weak then
    table.remove(pw_constraint)
end

local pw_table = {}

-- gen random seed 
function random_init() 
    local system_random_pool = assert(io.open("/dev/urandom", "rb"))
    local s = system_random_pool:read(4)
    local v = 0
    for i = 1, 4 do 
        v = 256 * v + s:byte(i)
    end
    local seed = tostring(os.time()):reverse():sub(1, 6) .. v
    math.randomseed(seed)
end

function is_exist(value, table)
  for k,v in ipairs(table) do
    if v == value then
        return true
    end
  end
  return false
end

function random_character(chars)
    local random_index = math.random(#chars)
    return string.sub(chars, random_index, random_index)
end

function uniq_update(chars, index, pw_table)
  while true do
    local char = random_character(chars)
    if not is_exist(char, pw_table) then
      pw_table[index] = char
      return index + 1
    end
  end
end

function generate_random_password(pw_len, pw_table)
    local index = 1
    while true do
      for _, v in pairs(pw_constraint) do
        for j = 1, v.repeat_times do 
          if index > pw_len then
            return
          end
          index = uniq_update(v.chars, index, pw_table)
        end
      end
    end
end

random_init()
generate_random_password(pw_len, pw_table)
print(table.concat(pw_table))
