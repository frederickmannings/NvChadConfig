vim.opt.colorcolumn = "80"
vim.g.poetv_auto_activate = 1
vim.g.poetv_set_environment = 1

local enable_providers = {
  "python3_provider",
}
for _, plugin in pairs(enable_providers) do
  vim.g["loaded_" .. plugin] = nil
  vim.cmd("runtime " .. plugin)
end

