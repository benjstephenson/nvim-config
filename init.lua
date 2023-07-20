local plugins_path = vim.fn.stdpath("data") .. "/lazy"

--local default_plugins = {
--  "2html_plugin",
--  "getscript",
--  "getscriptPlugin",
--  "gzip",
--  "logipat",
--  "netrw",
--  "netrwPlugin",
--  "netrwSettings",
--  "netrwFileHandlers",
--  "matchit",
--  "tar",
--  "tarPlugin",
--  "rrhelper",
--  "spellfile_plugin",
--  "vimball",
--  "vimballPlugin",
--  "zip",
--  "zipPlugin",
--  "tutor",
--  "rplugin",
--  "syntax",
--  "synmenu",
--  "optwin",
--  "compiler",
--  "bugreport",
--  "ftplugin",
--}
--
--local default_providers = { "node", "perl", "ruby" }
--for _, plugin in pairs(default_plugins) do
--  vim.g[("loaded_" .. plugin)] = 1
--end
--for _, provider in ipairs(default_providers) do
--  vim.g[("loaded_" .. provider .. "_provider")] = 0
--end

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

local bootstrap = require("bootstrap")

bootstrap["pre-setup"]()
local plugins = {
  {
    "rktjmp/hotpot.nvim",
    dependencies = { "datwaft/themis.nvim" },
  },
}

for k, v in pairs(bootstrap.modules) do
  for _, v2 in ipairs(v) do
    local mod_path = "modules" .. "." .. k .. "." .. v2
    local ok, spec = pcall(require, mod_path)
    if ok then
      plugins[#plugins + 1] = spec
    else
      print("Failed to load module " .. mod_path .. " : " .. spec)
    end
  end
end

require("lazy").setup(plugins)

-- Load configuration
bootstrap["post-setup"]()
