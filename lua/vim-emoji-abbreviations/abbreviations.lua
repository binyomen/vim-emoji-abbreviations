local M = {}

local emoji = require 'vim-emoji-abbreviations.emoji'

function M.create_abbreviations()
    for lhs, rhs in pairs(emoji) do

        -- Vim doesn't seem to support abbreviations that are longer than 52
        -- characters.
        if #lhs < 51 then
            vim.cmd.iabbrev {':' .. lhs .. ':', rhs}
        end
    end
end

return M
