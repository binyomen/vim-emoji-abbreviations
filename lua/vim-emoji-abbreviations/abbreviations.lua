local M = {}

local emoji = require 'vim-emoji-abbreviations.emoji'

function M.create_abbreviations()
    for _, item in ipairs(emoji) do
        vim.cmd.iabbrev(item.word, item.character)
    end
end

return M
