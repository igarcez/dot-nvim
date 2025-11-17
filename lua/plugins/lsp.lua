-- LSP Configuration & Plugins
return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim",
            {"j-hui/fidget.nvim", tag = 'legacy'}, "folke/neodev.nvim",
            "RRethy/vim-illuminate", "hrsh7th/cmp-nvim-lsp"
        },
        config = function()
            -- Set up Mason before anything else
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {"lua_ls", "ts_ls"},
                automatic_installation = true,
                automatic_enable = true
            })

            -- Quick access via keymap
            require("helpers.keys").map("n", "<leader>M", "<cmd>Mason<cr>",
                                        "Show Mason")

            -- Neodev setup before LSP config
            require("neodev").setup()

            -- Turn on LSP status information
            require("fidget").setup()

            -- Set up cool signs for diagnostics
            local signs = {Error = "x ", Warn = "! ", Hint = "* ", Info = "i "}
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = ""})
            end

            -- Diagnostic config
            local config = {
                virtual_text = false,
                signs = {active = signs},
                update_in_insert = true,
                underline = true,
                severity_sort = true,
                float = {
                    focusable = true,
                    style = "minimal",
                    border = "rounded",
                    source = "always",
                    header = "",
                    prefix = ""
                }
            }
            vim.diagnostic.config(config)

            vim.lsp.config("lua_ls", {
                settings = {Lua = {diagnostics = {globals = {"vim"}}}}
            })
        end
    }
}
