return {
    "nvimtools/hydra.nvim",
    config = function()
        require("bste.plugins.hydra.options")
        require("bste.plugins.hydra.git")
    end,
}
