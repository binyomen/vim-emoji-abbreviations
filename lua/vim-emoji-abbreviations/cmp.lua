local M = {}

local emoji = require 'vim-emoji-abbreviations.emoji'

local source = {}

function source.get_trigger_characters()
    return {':'}
end

function source.get_keyword_pattern()
    return [[\%(\s\|^\)\zs:[[:alnum:]_\-\+]*:\?]]
end

function source.complete(self, params, callback)
    if not vim.regex(self.get_keyword_pattern() .. '$'):match_str(params.context.cursor_before_line) then
        return callback()
    end

    callback(emoji)
end

function M.register_completion_source()
    local succeeded, cmp = pcall(require, 'cmp')
    if succeeded then
        cmp.register_source('vim-emoji-abbreviations', source)
    end
end

return M
