local lsp = require("lsp-zero")
local cmp = require("cmp")

local cmp_action = lsp.cmp_action()
local set = vim.keymap.set

require("neodev").setup({ })

lsp.preset("recommended")

local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-up>'] = cmp.mapping.scroll_docs(-4),
    ['<C-down>'] = cmp.mapping.scroll_docs(4),
    ['<C-s>'] = cmp.mapping.complete(),
    ['<Esc>'] = cmp.mapping.abort(),
    ['<S-CR>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select),
})

cmp.setup({
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp_mappings,
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'luasnip' },
    }),
})

-- lsp.set_preferences({
--     sign_icons = {}
-- })


lsp.on_attach(function(client, bufnr)
    local desc = function(d) return {desc = d, buffer = bufnr, remap = false} end

    set("n", "gd", vim.lsp.buf.definition,      desc("LSP: Goto Definition"))
    set("n", "<leader>k", vim.lsp.buf.hover,    desc("LSP: Hover"))
    set("n", "<F2>", vim.lsp.buf.rename,        desc("LSP: Rename"))
    set("n", "<leader>gf", vim.lsp.buf.format,  desc("LSP: Format"))

    set("n", ";", vim.diagnostic.open_float,    desc("LSP: Diagnostic Window"))
    set("n", "[d", vim.diagnostics.goto_next,   desc("LSP: Next Diagnostic"))
    set("n", "]d", vim.diagnostics.goto_prev,   desc("LSP: Prev Diagnostic"))

    set("n", "<leader>ca", vim.lsp.buf.code_action,     desc("LSP: Code Action"))
    set("n", "<leader>h", vim.lsp.buf.signature_help,   desc("LSP: signature help"))
end)
