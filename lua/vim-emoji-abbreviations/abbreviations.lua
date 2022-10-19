local M = {}

local emoji = require 'vim-emoji-abbreviations.emoji'

function M.create_abbreviations()
    for lhs, rhs in pairs(emoji) do
        vim.cmd.iabbrev {':' .. lhs .. ':', rhs}
    end
end

return M
