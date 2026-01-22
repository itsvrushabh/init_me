--- Autopairs and Indent Blankline Configuration
--- Sets up nvim-autopairs for automatic closing of pairs
--- and indent-blankline.nvim for indentation guides.
return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			-- test is working
		}, -- this will use the default setup
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {},
	},
}
