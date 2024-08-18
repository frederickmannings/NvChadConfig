
local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local function get_python_path()
  local cwd = vim.fn.getcwd()
  return cwd .. '/.venv/bin/python'
end

local function get_mypy_path()
  local cwd = vim.fn.getcwd()
  return cwd .. '/.venv/bin/mypy'
end

local opts = {
  sources = {
    null_ls.builtins.formatting.gofumpt,
    null_ls.builtins.formatting.goimports_reviser,
    null_ls.builtins.formatting.golines,
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.diagnostics.mypy.with({
      command = get_mypy_path(),
      extra_args = function()
      return { "--python-executable", get_python_path()}
      end,
    }),
  },
  on_attach = function(client, bufnr)
    -- format on save functionality
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({
        group = augroup,
        buffer = bufnr,
      })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({bufnr=bufnr})
        end,
      })
    end
  end,
}

return opts

