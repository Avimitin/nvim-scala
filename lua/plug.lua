local function collect_plugins()
  local plugins = {}
  local overlays = {
    "git",
    "ui",
    "treesitter",
    "tools",
    "completion",
    "lsp",
  }

  for _, component in ipairs(overlays) do
    local ok, result = pcall(require, "plugins."..component)
    if not ok then
      vim.notify("fail to load component " .. component .. " " .. result, vim.log.levels.ERROR)
    end
    vim.list_extend(plugins, result)
  end

  return plugins
end

local function setup()
  local lazy_nvim_install_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazy_nvim_install_path) then
    vim.notify("Package manager not found, installing...")
    local success, maybe_error = pcall(vim.fn.system, {
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      lazy_nvim_install_path,
    })

    if not success then
      vim.notify(
        "ERROR: Fail to install plugin manager lazy.nvim" .. " " .. maybe_error,
        vim.log.levels.ERROR
      )
      return
    end
  end

  vim.opt.rtp:prepend(lazy_nvim_install_path)

  require("lazy").setup(collect_plugins(), {
    install = {
      colorscheme = { "kanagawa" },
    },
  })
end

setup()
