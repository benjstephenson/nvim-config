return {
    {
        "rest-nvim/rest.nvim",
        ft = { "http" },
        dependencies = { "vhyrro/luarocks.nvim", priority = 1000, config = true },
        config = function()
            require("rest-nvim").setup({
                skip_ssl_verification = false,
                highlight = {
                    timeout = 150,
                },
                result = {
                    split = {
                        horizontal = true,
                        in_place = false,
                    },
                    behavior = {
                        formatters = {
                            json = "jq",
                            html = function(body)
                                vim.fn.system("tidy", "-i", "-q", "-", body)
                            end,
                        },
                    },
                },
            })

            vim.keymap.set("n", "<localleader>rr", "<cmd>Rest run<cr>", { desc = "run cursor" })
            --vim.keymap.set("n", "<localleader>rp", "<plug>RestNvimPreview", { desc = "preview curl command" })
        end,
    },
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
            "adrigzr/neotest-mocha",
        },
        event = "LspAttach",
        config = function()
            require("neotest").setup({
                adapters = {
                    require("neotest-mocha")({
                        command = "npm test --",
                        command_args = function(context)
                            -- The context contains:
                            --   results_path: The file that json results are written to
                            --   test_name_pattern: The generated pattern for the test
                            --   path: The path to the test file
                            --
                            -- It should return a string array of arguments
                            --
                            -- Not specifying 'command_args' will use the defaults below
                            return {
                                "--full-trace",
                                "--reporter=json",
                                "--reporter-options=output=" .. context.results_path,
                                "--grep=" .. context.test_name_pattern,
                                context.path,
                            }
                        end,
                        env = { CI = true },
                        cwd = function(_)
                            return vim.fn.getcwd()
                        end,
                    }),
                },
            })
        end,
    },
}
