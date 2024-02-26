local configs = require("plugins.configs.lspconfig")
local on_attach = configs.on_attach
local capabilities = configs.capabilities

local lspconfig = require "lspconfig"
local util = require "lspconfig/util"

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
}

for _, serverName in ipairs(vim.tbl_keys(servers)) do
  lspconfig[serverName].setup(servers[serverName].setup)
end

