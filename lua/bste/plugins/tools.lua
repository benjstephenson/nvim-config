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
            "marilari88/neotest-vitest",
            "nvim-neotest/neotest-python",
        },
        event = "LspAttach",
        config = function()
            require("neotest").setup({
                adapters = {
                    require("neotest-python"),
                    require("neotest-vitest") {
                        is_test_file = function(file_path)
                            return string.match(file_path, "test.ts$") or string.match(file_path, "micro.ts$")
                        end
                    }
                },
            })
        end,
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio"
        },
        config = function()
            local dap = require("dap")

            dap.configurations.scala = {
                {
                    type = "scala",
                    request = "launch",
                    name = "RunOrTest",
                    metals = {
                        runType = "runOrTestFile",
                        --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
                    },
                },
                {
                    type = "scala",
                    request = "launch",
                    name = "Test Target",
                    metals = {
                        runType = "testTarget",
                    },
                },
            }

            local dapui = require("dapui")
            dapui.setup()

            vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "toggle repl" })
            vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "toggle dap ui" })
            vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "run last" })
            vim.keymap.set("n", "<localleader>dc", dap.continue, { desc = "continue" })
            vim.keymap.set("n", "<localleader>db", dap.toggle_breakpoint, { desc = "toggle breakpoint" })
            vim.keymap.set("n", "<localleader>do", dap.step_over, { desc = "step over" })
            vim.keymap.set("n", "<localleader>di", dap.step_into, { desc = "step into" })
        end
    }
}
