vim.g.mapleader = " "

vim.opt.shiftwidth = 4  -- Number of spaces to use for each step of (auto)indent
vim.opt.tabstop = 4     -- Number of spaces that a <Tab> in the file counts for
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.smartindent = true -- Enable smart indentation

vim.opt.number = true
vim.opt.relativenumber = true


vim.diagnostic.config({
    virtual_text = true
})
