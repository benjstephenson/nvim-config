local plugins_path = vim.fn.stdpath("data") .. "/lazy"

-- Bootstrap lazy.nvim
local lazy_path = plugins_path .. "/lazy.nvim"
if not vim.loop.fs_stat(lazy_path) then
  vim.notify("Bootstrapping lazy.nvim...", vim.log.levels.INFO)
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazy_path,
  })
end

-- Bootstrap hotpot.nvim
local hotpot_path = plugins_path .. "/hotpot.nvim"
if not vim.loop.fs_stat(hotpot_path) then
  vim.notify("Bootstrapping hotpot.nvim...", vim.log.levels.INFO)
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/rktjmp/hotpot.nvim.git",
    hotpot_path,
  })
end

-- Add lazy.nvim to rtp
vim.opt.runtimepath:prepend(lazy_path)
-- Add hotpot.nvim to rtp
vim.opt.runtimepath:prepend(hotpot_path)

-- Configure hotpot.nvim
require("hotpot").setup({
  enable_hotpot_diagnostics = true,
  provide_require_fennel = true,
  compiler = {
    macros = {
      allowGlobals = true,
      compilerEnv = _G,
      env = "_COMPILER",
    },
    modules = {
      correlate = true,
      useBitLib = true,
    },
  },
})


local plugins = {}

local plugins_folder = vim.fn.stdpath("config") .. "/fnl/plugins"
if vim.loop.fs_stat(plugins_folder) then
  for file in vim.fs.dir(plugins_folder) do
    file = file:match("^(.*)%.fnl$") or file
    table.insert(plugins, require("plugins." .. file))
  end
end

require("lazy").setup(plugins)
require("startup")
