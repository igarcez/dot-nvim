-- Themes
return {
    "typicode/bg.nvim",

    "savq/melange-nvim", {
        "rebelot/kanagawa.nvim",
        name = "kanagawa",
        config = function()
            require('kanagawa').setup({
                theme = "dragon", -- Load "wave" theme
                background = { -- map the value of 'background' option to a theme
                    dark = "dragon", -- try "dragon" !
                    light = "lotus"
                }
            })

            -- setup must be called before loading
            vim.cmd("colorscheme kanagawa")
        end
    }
}
