vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<leader>,", "<cmd>Telescope buffers<CR>", { desc = "Switch buffer" })
vim.keymap.set("n", "<leader><space>", "<cmd>Telescope find_files<CR>", { desc = "Find file in project" })
vim.keymap.set("n", "<leader>.", "<cmd>Telescope find_files hidden=true<CR>", { desc = "find all files" })
vim.keymap.set("n", "<leader>'", "<cmd>Telescope resume<CR>", { desc = "resume last search" })
vim.keymap.set("n", "<leader>/", "<cmd>Telescope live_grep<CR>", { desc = "search project" })
vim.keymap.set("n", "<leader>:", "<cmd>Telescope commands<CR>", { desc = "commands" })

--
-- Files
--
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope file_browser theme=get_ivy<CR>", { desc = "file browser" })
vim.keymap.set("n", "<leader>fC", "<cmd>%y+<CR>", { desc = "copy file contents" })
vim.keymap.set("n", "<leader>fC", "<cmd>%y+<CR>", { desc = "copy file contents" })
vim.keymap.set("n", "<leader>ff", "<cmd>r! echo %<CR>", { desc = "current file name" })
vim.keymap.set("n", "<leader>fF", "<cmd>r! echo %:p<CR>", { desc = "current file path" })
vim.keymap.set("n", "<leader>fl", ":grep ", { desc = "locate file (rg)" })

--
-- buffers
--
vim.keymap.set("n", "<leader>bb", "<cmd>Telescope buffers<CR>", { desc = "switch buffer" })
vim.keymap.set("n", "<leader>bd", "<cmd>bd<CR>", { desc = "delete buffer" })
vim.keymap.set("n", "<leader>bn", "<cmd>bn<CR>", { desc = "next buffer" })
vim.keymap.set("n", "<leader>bp", "<cmd>bp<CR>", { desc = "previous buffer" })

--
-- code
--
vim.keymap.set("n", "<leader>cm", function()
    vim.api.nvim_command("make")
    vim.api.nvim_command("copen")
end, { desc = "make" })

--
-- Diagnostics
--
vim.keymap.set("n", "<localleader>d", vim.diagnostic.open_float, { desc = "diagnostic float" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)

--
-- Help
--
vim.keymap.set("n", "<leader>ht", "<cmd>Telescope help_tags<CR>", { desc = "search help tags" })
vim.keymap.set("n", "<leader>h<CR>", "<cmd>help<CR>", { desc = "Vim Help" })
vim.keymap.set("n", "<leader>hk", "<cmd>Telescope keymaps<CR>", { desc = "List keymaps" })
vim.keymap.set("n", "<leader>hm", "<cmd>:messages<CR>", { desc = "View message history" })
vim.keymap.set("n", "<leader>hh", "<cmd>hist<CR>", { desc = "List command history" })
vim.keymap.set("n", "<leader>hc", "<cmd>Telescope colorscheme enable_preview=true<CR>", { desc = "Load theme" })
