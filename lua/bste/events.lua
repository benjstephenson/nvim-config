local autocmd = vim.api.nvim_create_autocmd
local bste_group = vim.api.nvim_create_augroup("bste_group", {})

autocmd("LspAttach", {
    group = bste_group,
    callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        -- try the built-in completion client
        --vim.lsp.completion.enable(true, args.data.client_id, bufnr, { autotrigger = true })

        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "code action" })
        vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "rename" })
        vim.keymap.set({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help,
            { silent = true, buffer = 0, desc = "signature help" })
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { silent = true, buffer = 0, desc = "doc under cursor" })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { silent = true, buffer = 0, desc = "go to declaration" })
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { silent = true, buffer = 0, desc = "go to definition" })
        vim.keymap.set("n", "gt", vim.lsp.buf.type_definition,
            { silent = true, buffer = 0, desc = "go to type definition" }
        )
        vim.keymap.set("n", "gr", vim.lsp.buf.references, { silent = true, buffer = 0, desc = "go to references" })
        vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run, { silent = true, buffer = 0, desc = "run lens" })
        -- vim.keymap.set("n", "<leader>bf", function() vim.lsp.buf.format({ async = true }) end,
        vim.keymap.set("n", "<leader>bf", function() require("conform").format() end,
            { silent = true, buffer = 0, desc = "format buffer" })

        if vim.lsp.inlay_hint and client and client.supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(true)
        end

        if client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
            vim.api.nvim_clear_autocmds({ buffer = bufnr, group = "lsp_document_highlight" })
            vim.api.nvim_create_autocmd("CursorHold", {
                callback = vim.lsp.buf.document_highlight,
                buffer = bufnr,
                group = "lsp_document_highlight",
                desc = "Document Highlight",
            })
            vim.api.nvim_create_autocmd("CursorMoved", {
                callback = vim.lsp.buf.clear_references,
                buffer = bufnr,
                group = "lsp_document_highlight",
                desc = "Clear All the References",
            })
        end
    end,
})
