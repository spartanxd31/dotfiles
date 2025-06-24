-- ~/.config/nvim/lua/plugins/colorscheme-gruvbox.lua

return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000, -- Load before other start plugins
    config = function()
      require("gruvbox").setup({
        contrast = "hard", -- or "soft", "medium"
        transparent_mode = true,
      })
      vim.cmd([[colorscheme gruvbox]])
    end,
  },
}

