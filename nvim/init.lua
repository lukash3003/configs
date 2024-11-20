vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.ma = true
vim.opt.hlsearch = true
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.spell = false

vim.cmd([[
tnoremap <ESC> <C-\><C-n>
setlocal spell spelllang=de_20
]])

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
    { 'sainnhe/gruvbox-material'},
    {"kevinhwang91/promise-async"},
    {"kevinhwang91/nvim-ufo"},
    {'nvim-lua/lsp-status.nvim'},
    {'nvim-telescope/telescope.nvim', tag = '0.1.6', dependencies = {'nvim-lua/plenary.nvim'}},
    {"lukas-reineke/indent-blankline.nvim", main="ibl", opts={}},
    {'norcalli/nvim-colorizer.lua'},
    {"nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = {'python', 'c', 'matlab'},
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },
        })
    end},
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},
    {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
    {'neovim/nvim-lspconfig'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/nvim-cmp'},
    {'L3MON4D3/LuaSnip'},
    {'nvim-lualine/lualine.nvim', dependencies = {'nvim-tree/nvim-web-devicons'}},
    {'chentoast/marks.nvim'},
    {'arkav/lualine-lsp-progress'},
})

vim.o.background = "dark"
vim.g.gruvbox_material_enable_italic = true
vim.cmd.colorscheme('gruvbox-material')

vim.api.nvim_create_autocmd({"BufWritePre"},{
    pattern = {"*"},
    command = [[%s/\s\+$//e]],
})

vim.api.nvim_create_user_command("VirtualBlock", function ()
    vim.opt.ve = "block"
    print("Entering Virtual Block mode")
end, {desc = "Set virtual block mode"})
vim.keymap.set("n", "<leader>vb", "<cmd>VirtualBlock<CR>", {noremap=true})

vim.api.nvim_create_user_command("VirtualNormal", function ()
    vim.opt.ve = ""
    print("Leaving Virtual Block mode")
end, {desc = "Set virtual block mode"})
vim.keymap.set("n", "<leader>vn", "<cmd>VirtualNormal<CR>", {noremap=true})
