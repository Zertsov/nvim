-- [[File Management]]
-- The following is a quick way to reference some basic file management stuff.
--
-- `a`: (a)dd a file.
-- `r`: (r)ename a file.
-- `<C-r>`: (r)ename a file, regardless of it's original name.
-- `d`: (d)elete the selected file or dir. If it's a dir, it'll delete all contents of said dir.
-- `x`: Cut to clipboard. Can cut a dir. If it's a dir, it'll cut all contents of the dir.
-- `c`: (c)opy to clipboard.
-- `p`: (p)aste.
-- `y`: Copy only filename to clipboard.
-- `Y`: Copy relative path.
-- `gy`:

-- Since we use nvim-tree, disable Vim's default netrw file explorer
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Navigate through splits
vim.keymap.set('n', '<C-h>', '<C-W>h')
vim.keymap.set('n', '<C-j>', '<C-W>j')
vim.keymap.set('n', '<C-k>', '<C-W>k')
vim.keymap.set('n', '<C-l>', '<C-W>l')

local function custom_on_attach(bufnr)
	local api = require "nvim-tree.api"
	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	-- default mappings
	api.config.mappings.default_on_attach(bufnr)

	-- custom mappings
	vim.keymap.set('n', 'v', api.node.open.vertical, opts("Open: [V]ertical split open"))
	vim.keymap.set('n', 't', api.node.open.horizontal, opts("Open: [T]op split open"))
end

return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		-- If the tree is closed, open it and focus it. Otherwise just focus
		{ "<leader>e", ":NvimTreeFocus<CR>", desc = "NvimTree: [e]xplorer" },
		-- TODO: This finder doesn't work. Use Telescope file search instead `<leader>sf`
		-- { "<leader>f", ":NvimTreeFindFile",  desc = "NvimTree: [f]ind file" },
	},
	config = function()
		require("nvim-tree").setup {
			on_attach = custom_on_attach,
			sort_by = "case_sensitive",
			filters = {
				dotfiles = false
			},
		}
	end,
}
