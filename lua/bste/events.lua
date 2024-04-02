local autocmd = vim.api.nvim_create_autocmd
local bste_group = vim.api.nvim_create_augroup("bste_group", {})

autocmd("LspAttach", {
    group = bste_group,
    callback = function(args)
        local buf = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "code action" })
        vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "rename" })
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { silent = true, buffer = 0, desc = "signature help" })
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { silent = true, buffer = 0, desc = "doc under cursor" })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { silent = true, buffer = 0, desc = "go to declaration" })
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { silent = true, buffer = 0, desc = "go to definition" })
        --vim.keymap.set("n", "gr", vim.lsp.buf.references, { silent = true, buffer = 0, desc = "references" })
        vim.keymap.set(
            "n",
            "gt",
            vim.lsp.buf.type_definition,
            { silent = true, buffer = 0, desc = "go to type definition" }
        )
        vim.keymap.set("n", "fr", vim.lsp.buf.references, { silent = true, buffer = 0, desc = "go to references" })

        if vim.lsp.inlay_hints and client and client.supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(buf, true)
        end

        --if client and client.supports_method("textDocument/formatting") then
        --    autocmd("BufWritePre", {
        --        group = bste_group,
        --        callback = function()
        --            --if not vim.g.lsp_autoformat_disable then
        --            vim.lsp.buf.format({ bufnr = buf })
        --            --end
        --        end,
        --        buffer = buf,
        --    })
        --end
    end,
})
