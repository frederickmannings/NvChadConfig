local configs = require("plugins.configs.lspconfig")
local on_attach = configs.on_attach
local capabilities = configs.capabilities

local lspconfig = require "lspconfig"
local util = require "lspconfig/util"


local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = {vim.api.nvim_buf_get_name(0)},
  }
  vim.lsp.buf.execute_command(params)
end



local servers = {
  gopls = {
    setup = {
      on_attach = on_attach,
      capabilities = capabilities,
      cmd = {"gopls"},
      filetypes = {"go", "gomod", "gowork", "gotmpl"},
      root_dir = util.root_pattern("go.work", "go.mod", ".git"),
      settings = {
        gopls = {
          completeUnimported = true,
          usePlaceholders = true,
          analyses = {
            unusedParams = true,
            fieldalignment = true,
            unusedwrite = true,
            useany = true,
          }
        }
      }
    },
  },
  jedi_language_server = {
    setup = {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  },
  bufls = {
    setup = {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  },
  tsserver = {
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
  }
}

for _, serverName in ipairs(vim.tbl_keys(servers)) do
  lspconfig[serverName].setup(servers[serverName].setup)
end

