local cmp = require "cmp"

local plugins = {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "gopls",
        "gofumpt",
        "goimports_reviser",
        "golines",
        "lua-language-server",
        "jedi-language-server",
        "buf-language-server",
        "rust-analyzer",
        "typescript-language-server",
        "tailwindcss-language-server",
        "svelte-language-server",
        "eslint-lsp",
        "prettierd",
        "js-debug-adapter",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      opts = require "plugins.configs.treesitter"
      opts.ensure_installed = {
        "lua",
        "javascript",
        "typescript",
        "css",
        "go",
        "rust",
        "python",
        "markdown"
        }
    end,
    config  = function (_, opts)
      dofile(vim.g.base46_cache .. "syntax")
      require("nvim-treesitter.configs").setup(opts)
      -- tell treesitter to use the markdown parser for mdx files
      vim.treesitter.language.register('markdown', 'mdx')
    end
  },
  {
    "windwp/nvim-ts-autotag",
    ft = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact"
    },
    config = function ()
      require("nvim-ts-autotag").setup()
    end
  },
  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    ft = {"python", "go"},
    opts = function ()
      return require "custom.configs.null-ls"
    end
  },
  {
    "nvim-neotest/nvim-nio",
  },
  {
    "mfussenegger/nvim-dap",
    config = function ()
      require "custom.configs.dap"
      require("core.utils").load_mappings("dap")
    end,
    init = function()
      require("core.utils").load_mappings("dap")
    end
  },

  {
    "rcarriga/nvim-dap-ui",
    event="VeryLazy",
    dependencies="mfussenegger/nvim-dap",
    config = function ()
      local dap = require("dap")
      local dapui = require("dapui")
      require("dapui").setup()
      dap.listeners.after.event_initialized["dapui_config"] = function ()
       dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function ()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function ()
        dapui.close()
      end
    end
  },
  {
    "dreamsofcode-io/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function(_, opts)
      require("dap-go").setup(opts)
      require("core.utils").load_mappings("dap_go")
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  -- {
  --   "mrcjkb/rustaceanvim",
  --   version = "^4",
  --   ft = { "rust" },
  --   dependencies = "neovim/nvim-lspconfig",
  --   config = function()
  --     require "custom.configs.rustaceanvim"
  --   end
  -- },
  {
    'saecki/crates.nvim',
    ft = {"toml"},
    config = function(_, opts)
      local crates  = require('crates')
      crates.setup(opts)
      require('cmp').setup.buffer({
        sources = { { name = "crates" }}
      })
      crates.show()
      require("core.utils").load_mappings("crates")
    end,
  },
    {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function ()
      vim.g.rustfmt_autosave = 1
    end
  },
  {
    "simrat39/rust-tools.nvim",
    ft="rust",
    dependencies = "neovim/nvim-lspconfig",
    opts=function ()
      return require "custom.configs.rust-tools"
    end,
    confg = function(_, opts)
      require('rust-tools').setup(opts)
    end
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    lazy = false,
    config = function(_, opts)
      require("nvim-dap-virtual-text").setup()
    end
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function()
      local M = require "plugins.configs.cmp"
      M.completion.completeopt = "menu,menuone,noselect"
      M.mapping["<CR>"] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = false,
      }
      table.insert(M.sources, {name = "crates"})
      return M
    end,
  },
  -- {
  --   "jose-elias-alvarez/null-ls.nvim",
  --   ft = "go",
  --   opts = function()
  --     return require "custom.configs.null-ls"
  --   end,
  -- },
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    config = function(_, opts)
      require("gopher").setup(opts)
      require("core.utils").load_mappings("gopher")
    end,
    build = function()
      vim.cmd [[silent! GoInstallDeps]]
    end,
  },
  {
    "voldikss/vim-floaterm",
    event="VeryLazy",
    keys = {
      { "<leader>o", "<cmd>FloatermToggle<cr>", desc = "Show floating terminal"},
    }
  },
  {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && yarn install",
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
    vim.g.mkdp_browser="/usr/bin/google-chrome"
    vim.g.mkdp_echo_preview_url=1
    vim.g.mkdp_port='6060'
  end,
  ft = { "markdown" },
  },
  {
    "danymat/neogen",
    config = true,
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*",
    ft = {
      "python",
      "typescript",
      "golang"
    }
  },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',  -- Ensure promise-async is loaded
    config = function()
      -- General settings
      vim.o.foldcolumn = '1'  -- Display fold column
      vim.o.foldlevel = 99  -- Start with all folds open
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      -- -- Key mappings for folding
      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

      -- Option 2: Setup with native Neovim LSP
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
      }
      local language_servers = require("lspconfig").util.available_servers()
      for _, ls in ipairs(language_servers) do
        require('lspconfig')[ls].setup({
          capabilities = capabilities
        })
      end
      require('ufo').setup()
    end,
    ft = {
      "python",
      "typescrip",
      "golang",
    }
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    ft = {"go"},
    config = function(_, opts) require'lsp_signature'.setup(opts) end
  },
  {
    "simrat39/inlay-hints.nvim",
    event = "VeryLazy",
    opts = {},
    ft = {"go"}
  }
  -- {
  --   "supermaven-inc/supermaven-nvim",
  --   ft = {"python", "golang", "typescript"},
  --   config = function()
  --     require("supermaven-nvim").setup({})
  --   end,
  -- },
}

return plugins
