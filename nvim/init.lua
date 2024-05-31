vim.cmd([[
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smartindent
set ma
tnoremap <ESC> <C-\><C-n>

set number
set hlsearch
set nowrap
]])




vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
    {"nvim-lua/plenary.nvim"},
    {"ellisonleao/gruvbox.nvim"},
    {"kevinhwang91/promise-async"},
    {"kevinhwang91/nvim-ufo"},
    { 'nvim-telescope/telescope.nvim', tag = '0.1.6', dependencies = { 'nvim-lua/plenary.nvim' } },
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"}
})
