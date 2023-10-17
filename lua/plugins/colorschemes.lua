return {
	-- Monokai Nightasty
	{
		"polirritmico/monokai-nightasty.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			on_highlights = function(highlights, colors)
				highlights.LineNr = { fg = colors.grey }
				highlights.CursorLineNr = { fg = colors.yellow }
			end,
		}
	}
}
