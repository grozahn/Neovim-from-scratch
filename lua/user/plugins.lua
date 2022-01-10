local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  use "kyazdani42/nvim-web-devicons"
  use "kyazdani42/nvim-tree.lua"
  use "akinsho/bufferline.nvim"
  use "nvim-lualine/lualine.nvim"
  use "akinsho/toggleterm.nvim"
  use "ahmedkhalf/project.nvim"
  use "lewis6991/impatient.nvim"
  use "lukas-reineke/indent-blankline.nvim"
  use "goolord/alpha-nvim"
  use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight
  use "folke/which-key.nvim"

  -- Colorschemes
  use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
  use "lunarvim/darkplus.nvim"
  use { "dracula/vim", as = "dracula" }
  -- use "RRethy/nvim-base16"
  use "shaunsingh/nord.nvim"
  use "ishan9299/nvim-solarized-lua"
  use "sainnhe/gruvbox-material"

  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"

  -- snippets
  use "L3MON4D3/LuaSnip" -- snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
  -- use "glepnir/lspsaga.nvim"
  use "nvim-lua/lsp-status.nvim"
  use {
    "simrat39/symbols-outline.nvim",
    config = function()
      vim.g.symbols_outline = {
        auto_preview = false,
        relative_width = true,
        width = 40,
        show_symbol_details	= false,
      }
    end
  }

  -- > Dev
  --
  -- < Debugger
  -- TODO: config
  use "mfussenegger/nvim-dap"

  -- < Org
  use {
    "kristijanhusak/orgmode.nvim",
    config = function() require("orgmode").setup{} end
  }

  -- < Markdown
  use "plasticboy/vim-markdown"

  -- < Neovim Lua plugin development
  use {
    "folke/lua-dev.nvim",
    config = function() require("lua-dev").setup{} end
  }

  -- < Smali
  use "kelwin/vim-smali"

  -- < Vala
  use "arrufat/vala.vim"

  -- < Rust
  use {
    "simrat39/rust-tools.nvim",
    config = function() require('rust-tools').setup{} end
  }
  use {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup{}
    end,
  }

  -- > Tools
  --
  -- < Git
  use {
    "TimUntersberger/neogit",
    cmd = "Neogit",
    config = function()
      require("neogit").setup { disable_commit_confirmation = true }
    end
  }
  use "lewis6991/gitsigns.nvim"

  -- < Preview content of registers
  use {
    "tversteeg/registers.nvim",
    keys = {
      { "n", "\"" },
      { "i", "<c-r>" }
    }
  }

  -- < Better Quickfix
  use "kevinhwang91/nvim-bqf"

  -- < Telescope
  use "nvim-telescope/telescope.nvim"

  -- > Editor
  --
  -- < Easily comment stuff
  use {
    "numToStr/Comment.nvim",
    event = "BufRead",
    config = function()
      require("Comment").setup { ignore = "^$", }
    end,
  }

  -- < Makes hlsearch more useful
  use "romainl/vim-cool"

  -- < Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use "JoosepAlviste/nvim-ts-context-commentstring"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
