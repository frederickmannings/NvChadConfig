local plugins = {
  {
    "vim-crystal/vim-crystal",
    ft="crystal",
    config = function(_)
      vim.g.crystal_auto_format = 1
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "rust-analyzer",
        "jedi-language-server",
      },
    },
  },
  {
      "rust-lang/rust.vim",
      ft="rust",
      init = function ()
        vim.g.rustfmt_autosave = 1
      end
  },
  {
    "simrat39/rust-tools.nvim",
    ft="rust",
    dependencies = "neovim/nvim-lspconfig",
    opts = function ()
      return require "custom.configs.rust-tools"
    end,
    config = function (_, opts)
      require('rust-tools').setup(opts)
   end,
  },
  {
    "mfussenegger/nvim-dap",
  },
  {
    "saecki/crates.nvim",
    ft = {"rust", "toml"},
    config = function (_, opts)
      local crates = require('crates')
      crates.setup(opts)
      crates.show()
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function ()
      local M = require "plugins.configs.cmp"
      table.insert(M.sources, {name="crates"})
      return M
    end,
  },
  {
    "davidhalter/jedi-vim",
    ft="python",
  },
  {
    'petobens/poet-v',
    ft="python",
  },
  {
    'neovim/pynvim',
  },
  {
    "nvie/vim-flake8",
    ft="python",
  },
  {
    "stsewd/isort.nvim",
    ft="python",
  },
  {
    "averms/black-nvim",
    ft="python",
  },
  {
    "Integralist/vim-mypy",
    ft="python",
  }
}

return plugins
