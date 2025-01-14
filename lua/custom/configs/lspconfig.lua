local configs = require("plugins.configs.lspconfig")
local on_attach = configs.on_attach
local capabilities = configs.capabilities

local lspconfig = require "lspconfig"
local util = require "lspconfig/util"
local ih = require "inlay-hints"


local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = {vim.api.nvim_buf_get_name(0)},
  }
  vim.lsp.buf.execute_command(params)
end

local function get_python_path()
  local cwd = vim.fn.getcwd()
  return cwd .. '/.venv/bin/python'
end

local servers = {
  gopls = {
    setup = {
      on_attach = function(c, b)
        ih.on_attach(c, b)
      end,
      capabilities = capabilities,
      cmd = {"gopls"},
      filetypes = {"go", "gomod", "gowork", "gotmpl"},
      root_dir = util.root_pattern("go.work", "go.mod", ".git"),
      settings = {
        gopls = {
          completeUnimported = true,
          usePlaceholders = true,
          hints = {
            assignVariableTypes = true,
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
          },
          -- analyses = {
          --   unusedParams = true,
          --   fieldalignment = true,
          --   unusedwrite = true,
          --   useany = true,
          -- },
          buildFlags ={"-tags=tools"}
        }
      }
    },
  },
  jedi_language_server = {
    setup = {
      on_attach = on_attach,
      capabilities = capabilities,
      init_options = {
        workspace = {
          environmentPath = get_python_path()
        }
      }
    }
  },
  ts_ls = {
    setup = {
      on_attach = on_attach,
      capabilities = capabilities,
      init_options = {
        preferences = {
          disableSuggestions = false,
        }
      },
      commands = {
        OrganizeImports = {
          organize_imports,
          description = "Organise Imports",
        }
      }
    }
  },
  tailwindcss = {
    setup = {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  },
  eslint = {
    setup = {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  },
  svelte = {
    setup = {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  }
}

for _, serverName in ipairs(vim.tbl_keys(servers)) do
  lspconfig[serverName].setup(servers[serverName].setup)
end

