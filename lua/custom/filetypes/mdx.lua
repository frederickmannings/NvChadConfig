vim.api.nvim_set_filetype("mdx") -- Set the filetype

-- (Optional) Customize highlighting or other settings specific to mdx files.
vim.cmd [[
  highlight link mdxString String
  highlight link mdxKeyword Keyword
]]

