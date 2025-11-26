-- Telescope fuzzy finding (all the things)
return {
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond = vim.fn.executable("make") == 1
            }
        },
        config = function()
            require("telescope").setup({
                defaults = {
                    mappings = {i = {["<C-u>"] = false, ["<C-d>"] = false}},
                    vimgrep_arguments = {
                      "rg",
                      "--follow",        -- Follow symbolic links
                      "--hidden",        -- Search for hidden files
                      "--no-heading",    -- Don't group matches by each file
                      "--with-filename", -- Print the file path with the matched lines
                      "--line-number",   -- Show line numbers
                      "--column",        -- Show column numbers
                      "--smart-case",    -- Smart case search

                      -- Exclude some patterns from search
                      "--glob=!**/.git/*",
                      "--glob=!**/.idea/*",
                      "--glob=!**/.vscode/*",
                      "--glob=!**/build/*",
                      "--glob=!**/dist/*",
                      "--glob=!**/yarn.lock",
                      "--glob=!**/package-lock.json",
                      "--glob=!**/node_modules/*",
                    },
                }
            })

            -- Enable telescope fzf native, if installed
            pcall(require("telescope").load_extension, "fzf")

            local map = require("helpers.keys").map
            map("n", "<leader>fr", require("telescope.builtin").oldfiles,
                "Recently opened")
            map("n", "<leader><space>", require("telescope.builtin").buffers,
                "Open buffers")
            map("n", "<leader>/", function()
                -- You can pass additional configuration to telescope to change theme, layout, etc.
                require("telescope.builtin").current_buffer_fuzzy_find(require(
                                                                           "telescope.themes").get_dropdown(
                                                                           {
                        winblend = 10,
                        previewer = false
                    }))
            end, "Search in current buffer")

            map("n", "<leader>sf", require("telescope.builtin").find_files,
                "Files")
            map("n", "<leader>sh", require("telescope.builtin").help_tags,
                "Help")
            map("n", "<leader>sw", require("telescope.builtin").grep_string,
                "Current word")
            map("n", "<leader>sg", require("telescope.builtin").live_grep,
                "Grep")
            map("n", "<leader>sd", require("telescope.builtin").diagnostics,
                "Diagnostics")

            map("n", "<C-p>", require("telescope.builtin").keymaps,
                "Search keymaps")
        end
    }
}
