local lazypath = vim.fn.stdpath("data").."/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

plugins = {
  {
    'nvim-treesitter/nvim-treesitter',
    cmd = 'TSUpdate',
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = { "php", "vim", "vimdoc", "lua" },
        auto_install = true,
      }
    end
  },
  {
    'tpope/vim-surround'
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require('lspconfig')
      lspconfig.phpactor.setup {
        on_attach = on_attach
      }
    end
  },
  { "vim-scripts/ReplaceWithRegister" },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    opts = {
      debug = true, -- Enable debugging
    },
  },
  {
    "zbirenbaum/copilot.lua",
    config = function()
      require('copilot').setup({ })
    end
  },
  {
    "vim-airline/vim-airline",
    config = function()
      vim.cmd([[
        let g:airline#extensions#tabline#enabled = 1
        let g:airline#extensions#tabline#formatter = "unique_tail_improved"
      ]])
    end
  },
  {
    "nvim-telescope/telescope.nvim", tag = "0.1.6",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      vim.keymap.set(
        "n",
        "<C-p>",
        ":Telescope find_files<cr>",
        { silent = true }
      )
      vim.keymap.set(
        "n",
        "<leader><C-u>",
        ":Telescope buffers<cr>",
        { silent = true }
      )
    end
  },
  {
    "preservim/nerdtree",
    config = function()
      vim.keymap.set("n","<C-n>",":NERDTreeToggle<cr>")
    end
  },
  {
    "tpope/vim-unimpaired",
    config = function()
      vim.keymap.set("n","<t",":tabprev<cr>",{ silent = true })
      vim.keymap.set("n",">t",":tabnext<cr>",{ silent = true })
    end
  },
  {
    "nordtheme/vim",
    config = function()
      vim.cmd.colorscheme("nord")
      vim.cmd('highlight Visual ctermfg=6')
    end,
    priority = 50
  },
  {
    "easymotion/vim-easymotion",
    config = function()
      vim.cmd([[
      " Gif config
      map <Leader>l <Plug>(easymotion-lineforward)
      map <Leader>j <Plug>(easymotion-j)
      map <Leader>k <Plug>(easymotion-k)
      map <Leader>h <Plug>(easymotion-linebackward)
      map <Leader> <Plug>(easymotion-prefix)

      let g:EasyMotion_startofline = 0 " keep cursor column when JK motion

      ]])
    end
  }
}

require("lazy").setup(plugins, opts)

vim.g.mapleader = "\\"
vim.g.localleader = " "
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.listchars = "eol:$,tab:>],space:·"
vim.opt.nu = true

-- Lazy window switch mappings
vim.cmd([[
  nmap <silent> <C-j> :wincmd j<CR>
  nmap <silent> <C-k> :wincmd k<CR>
  nmap <silent> <C-h> :wincmd h<CR>
  nmap <silent> <C-l> :wincmd l<CR>
]])
