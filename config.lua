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
vim.opt.autochdir = false

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

lvim.format_on_save = true

-- Config for predefined plugins
lvim.builtin.project.manual_mode = true

-- treesitter parsers
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
  "tailwindcss",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true
lvim.builtin.treesitter.matchup.enable = true
lvim.builtin.treesitter.rainbow.enable = true

lvim.builtin.gitsigns.opts.current_line_blame = true
lvim.builtin.gitsigns.opts.current_line_blame_opts.virt_text_pos = 'right_align'

-- open nvim-tree on startup
local function open_nvim_tree()
  require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

lvim.plugins = {
  {
    "gbprod/nord.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("nord").setup({})
      vim.cmd.colorscheme("nord")
    end,
  },

  {
    "nvimdev/guard.nvim",
    dependencies = { "nvimdev/guard-collection" },
    config = function()
      local ft = require("guard.filetype")

      ft("typescript,javascript,typescriptreact"):fmt("prettier")

      require("guard").setup({
        fmt_on_save = true,
      })
    end,
  },

  {
    "ethanholz/nvim-lastplace",
    config = true,
  },

  {
    "f-person/git-blame.nvim",
    event = "BufRead",
    config = function()
      vim.cmd "highlight default link gitblame SpecialComment"
      require("gitblame").setup { enabled = false }
    end,
  },
  {
    "nacro90/numb.nvim",
    event = "BufRead",
    config = function()
      require("numb").setup {
        show_numbers = true,    -- Enable 'number' for the window while peeking
        show_cursorline = true, -- Enable 'cursorline' for the window while peeking
      }
    end,
  },

  {
    "itchyny/vim-cursorword",
    event = { "BufEnter", "BufNewFile" },
    config = function()
      vim.api.nvim_command("augroup user_plugin_cursorword")
      vim.api.nvim_command("autocmd!")
      vim.api.nvim_command("autocmd FileType NvimTree,lspsagafinder,dashboard,vista let b:cursorword = 0")
      vim.api.nvim_command("autocmd WinEnter * if &diff || &pvw | let b:cursorword = 0 | endif")
      vim.api.nvim_command("autocmd InsertEnter * let b:cursorword = 0")
      vim.api.nvim_command("autocmd InsertLeave * let b:cursorword = 1")
      vim.api.nvim_command("augroup END")
    end
  },

  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require "lsp_signature".on_attach() end,
  },

  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({ "css", "scss", "html", "javascript", "typescript" }, {
        RGB = true,      -- #RGB hex codes
        RRGGBB = true,   -- #RRGGBB hex codes
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true,   -- CSS rgb() and rgba() functions
        hsl_fn = true,   -- CSS hsl() and hsla() functions
        css = true,      -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true,   -- Enable all CSS *functions*: rgb_fn, hsl_fn
      })
    end,
  },

  {
    'tzachar/highlight-undo.nvim',
    opts = {
      duration = 300,
      undo = {
        hlgroup = 'HighlightUndo',
        mode = 'n',
        lhs = 'u',
        map = 'undo',
        opts = {}
      },
      redo = {
        hlgroup = 'HighlightUndo',
        mode = 'n',
        lhs = '<C-r>',
        map = 'redo',
        opts = {}
      },
      highlight_for_count = true,
    },
  },

  {
    "zbirenbaum/copilot-cmp",
    event = "InsertEnter",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      vim.defer_fn(function()
        require("copilot").setup()
        require("copilot_cmp").setup()
      end, 100)
    end,
  }
}
