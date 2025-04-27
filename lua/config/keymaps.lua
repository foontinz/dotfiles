-- Telescope mappings
vim.keymap.set('n', '<Esc>', ':noh<CR>', { silent = true })
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'find unignored files' })
vim.keymap.set('n', '<leader>fa', '<cmd>Telescope find_files hidden=true<cr>', { desc = 'find ignored files' })

