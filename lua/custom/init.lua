vim.opt.relativenumber=true
vim.opt.scrolloff=88
vim.g.dap_virtual_text = true

vim.keymap.set('t', '<C-space>', "<C-\\><C-n><C-w>k",{silent = true})
vim.keymap.set('n', '<space>i', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
