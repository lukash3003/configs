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
set termguicolors
]])

vim.opt.relativenumber=true
vim.opt.number=true


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
          ensure_installed = {},
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
    {'chentoast/marks.nvim'},
    {'nvim-lua/lsp-status.nvim'},
    {"luukvbaal/statuscol.nvim",
      config = function()
        local builtin = require("statuscol.builtin")
        require("statuscol").setup({
          relculright = true,
          segments = {
            { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
            { text = { "%s" }, click = "v:lua.ScSa" },
            { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
          },
        })
      end,
    },
})

vim.o.background = "dark"
vim.g.gruvbox_material_enable_italic = true
vim.cmd.colorscheme('gruvbox-material')

vim.cmd([[
    augroup remember_folds
    autocmd!
    autocmd BufWinLeave ?* mkview
    autocmd BufWinEnter ?* silent! loadview
    augroup END
]])

require("ibl").setup({
    scope = {show_start=false, show_end=false}
})

vim.api.nvim_set_hl(0, "@ibl.scope.char.1", {fg="#b16286"})
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, {noremap=true})
require("colorizer").setup()

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
