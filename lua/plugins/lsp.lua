return {
	-- Language Support
	-- Added this plugin.
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v1.x',
		dependencies = {
			-- LSP Support
			{
				'neovim/nvim-lspconfig',
				config = function(_) 
					local has_telescope, telescope = pcall(require, 'telescope.builtin')
					vim.keymap.set("n", "<leader>cl", "<cmd>LspInfo<cr>", {desc = "Lsp Info"})
					if has_telescope then
						vim.keymap.set("n", "gd", function() telescope.lsp_definitions({reuse_win = true}) end, {desc = "Go to defenition"})
						vim.keymap.set("n", "gr", function() telescope.lsp_references({reuse_win = true}) end, {desc = "Go to references"})
						vim.keymap.set("n", "gI", function() telescope.lsp_implementations({reuse_win = true}) end, {desc = "Go to references"})
						vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {desc = "Go to declaration"})
						vim.keymap.set("n", "K", vim.lsp.buf.hover, {desc = "Go to declaration"})
					end

					require('lspconfig.ui.windows').default_options.border = 'rounded'
				end
			}, {'williamboman/mason-lspconfig.nvim'}, -- Optional

			-- Autocompletion
			{'hrsh7th/nvim-cmp'},         -- Required
			{'hrsh7th/cmp-nvim-lsp'},     -- Required
			{'hrsh7th/cmp-buffer'},       -- Optional
			{'hrsh7th/cmp-path'},         -- Optional
			{'saadparwaiz1/cmp_luasnip'}, -- Optional
			{'hrsh7th/cmp-nvim-lua'},     -- Optional

			-- Snippets
			{'L3MON4D3/LuaSnip'},             -- Required
			{'rafamadriz/friendly-snippets'}, -- Optional
		},
		config = function(_)
			local lsp = require('lsp-zero')
			lsp.preset("recommended")
			lsp.ensure_installed({
				"tsserver",
				"gopls",
				"lua_ls",
				"eslint",
				"vimls",
				"rust_analyzer",
			})

			require('mason').setup({})
			require('mason-lspconfig').setup({
				handlers = {
					lsp.default_setup,
				},
			})

			lsp.setup()

			vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
			vim.lsp.diagnostic.on_publish_diagnostics, {
				signs = false,
				virtual_text = true,
				underline = false,
			}
			)
		end
	},
	{
		'williamboman/mason.nvim',
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		build = ":MasonUpdate",
		opts = {
			ui = {
				border = 'rounded',
			},
		},
	},
}

