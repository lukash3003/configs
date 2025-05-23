vim.cmd([[
tnoremap <ESC> <C-\><C-n>
inoremap <S-Tab> <C-V><Tab>
]])

--setlocal spell spelllang=de_20
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
--vim.opt.spelllang="de_20"
--vim.opt.spell = false

vim.keymap.set("", "<up>", "<nop>", { noremap = true })
vim.keymap.set("", "<down>", "<nop>", { noremap = true })
vim.keymap.set("i", "<up>", "<nop>", { noremap = true })
vim.keymap.set("i", "<down>", "<nop>", { noremap = true })

vim.opt.mouse = ""

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
    {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    {'nvim-telescope/telescope.nvim', tag = '0.1.6', dependencies = {'nvim-lua/plenary.nvim'}},
    {"lukas-reineke/indent-blankline.nvim", main="ibl", opts={}},
    {'norcalli/nvim-colorizer.lua'},
    {"nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = {'python', 'c', 'matlab', 'markdown'},
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
    {"lervag/vimtex", lazy = false, init = function() vim.g.vimtex_view_method = "zathura" vim.g.vimtex_quickfix_open_on_warning = 0 end }
})

vim.o.background = "dark"
vim.g.gruvbox_material_enable_italic = true
vim.cmd.colorscheme('gruvbox-material')

--vim.api.nvim_create_autocmd({"BufWritePre"},{
--    pattern = {"*"},
--    command = [[%s/\s\+$//e]],
--})
--
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
vim.keymap.set("v", '"*y', '"+y', {noremap=true})
