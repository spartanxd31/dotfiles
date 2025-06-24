
return {
  -- This plugin handles LSP server setup for LazyVim
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers.clangd = {
        mason = false,
      }
    end,
  },
}
