require("ibl").setup({
    scope = {show_start=false, show_end=false}
})

vim.api.nvim_set_hl(0, "@ibl.scope.char.1", {fg="#b16286"})
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, {noremap=true})
require("colorizer").setup()
