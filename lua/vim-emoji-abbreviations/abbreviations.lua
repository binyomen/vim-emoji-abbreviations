local emoji = require 'vim-emoji-abbreviations.emoji'

for lhs, rhs in pairs(emoji) do
    vim.cmd.iabbrev {':' .. lhs .. ':', rhs}
end
