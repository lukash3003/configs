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

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {

      'nvim-telescope/telescope.nvim', tag = '0.1.4',
    -- or                            , branch = '0.1.x',
      requires = { {'nvim-lua/plenary.nvim'} }
    }
    use { "ellisonleao/gruvbox.nvim" }
    use ( 'nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
end)


