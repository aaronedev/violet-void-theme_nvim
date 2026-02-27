-- Violet Void Light Theme

vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

vim.o.background = "light"
require("violet-void").load({ style = "void-light" })
