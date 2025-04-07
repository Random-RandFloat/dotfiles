-- Setup colors.
vim.cmd([[colorscheme evening]])
vim.cmd([[highlight Normal ctermbg=NONE guibg=NONE]])
vim.cmd([[highlight Comment cterm=italic gui=italic]])
vim.cmd([[highlight EndOfBuffer ctermbg=NONE guibg=NONE]])
vim.cmd([[highlight WinSeparator ctermfg=white ctermbg=NONE guifg=white guibg=NONE]])
vim.cmd([[highlight StatusLine ctermfg=black guifg=black]])
vim.cmd([[highlight Visual ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE cterm=inverse gui=inverse]])
-- Setup other misc things.
vim.opt.shell = "/usr/bin/zsh"
vim.opt.termguicolors = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
vim.opt.termguicolors = true

-- Bindings
local map = vim.api.nvim_set_keymap
local opts = {noremap=true, silent=true}
map("n", "<A-,>", "<Cmd>BufferPrevious<CR>", opts)
map("n", "<A-.>", "<Cmd>BufferNext<CR>", opts)
map("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", opts)
map("n", "<A->>", "<Cmd>BufferMoveNext<CR>", opts)
map("n", "<A-c>", "<Cmd>BufferClose<CR>", opts)

vim.keymap.set({"i", "s"}, "<Tab>", function()
	if vim.snippet.active({direction=1}) then
		return "<Cmd>lua vim.snippet.jump(1)<CR>"
	else
		return "<Tab>"
	end
end, {expr=true, silent=true})

vim.keymap.set({"i", "s"}, "<S-Tab>", function()
	if vim.snippet.active({direction=-1}) then
		return "<Cmd>lua vim.snippet.jump(-1)<CR>"
	else
		return "<Tab>"
	end
end, {expr=true, silent=true})

map("n", "<A-/>", "<Cmd>Neotree<CR><C-W>l<Cmd>hor term<CR><Cmd>res 15<CR><C-W>r<C-W>k", opts)

map("n", "<C-E>", "<Cmd>lua vim.diagnostic.open_float()<CR>", opts)

vim.g.barbar_auto_setup = false -- Disable auto-setup

pcall(function()
	require("barbar").setup{
		exclude_name = {"zsh"},
	}

	require("nvim-treesitter.configs").setup {
		highlight = {
			enable = true,
		},
	}

	local cmp = require("cmp")
	local lspkind = require("lspkind")
	cmp.setup({
		snippet = {
			expand = function(args)
				vim.snippet.expand(args.body)
			end,
		},
		window = {
		},
		mapping = cmp.mapping.preset.insert({
			['<C-b>'] = cmp.mapping.scroll_docs(-4),
			['<C-f>'] = cmp.mapping.scroll_docs(4),
			['<C-Space>'] = cmp.mapping.complete(),
			['<C-e>'] = cmp.mapping.abort(),
			['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		}),
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
		}, {
			-- { name = "buffer" },
		}),
		formatting = {
			format = lspkind.cmp_format({
				mode = "symbol",
			}),
		},
	})

	local lsp = require("lspconfig")
	local capabilities = require("cmp_nvim_lsp").default_capabilities()
	lsp.rust_analyzer.setup({})
	lsp.gdscript.setup({})
	lsp.pyright.setup({})
	lsp.clangd.setup({
		capabilities = capabilities
	})
end)

vim.g.python_recommended_style = 0

-- Plugins
return require("packer").startup(function(use)

	use {
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		requires = { 
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		}
	}

	-- use "dense-analysis/ale"
	use "nvim-treesitter/nvim-treesitter"

	use "neovim/nvim-lspconfig"
	use "hrsh7th/cmp-nvim-lsp"
	use "hrsh7th/nvim-cmp"
	use "onsails/lspkind.nvim"
	use {
		"romgrk/barbar.nvim",
		branch = "v1.9.1",
		requires = {
			"lewis6991/gitsigns.nvim",
			"nvim-tree/nvim-web-devicons",
		}
	}

end)
