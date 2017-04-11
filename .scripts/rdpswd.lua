#!/usr/bin/env lua

local ascii = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
local digits = '0123456789'
local special_chars = '_+-&=!@#$%^*()'

local fileds = ascii .. digits .. special_chars
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

for i = 1, pw_len do 
    local random_no = math.random(#fileds)
    local pw_str = string.sub(fileds,random_no,random_no)
    pw_table[i] = pw_str
end
print(table.concat(pw_table))
