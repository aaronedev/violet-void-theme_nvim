-- Violet Void Theme - Lua Syntax Test
-- This file tests all Lua syntax highlighting

-- Comments
-- Single line comment
--[[ Multi-line
   comment ]]
--- Doc comment

-- Keywords
local function test()
    if true then
        return nil
    elseif false then
        return false
    else
        return true
    end
end

-- Variables
local string_var = "double quoted string"
local string_var2 = 'single quoted string'
local string_var3 = [[multi-line
string]]
local number = 42
local float = 3.14
local hex = 0xFF
local scientific = 1e10
local boolean = true
local nil_value = nil
local func = function() end

-- Tables
local table = {
    key = "value",
    ["bracket"] = "key",
    [1] = "indexed",
    nested = {
        deep = "value"
    }
}

-- Operators
local a = 1 + 2 - 3 * 4 / 5 % 6
local b = 1 == 2 and 3 or 4
local c = 1 ~= 2
local d = 1 < 2 and 2 > 1
local e = 1 <= 2 and 2 >= 1
local f = "a" .. "b"
local g = #{1, 2, 3}

-- Function calls
print("hello")
string.format("%s", "test")
vim.api.nvim_command("echo")

-- Method calls
local obj = {}
function obj:method()
    self.field = "value"
end

-- Error highlighting (intentional)
local broken = function(,
