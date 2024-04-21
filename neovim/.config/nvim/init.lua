local vim = vim
local Plug = vim.fn['plug#']

vim.opt.swapfile = false

vim.opt.syntax = on

vim.opt.shortmess:append({ I = true })
vim.opt.mouse:remove({ 'a' })

vim.opt.history = 10000

vim.opt.ttyfast = true
vim.opt.belloff = 'all'
vim.opt.lazyredraw = true

vim.opt.hidden = true

vim.opt.display = 'lastline'
vim.opt.ruler = true
vim.opt.laststatus = 2
vim.opt.showcmd = true

vim.opt.completeopt = 'menuone'

vim.opt.wildmenu = true
vim.opt.wildmode = 'longest:full,full'

vim.opt.splitright = true

vim.opt.autowrite = true
vim.opt.autoread = true

vim.opt.list = true
vim.opt.listchars = { extends = '⇒', precedes = '⇐', tab = '>.', trail = '␣' }
vim.opt.nrformats:remove({ 'octal' })

vim.opt.formatoptions:append({ j = true })

vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.shiftround = true

vim.opt.textwidth = 130

vim.opt.clipboard = 'unnamedplus'

vim.call('plug#begin')

Plug('bluz71/vim-moonfly-colors', { branch = 'legacy', as = 'moonfly' })

vim.call('plug#end')

vim.cmd [[ set background=dark ]]
vim.cmd [[ colorscheme moonfly ]]
