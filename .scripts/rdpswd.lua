#!/usr/bin/env lua
-- [a-z], [A-Z], [0-9], [()`~!@#$%^&*-+=_|{}[]:;'<>,.?/]
local pw_constraint = {
    ['abcdefghijklmnopqrstuvwxyz'] = 2,
    ['ABCDEFGHIJKLMNOPQRSTUVWXYZ'] = 2,
    ['0123456789'] = 2,
    ['_+-&=!@#$%^*()'] = 2,
}

local pw_len = 16
local pw_table = {}

-- gen random seed 
local system_random_pool = assert(io.open("/dev/urandom", "rb"))
local s = system_random_pool:read(4)
local v = 0
for i = 1, 4 do 
    v = 256 * v + s:byte(i)
end
local seed = tostring(os.time()):reverse():sub(1, 6) .. v
math.randomseed(seed)

function is_exist(value, tab)
  for k,v in ipairs(tab) do
    if v == value then
        return true
    end
  end
  return false
end

function uniq_update(fileds, count)
  while true do
    local random_no = math.random(#fileds)
    local pw_str = string.sub(fileds,random_no,random_no)
    if not is_exist(pw_str, pw_table) then
      pw_table[count] = pw_str
      return count + 1
    end
  end
end

local count = 1
while count <= pw_len do
  for fileds, must in pairs(pw_constraint) do
    for j = 1, must do 
      count = uniq_update(fileds, count)
    end
  end
end
print(table.concat(pw_table))
