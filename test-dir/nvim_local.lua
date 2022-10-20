return {
    on_config_end = function()
        vim.o.rtp = vim.o.rtp .. [[,~\repos\vim-emoji-abbreviations\]]
        require('vim-emoji-abbreviations').setup()
    end,
}
