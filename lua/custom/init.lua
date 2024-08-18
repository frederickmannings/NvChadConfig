vim.opt.relativenumber=true
vim.opt.scrolloff=88
vim.g.dap_virtual_text = true

vim.keymap.set('t', '<C-space>', "<C-\\><C-n><C-w>k",{silent = true})
vim.keymap.set('t', '<C-o>', "<C-\\><C-n><cmd>FloatermHide<cr>",{silent = true})
vim.keymap.set('n', '<leader>i', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- Markdown preview config
vim.g.mkdp_browser="/usr/bin/google-chrome"
vim.g.mkdp_echo_preview_url=1
vim.g.mkdp_port='6060'

-- Editor config
vim.wo.wrap = false


vim.filetype.add({
  extension = {
    mdx = "mdx",
  }
})
