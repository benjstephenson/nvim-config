return {
    {
        "kndndrj/nvim-dbee",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        build = function()
            -- Install tries to automatically detect the install method.
            -- if it fails, try calling it with one of these parameters:
            --    "curl", "wget", "bitsadmin", "go"
            require("dbee").install()
        end,
        config = function()
            require("dbee").setup( --[[optional config]])
        end,
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},
    },
    {
        "rest-nvim/rest.nvim",
        ft = { "http" },
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
                },
            })

            vim.keymap.set("n", "<localleader>rr", "<cmd>Rest run<cr>", { desc = "run cursor" })
            vim.keymap.set("n", "<localleader>re", function() require("telescope").extensions.rest.select_env() end, { desc = "select env" })
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
            "nvim-neotest/neotest-jest",
            "nvim-neotest/neotest-python",
        },
        event = "LspAttach",
        config = function()
            local neotest = require("neotest")
            neotest.setup({
                adapters = {
                    require("neotest-python"),
                    require("neotest-jest"),
                    require("neotest-vitest")({
                        is_test_file = function(file_path)
                            return string.match(file_path, "test.ts$") or string.match(file_path, "micro.ts$")
                        end,
                    }),
                },
            })

            vim.keymap.set("n", "<leader>ts", "<cmd>Neotest summary<CR>", { desc = "test summary" })
            vim.keymap.set("n", "<leader>tp", "<cmd>Neotest output-panel<CR>", { desc = "output panel" })
            vim.keymap.set("n", "<leader>to", "<cmd>Neotest output<CR>", { desc = "output" })

            vim.keymap.set("n", "<leader>tr", function()
                neotest.run.run(vim.fn.expand("%"))
            end, { desc = "run file" })

            vim.keymap.set("n", "<leader>tR", function()
                neotest.run.run()
            end, { desc = "run nearest" })

            vim.keymap.set("n", "<leader>tl", "<cmd>Neotest run last<CR>", { desc = "run last" })

            vim.keymap.set("n", "<leader>tS", function()
                neotest.run.stop()
            end, { desc = "stop nearest" })

            vim.keymap.set("n", "<localleader>tn", "<cmd>Neotest jump next<CR>", { desc = "next test" })
            vim.keymap.set("n", "<localleader>tp", "<cmd>Neotest jump prev<CR>", { desc = "prev test" })
        end,
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "LiadOz/nvim-dap-repl-highlights",
            "nvim-neotest/nvim-nio",
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

            require("nvim-dap-repl-highlights").setup()
            local dapui = require("dapui")
            dapui.setup()

            vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "toggle repl" })
            vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "toggle dap ui" })
            vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "run last" })
            -- vim.keymap.set("n", "<localleader>dc", dap.continue, { desc = "continue" })
            vim.keymap.set("n", "<F8>", dap.continue, { desc = "continue" })
            -- vim.keymap.set("n", "<localleader>db", dap.toggle_breakpoint, { desc = "toggle breakpoint" })
            vim.keymap.set("n", "<F6>", dap.toggle_breakpoint, { desc = "toggle breakpoint" })
            -- vim.keymap.set("n", "<localleader>do", dap.step_over, { desc = "step over" })
            vim.keymap.set("n", "<F7>", dap.step_out, { desc = "step out" })
            vim.keymap.set("n", "<F10>", dap.step_over, { desc = "step over" })
            -- vim.keymap.set("n", "<localleader>di", dap.step_into, { desc = "step into" })
            vim.keymap.set("n", "<F9>", dap.step_into, { desc = "step into" })

            -- dap.listeners.before.attach.dapui_config = function()
            --     dapui.open()
            -- end
            -- dap.listeners.before.launch.dapui_config = function()
            --     dapui.open()
            -- end
            -- dap.listeners.before.event_terminated.dapui_config = function()
            --     dapui.close()
            -- end
            -- dap.listeners.before.event_exited.dapui_config = function()
            --     dapui.close()
            -- end
            dap.listeners.after["event_terminated"]["nvim-metals"] = function()
                dap.repl.open()
            end
        end,
    },
}
