local icons = require("bste.constants").kind_icons

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "folke/neodev.nvim",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        -- "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        {
            "MattiasMTS/cmp-dbee",
            dependencies = "kndndrj/nvim-dbee",
            ft = "sql",
            opts = {}
        },
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        {
            "j-hui/fidget.nvim",
            config = true,
        },
    },

    config = function()
        local mason = require("mason")
        local cmp = require("cmp")
        local neodev = require("neodev")

        neodev.setup({
            library = { plugins = { "nvim-dap-ui" }, types = true }
        })

        local lspconfig = require("lspconfig")
        local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

        vim.diagnostic.config({
            underline = true,
            severity_sort = true,
            float = {
                border = "rounded"
            }
        })

        vim.lsp.handlers["textDocument/signatureHelp"] =
            vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ select = false }),
                -- ["<Tab>"] = cmp.mapping(function(fallback)
                --     if cmp.visible() then
                --         return cmp.select_next_item()
                --     else
                --         return fallback
                --     end
                -- end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        return cmp.select_prev_item()
                    else
                        return fallback
                    end
                end, { "i", "s" }),
            }),
            formatting = {
                mode = "symbol_text",
                fields = { "kind", "abbr", "menu" },
                format = function(_, item)
                    local icon = icons[item.kind]
                    item.kind = (icon or "") .. " " .. item.kind
                    return item
                end,
                maxwidth = 120,
            },
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "nvim_lsp_signature_help" },
                { name = "luasnip" },
            }, {
                { name = "buffer" },
            }),

            cmp.setup.filetype("sql", {
                sources = cmp.config.sources({
                    name = "cmp-dbee"
                })
            }),

            cmp.setup.filetype("gitcommit", {
                sources = cmp.config.sources({
                    { name = "git" },
                }, {
                    { name = "buffer" },
                }),
            }),

            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    { name = "cmdline" },
                }),
            }),
        })

        mason.setup({})
        require("mason-lspconfig").setup({
            ensure_installed = {
                "bashls",
                "fennel_language_server",
                -- "hls",
                "jsonls",
                "lua_ls",
                "marksman",
                "pyright",
                "rust_analyzer",
                "yamlls",
            },
            handlers = {
                function(server_name)
                    lspconfig[server_name].setup({
                        capabilities = lsp_capabilities,
                    })
                end,
                ["lua_ls"] = function()
                    lspconfig.lua_ls.setup({
                        capabilities = lsp_capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = {
                                        "vim",
                                    },
                                },
                            },
                        },
                    })
                end,
                ["pyright"] = function()
                    lspconfig.pyright.setup({
                        capabilities = lsp_capabilities,
                        settings = {
                            python = {
                                venvPath = "./.venv",
                            },
                        },
                    })
                end,
            },
        })
    end,
}
