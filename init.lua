-- Global variables
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.colorscheme = "monokai-nightasty"
-- Tabstops 
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
-- Enable line numbers and relative number
vim.opt.number = true
vim.opt.relativenumber = true
-- Enable search results highlighting
vim.opt.hlsearch = true
-- Enable mouse
vim.opt.mouse = 'a'
vim.opt.breakindent = true
vim.opt.undofile = true
-- Ignoring case while searching
vim.opt.ignorecase = true
vim.opt.updatetime = 250
vim.opt.timeout = true
vim.opt.timeoutlen = 300
vim.opt.completeopt = 'menuone,noselect'
vim.opt_global.completeopt = { "menuone", "noinsert", "noselect" }
vim.opt.termguicolors = true

-- Install Lazy plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({{ import = "plugins" }})

-- Setting colorscheme
if vim.g.colorscheme == nil then
	vim.g.colorscheme = "default"
end
pcall(vim.cmd, "colorscheme " ..  vim.g.colorscheme)

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
	vim.keymap.set("n", "<leader>gc", telescope.git_commits, { desc = "[G]it [Commits]" })
end

-- Close current buffer
vim.keymap.set("n", "<M-w>", ":e #<CR>", { desc = "Close current buffer" })

-- Jump to previous position of the file
vim.api.nvim_create_autocmd({'BufReadPost'},
{
	pattern = {'*'},
	callback = function()
		local ft = vim.opt_local.filetype:get()
		-- don't apply to git messages
		if (ft:match('commit') or ft:match('rebase')) then
			return
		end
		-- get position of last saved edit
		local markpos = vim.api.nvim_buf_get_mark(0,'"')
		local line = markpos[1]
		local col = markpos[2]
		-- if in range, go there
		if (line > 1) and (line <= vim.api.nvim_buf_line_count(0)) then
			vim.api.nvim_win_set_cursor(0,{line,col})
		end
	end
}
)
