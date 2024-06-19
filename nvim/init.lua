vim.cmd([[
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smartindent
set ma
tnoremap <ESC> <C-\><C-n>
set hlsearch
set nowrap
setlocal spell spelllang=de_20
]])

vim.opt.relativenumber=true


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
    {"nvim-lua/plenary.nvim"},
    {"ellisonleao/gruvbox.nvim"},
    {"kevinhwang91/promise-async"},
    {"kevinhwang91/nvim-ufo"},
    {'nvim-telescope/telescope.nvim', tag = '0.1.6', dependencies = {'nvim-lua/plenary.nvim'}},
    {"lukas-reineke/indent-blankline.nvim", main="ibl", opts={}},
    {"nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = {"c", "python", "bash", "lua", "verilog", "latex"},
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },  
        })
    end},
    --- Uncomment the two plugins below if you want to manage the language servers from neovim
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},
    
    {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
    {'neovim/nvim-lspconfig'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/nvim-cmp'},
    {'L3MON4D3/LuaSnip'},
    })

vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])

vim.cmd([[
    augroup remember_folds
    autocmd!
    autocmd BufWinLeave * mkview
    autocmd BufWinEnter * silent! loadview
    augroup END
]])

require("ibl").setup({
    scope = {show_start=false, show_end=false}
})

vim.api.nvim_set_hl(0, "@ibl.scope.char.1", {fg="#b16286"})
