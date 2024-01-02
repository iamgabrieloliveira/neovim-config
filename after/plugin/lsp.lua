local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp_zero.default_keymaps({ buffer = bufnr })

    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<C-l>", function() vim.cmd('LspZeroFormat') end, opts)
end)

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {},
    handlers = {
        lsp_zero.default_setup,
    },
})

require('null-ls').setup({
    sources = {
        require('null-ls').builtins.diagnostics.eslint_d.with({
            condition = function(utils)
                return utils.root_has_file({ '.eslintrc.js' })
            end
        }),
        require('null-ls').builtins.diagnostics.trail_space.with({ disabled_filetypes = { "NvimTree" } }),
        require('null-ls').builtins.formatting.eslint_d.with({
            condition = function(utils)
                return utils.root_has_file({ '.eslintrc.js' })
            end
        }),
        require('null-ls').builtins.formatting.phpcsfixer,
        require('null-ls').builtins.formatting.prettierd,
    }
})

require('mason-null-ls').setup({ automatic_installation = true })

vim.api.nvim_create_user_command('Format', vim.lsp.buf.format, {})
