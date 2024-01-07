local treesitter_filetypes = {
    "bash",
    "c_sharp",
    "clojure",
    "commonlisp",
    "fennel",
    "fish",
    "git_rebase",
    "gitattributes",
    "gitcommit",
    "haskell",
    "http",
    "javascript",
    "json",
    "kotlin",
    "lua",
    "markdown",
    "markdown_inline",
    "php",
    "python",
    "query",
    "regex",
    "rust",
    "scala",
    "typescript",
    "toml",
    "vim",
    "vimdoc",
}

return {
    "nvim-treesitter/nvim-treesitter",
    build = "TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = treesitter_filetypes,
            highlight = {
                enable = true,
            },
        })
    end,
}
