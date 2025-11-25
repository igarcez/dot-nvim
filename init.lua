-- Handle plugins with lazy.nvim
require("core.lazy")

-- General Neovim keymaps
require("core.keymaps")

-- Other options
require("core.options")

-- custom config
local o = vim.opt

o.colorcolumn = "80"
o.clipboard = "unnamedplus"
