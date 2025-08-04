return {
	{
		"catppuccin/nvim", 
		name = "catppuccin", 
		priority = 1000,
		init = function()
			vim.cmd.colorscheme("catppuccin") 
		end,
    config = function(_, opts)
      require("catppuccin").setup(opts)

      if opts.transparent_background then
        vim.api.nvim_set_h1(0, "Normal", { bg = "none" })
        vim.api.nvim_set_h1(0, "NormalFloat", { bg = "none" })
      end
    end,
		opts = {
			flavour = "mocha",  -- latte, frappe, macchiato, mocha
--      transparent_background = true,
			integrations = {
				telescope = true,
				which_key = true,
				neotree = true,
				cmp = true,
			},
		},
	},


	-- { "ellisonleao/gruvbox.nvim" },
	-- {
	-- 	"LazyVim/LazyVim",
	-- 	opts = {
	-- 		colorscheme = "catpuuccin",
	-- 	}
	 -- }
}



