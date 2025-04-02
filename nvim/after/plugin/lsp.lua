local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
ensure_installed = {},
handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
    matlab_ls = function()
        require('lspconfig').matlab_ls.setup({
            filetypes = {"matlab"},
            settings = {
                matlab = {
                    installPath = "/opt/matlab/R2023a/"
                },
            },
            single_file_support = true
        })
    end,
},
})
require ("lspconfig").verible.setup({})


local cmp = require('cmp')

cmp.setup({
  completion = {
        autocomplete= { cmp.TriggerEvent.TextChanged },
  },
  sources = {
    {name = 'nvim_lsp'},
  },
  mapping = {
    ['<C-n>'] = cmp.mapping.confirm({select = false}),
    ['<C-k>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
    ['<C-j>'] = cmp.mapping.select_next_item({behavior = 'select'}),
    ['<C-p>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item({behavior = 'insert'})
      else
        cmp.complete()
      end
    end),
    ['<C-l>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_next_item({behavior = 'insert'})
      else
        cmp.complete()
      end
    end),
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
})

vim.api.nvim_create_user_command("DiagnosticToggle", function()
	local config = vim.diagnostic.config
	local vt = config().virtual_text
	config {
		virtual_text = not vt,
		underline = not vt,
		signs = not vt,
	}
end, { desc = "toggle diagnostic" })

local path = "/home/lukas/.config/nvim/spell/de.utf-8.add"
local words = {}

local file = io.open(path, "r")
if file then
  for word in file:lines() do
    table.insert(words, word)
  end
  file:close()
end

require('lspconfig').ltex.setup({
  cmd = { "ltex-ls" },
  filetypes = { "markdown", "tex", "txt" },
  settings = {
    ltex = {
      language = "de",
        dictionary = {
            ["de-DE"] = words,
        },
         disabledRules = {
        ['de-DE'] = { '' },
      },
    },
  },
})


vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local opts = { buffer = event.buf }
--    vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
    --vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
    --vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
    --vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, opts)
    --vim.keymap.set('n', 'go', function() vim.lsp.buf.type_definition() end, opts)
    --vim.keymap.set('n', 'gr', function() vim.lsp.buf.references() end, opts)
    --vim.keymap.set('n', 'gs', function() vim.lsp.buf.signature_help() end, opts)
    --vim.keymap.set('n', '<Leader>cr', function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set({ 'n', 'v' }, '<Leader>cf', function() vim.lsp.buf.format() end, opts)
    vim.keymap.set('n', '<Leader>ca', function() vim.lsp.buf.code_action() end, opts)
  end,
})
