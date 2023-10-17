return {
	{
		'nvim-telescope/telescope.nvim', branch = '0.1.x',
		dependencies = { 
			'nvim-lua/plenary.nvim' 
		},
		config = function(_, _) 
			-- Setting telescope mappings
			local telescope_ok, telescope = pcall(require, 'telescope.builtin')
			if telescope_ok then
				vim.keymap.set("n", "<leader>?", telescope.oldfiles, { desc = "[?] Find recently opened files" })
				vim.keymap.set("n", "<leader><space>", telescope.buffers, { desc = "[ ] Find existing buffers" })
				vim.keymap.set("n", "<leader>f", function()
					telescope.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
						winblend = 10,
						previewer = false,
					}))
				end, { desc = "[/] Fuzzily search in current buffer" })

				vim.keymap.set("n", "<leader>p", telescope.find_files, { desc = "[S]earch [F]iles" })
				vim.keymap.set("n", "<M-p>", telescope.find_files, { desc = "[S]earch [F]iles" })
				vim.keymap.set("n", "<leader>sh", telescope.help_tags, { desc = "[S]earch [H]elp" })
				vim.keymap.set("n", "<leader>sw", telescope.grep_string, { desc = "[S]earch current [W]ord" })
				vim.keymap.set("n", "<leader>sg", telescope.live_grep, { desc = "[S]earch by [G]rep" })
				vim.keymap.set("n", "<leader>sd", telescope.diagnostics, { desc = "[S]earch [D]iagnostics" })
				vim.keymap.set("n", "<leader>gc", telescope.git_bcommits, { desc = "[G]it [Commits]" })
			end
		end
	}
}

