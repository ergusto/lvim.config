-- general
lvim.log.level = "warn"
lvim.colorscheme = "nord"

-- Disable mouse entirely
vim.opt.mouse = ""
vim.opt.wrap = true
vim.opt.showmode = true
vim.opt.relativenumber = true
vim.opt.updatetime = 750
vim.opt.hidden = true

-- keymappings
lvim.leader = "space"

-- Buffer navigation
lvim.keys.normal_mode["<S-Tab>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["<Tab>"] = ":BufferLineCycleNext<CR>"

-- jk to escape in insert mode
vim.keymap.set("i", "jk", "<Esc>")

-- nvimtree options
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.view.adaptive_size = true

-- white list of language servers
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "javascript",
  "json",
  "python",
  "typescript",
  "tsx",
  "css",
  "yaml",
  "prisma",
  "lua",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

-- open nvim-tree on startup
local function open_nvim_tree()
  require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

lvim.plugins = {
  {
    "shaunsingh/nord.nvim"
  },
}
