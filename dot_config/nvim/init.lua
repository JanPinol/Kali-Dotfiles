-- This is my personal Nvim configuration supporting Mac, Linux and Windows, with various plugins configured.
-- This configuration evolves as I learn more about Nvim and become more proficient in using Nvim.
-- Since it is very long (more than 1000 lines!), you should read it carefully and take only the settings that suit you.
-- I would not recommend cloning this repo and replace your own config. Good configurations are personal,
-- built over time with a lot of polish.
--
-- Author: Jiedong Hao
-- Email: jdhao@hotmail.com
-- Blog: https://jdhao.github.io/
-- GitHub: https://github.com/jdhao
-- StackOverflow: https://stackoverflow.com/users/6064933/jdhao
local utils = require("utils")

vim.loader.enable()

local expected_version = "0.12.0"
utils.is_compatible_version(expected_version)

-- some global settings
require("globals")

-- setting options in nvim
require("options")

-- various autocommands
require("custom-autocmd")

-- all the user-defined mappings
require("mappings")

-- all the plugins installed and their configurations
require("plugin_specs")

-- This is done after plugin_specs, since lsp-config is loaded in that step
require("lsp_conf")

-- diagnostic related config
require("diagnostic-conf")

-- colorscheme settings
require("colorschemes")
vim.cmd.colorscheme("github_dark_default")
vim.keymap.set("n", "<Up>", "k", { noremap = true, silent = true })
vim.keymap.set("n", "<Down>", "j", { noremap = true, silent = true })
vim.keymap.set("n", "<Left>", "h", { noremap = true, silent = true })
vim.keymap.set("n", "<Right>", "l", { noremap = true, silent = true })



vim.keymap.set("n", "<C-e>", function()
  local explorer_open = false
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local ft = vim.bo[buf].filetype
    if ft == "snacks_explorer" then
      explorer_open = true
      vim.api.nvim_win_close(win, true)
    end
  end
  if not explorer_open then
    Snacks.explorer()
  end
end, { noremap = true, silent = true, desc = "Toggle Explorer" })
