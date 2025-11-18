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
  {
    -- The main DAP (Debug Adapter Protocol) plugin
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")

      -- This line is the key change.
      -- It tells nvim-dap to automatically look for and load a
      -- .vscode/launch.json file in your project's root.
      require("dap.ext.vscode").load_launchjs(nil, {
        -- This maps the 'type' in launch.json to the adapter name
        -- in nvim-dap. 'codelldb' is used for C, C++, and Rust.
        codelldb = { "c", "cpp", "rust" },
      })

      -- Define the debug configuration for codelldb (C, C++, Rust)
      -- This tells dap HOW to launch your program
      -- dap.configurations.cpp = {
      --   {
      --     name = "Launch file",
      --     type = "codelldb", -- This MUST match the adapter name
      --     request = "launch",
      --     program = function()
      --       -- Asks you for the compiled program to debug
      --       return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      --     end,
      --     cwd = "${workspaceFolder}",
      --     stopOnEntry = false,
      --   },
      -- }
      -- -- Use the same configuration for C and Rust
      -- dap.configurations.c = dap.configurations.cpp
      -- dap.configurations.rust = dap.configurations.cpp
      --
      -- Add your keymaps for debugging
      vim.keymap.set("n", "<F5>", function()
        require("dap").continue()
      end)
      vim.keymap.set("n", "<F6>", function()
        require("dap").step_over()
      end)
      vim.keymap.set("n", "<F7>", function()
        require("dap").step_into()
      end)
      vim.keymap.set("n", "<F8>", function()
        require("dap").step_out()
      end)
      vim.keymap.set("n", "<leader>b", function()
        require("dap").toggle_breakpoint()
      end)
      vim.keymap.set("n", "<leader>du", function()
        require("dapui").toggle()
      end)
    end,
  },
  {
    -- This plugin bridges Mason (which installs codelldb) and nvim-dap
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "mfussenegger/nvim-dap" }, -- Make sure dap loads first
    config = function()
      require("mason-nvim-dap").setup({
        -- This line ensures codelldb is installed and configured for nvim-dap
        ensure_installed = { "codelldb" },
        handlers = {}, -- Let the plugin use default settings
      })
    end,
  },
  {
    -- Optional: A UI for nvim-dap
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" }, -- Make sure dap loads first
    config = function()
      require("dapui").setup()
      require("lazydev").setup({
        library = { "nvim-dap-ui" },
      })
    end,
  },
  ---
  -- END: DEBUGGING SECTION
  ---
}
