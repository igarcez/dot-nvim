-- Nicer filetree than NetRW
return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("neo-tree").setup({
                filesystem = {
                    filtered_items = {
                        visible = true,
                        hide_dot_files = false,
                        hide_gitignored = false
                    }
                }
            })
			require("helpers.keys").map(
				{ "n", "v" },
				"<leader>e",
				"<cmd>NeoTreeRevealToggle<cr>",
				"Toggle file explorer"
			)
		end,
	},
}
