return {
    {
        "rest-nvim/rest.nvim",
        ft = { "http" },
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("rest-nvim").setup({
                result_split_horizontal = true,
                result_split_in_place = true,
                skip_ssl_verification = false,
                highlight = {
                    enabled = true,
                    timeout = 150,
                },
                jump_to_request = false,
                result = {
                    formatters = {
                        json = "jq",
                        html = function(body)
                            vim.fn.system("tidy", "-i", "-q", "-", body)
                        end
                    },
                },
            })

            vim.keymap.set("n", "<localleader>rr", "<plug>RestNvim", { desc = "run cursor" })
            vim.keymap.set("n", "<localleader>rp", "<plug>RestNvimPreview", { desc = "preview curl command" })
        end
    },
}
