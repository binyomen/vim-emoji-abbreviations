local M = {}

local abbreviations = require 'vim-emoji-abbreviations.abbreviations'
local cmp = require 'vim-emoji-abbreviations.cmp'

local function default(v, default)
    if v == nil then
        return default
    else
        return v
    end
end

function M.setup(options)
    local options = default(options, {})

    vim.validate {
        options = {options, 'table'},
        ['options.enable_abbreviations'] = {options.enable_abbreviations, 'boolean', true},
        ['options.enable_nvim_cmp'] = {options.enable_nvim_cmp, 'boolean', true},
    }

    local enable_abbreviations = default(options.enable_abbreviations, true)
    local enable_nvim_cmp = default(options.enable_nvim_cmp, true)

    if enable_abbreviations then
        abbreviations.create_abbreviations()
    end

    if enable_nvim_cmp then
        cmp.register_completion_source()
    end
end

return M
