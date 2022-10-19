local M = {}

local abbreviations = require 'vim-emoji-abbreviations.abbreviations'

function M.setup(options)
    vim.validate {
        options = {options, 'nil'},
    }

    abbreviations.create_abbreviations()
end

return M
