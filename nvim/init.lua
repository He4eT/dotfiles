--[[ NeoVim Configuration File ]]

--[[ Formatter:
npx @johnnymorganz/stylua-bin ./init.lua
]]

--[[ Structure:
├─ cfg_leader: Leader keys
├─ cfg_options: See `:help vim.o`
├─ cfg_filetypes: Filetype aliases
├─ cfg_cmds: Commands
├─ cfg_autocmds: Autocomands
├─ cfg_keymaps: General keymaps
└─ cfg_lazy: Plugin manager
   ├─ cfg_lazy_guess_indent: Detect tabstop and shiftwidth automatically
   ├─ cfg_lazy_surround: Delete, change and add such surroundings in pairs
   ├─ cfg_lazy_colorizer: Color highlighter
   ├─ cfg_lazy_comment: Toggles linewise and blockwise comments
   ├─ cfg_lazy_leap: Leap motion plugin
   ├─ cfg_lazy_lualine: Statusline
   ├─ cfg_lazy_gitsigns: Git-releated actions and gutter signs
   │  └─ cfg_lazy_gitsigns_keymaps
   ├─ cfg_lazy_desolate: Not-so-colorful colorscheme
   ├─ cfg_lazy_onedark: Colorscheme inspired by Atom
   ├─ cfg_lazy_fzf: Fuzzy search
   │  └─ cfg_lazy_fzf_keymaps
   ├─ cfg_lazy_lsp: LSP configuration & plugins
   │  ├─ cfg_lazy_lsp_keymaps
   │  └─ cfg_lazy_lsp_servers
   ├─ cfg_lazy_cmp: Autocompletion
   │  └─ cfg_lazy_cmp_keymaps
   └─ cfg_lazy_treesitter: Highlight, edit, and navigate code
      ├─ cfg_lazy_treesitter_langs
      └─ cfg_lazy_treesitter_keymaps
]]

--[[ cfg_leader: Leader keys ]]

local leader = ' '
vim.g.mapleader = leader
vim.g.maplocalleader = leader
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

--[[ cfg_options: See `:help vim.o` ]]

-- Disable Intro (:intro)
vim.opt.shortmess:append 'I'

-- Raise a dialog asking if you wish to save the current file(s)
vim.o.confirm = true

-- Set window title
vim.o.title = true
vim.o.titlestring = '%F'

-- Window borders
vim.o.winborder = 'solid'

-- Hide mode in cmd
vim.o.showmode = false

-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'
vim.o.mousemodel = 'extend'

-- Enable break indent
vim.o.breakindent = false

-- Disable line wrapping
vim.o.wrap = false

-- Break lines at word
vim.o.linebreak = true

-- Go to start of the line after gg and similar moves
vim.o.startofline = true

-- Show cursorline
vim.o.cursorline = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Hide tildes on unused lines
vim.o.fillchars = 'eob: '

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250

-- Disabling the timeout for key sequence completion
vim.o.timeout = false

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect,fuzzy'

-- Keeps the same screen lines in all split windows
vim.o.splitkeep = 'screen'

-- Netrw settings
vim.g.netrw_sort_sequence = '[\\/]$,*'

--[[ cfg_filetypes: Filetype aliases ]]

vim.filetype.add {
  extension = {
    pcss = 'css',
  },
}

--[[ cfg_cmds: Commands ]]

-- Ignore :EditQuery command
vim.api.nvim_create_user_command('E', 'Explore', {})

--[[ cfg_autocmds: Autocomands ]]

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
  pattern = '*',
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Default insert mode in terminal buffers
vim.api.nvim_create_autocmd('BufEnter', {
  group = vim.api.nvim_create_augroup('TerminalEnter', { clear = true }),
  pattern = 'term://*',
  command = 'startinsert',
})

-- Disable line numbers for terminal buffers
vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('TerminalSettings', { clear = true }),
  pattern = '*',
  command = 'setlocal nonumber',
})

-- Switch the keyboard layout to English (US) when leaving Insert Mode
vim.api.nvim_create_autocmd('InsertLeave', {
  group = vim.api.nvim_create_augroup('SwitchToEnglishOnLeave', { clear = true }),
  pattern = '*',
  command = 'silent !xkb-switch -s us',
})

--[[ cfg_keymaps: General keymaps ]]

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Remap PgUp/PgDown to C-u/C-d
vim.keymap.set('n', '<PageDown>', '<C-d>', { silent = true, desc = 'Emulate <Ctrl + d>' })
vim.keymap.set('n', '<PageUp>', '<C-u>', { silent = true, desc = 'Emulate <Ctrl + u>' })

-- Open terminal
vim.keymap.set('n', '<leader>T', ':terminal<CR>i', { silent = true, desc = 'Open [t]erminal here' })
vim.keymap.set('n', '<leader>t', ':vs<CR><C-w>w:terminal<CR>i', { silent = true, desc = 'Open [T]erminal in vsplit' })

-- Escape terminal mode
vim.keymap.set('t', ';;', '<C-\\><C-n>', { silent = true, desc = 'Escape terminal mode' })

-- Window managment
vim.keymap.set('n', '<leader>q', ':bp|bd#<CR>', { desc = 'Close current buffer ' })
vim.keymap.set('n', '<leader>w', '<C-w>', { remap = true, desc = 'Alias for Ctrl + w' })
vim.keymap.set('n', '<leader>k', '<C-w>w', { remap = true, desc = 'Jump to the next window' })
vim.keymap.set('n', '<leader>K', ':vs<CR><C-w>w', { desc = 'Split window to the right' })

-- Navigation
vim.keymap.set('n', '<leader>h', '<C-o>', { desc = 'Back' })
vim.keymap.set('n', '<leader>l', '<C-i>', { desc = 'Forward' })

-- Copy'n'Paste
vim.keymap.set('v', '<leader>y', '"+y', { desc = 'Cop[y] selection to system clipboard' })
vim.keymap.set('n', '<leader>y', function()
  local text = vim.fn.getreg '"'
  vim.fn.system('xclip -i -selection clipboard', text)
  print 'Copied to system clipboard'
end, {
  silent = true,
  desc = 'Copy last [y]anked or deleted text to system clipboard',
})

-- Diagnostic
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open floating [d]iagnostic message' })
vim.keymap.set('n', '<leader>D', vim.diagnostic.setloclist, { desc = 'Open [D]iagnostics list' })

-- Search in Visual Mode
vim.keymap.set('x', '/', '<Esc>/\\%V', { desc = 'Search within visual selection' })

-- Hide search highlight, cmdline, and popups
local function wipe_ui()
  vim.api.nvim_command 'nohlsearch'
  vim.api.nvim_echo({}, false, {})
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local win_config = vim.api.nvim_win_get_config(win)
    if win_config.relative ~= '' then
      vim.api.nvim_win_close(win, true)
    end
  end
end

vim.keymap.set('n', '<BS>', wipe_ui, { desc = 'Clear search, cmdline, and popups' })
vim.keymap.set('n', '<ESC>', wipe_ui, { desc = 'Clear search, cmdline, and popups' })

--[[ cfg_lazy: Plugin manager ]]
-- https://github.com/folke/lazy.nvim

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  --[[ cfg_lazy_guess_indent: Detect tabstop and shiftwidth automatically ]]
  'NMAC427/guess-indent.nvim',
  --[[ cfg_lazy_surround: Delete, change and add surroundings in pairs ]]
  'tpope/vim-surround',
  --[[ cfg_lazy_colorizer: Color highlighter ]]
  {
    'catgoose/nvim-colorizer.lua',
    cmd = 'ColorizerToggle',
    opts = {},
  },
  --[[ cfg_lazy_comment: Toggles linewise and blockwise comments ]]
  {
    'numToStr/Comment.nvim',
    opts = {},
  },
  --[[ cfg_lazy_leap: Leap motion plugin ]]
  {
    'ggandor/leap.nvim',
    dependencies = {
      'tpope/vim-repeat',
    },
    config = function()
      local leap = require 'leap'
      leap.add_default_mappings()
      leap.opts.highlight_unlabeled_phase_one_targets = true
      leap.opts.safe_labels = {}
    end,
  },
  --[[ cfg_lazy_lualine: Statusline ]]
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        globalstatus = true,
        icons_enabled = false,
        section_separators = '',
        component_separators = '|',
      },
    },
  },
  --[[ cfg_lazy_gitsigns: Git-releated actions and gutter signs ]]
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {
        signs = {
          add = { text = '│' },
          change = { text = '│' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '│' },
        },
      }

      --[[ cfg_lazy_gitsigns_keymaps ]]

      vim.keymap.set('n', '[g', ':Gitsigns prev_hunk<CR>', { desc = 'Go to previous Git hunk' })
      vim.keymap.set('n', ']g', ':Gitsigns next_hunk<CR>', { desc = 'Go to next Git hunk' })

      vim.keymap.set('n', '<leader>gb', ':Gitsigns blame_line<CR>', { desc = 'Show [g]it [b]lame' })
      vim.keymap.set('n', '<leader>gu', ':Gitsigns reset_hunk<CR>', { desc = 'Reset [g]it h[u]nk' })
      vim.keymap.set('n', '<leader>gj', ':Gitsigns stage_hunk<CR>', { desc = 'Stage/unstage current hunk' })
      vim.keymap.set('n', '<leader>gk', ':Gitsigns preview_hunk<CR>', { desc = 'Show [g]it hun[k] preview' })
    end,
  },
  --[[ cfg_lazy_desolate: Not-so-colorful colorscheme ]]
  {
    'He4eT/desolate.nvim',
    dependencies = {
      'rktjmp/lush.nvim',
    },
    -- dir = '~/trash/desolate.nvim',
    priority = 1000,
    init = function()
      vim.g.desolate_h = 0
      vim.g.desolate_s = 0
      vim.g.desolate_l = 70
      vim.g.desolate_contrast = 120

      vim.g.desolate_fg = '#cdcdcd'
      vim.g.desolate_bg = '#383838'

      vim.g.desolate_constant = '#ffd700'
      vim.g.desolate_identifier = '#ffc812'
      vim.g.desolate_statement = '#ffffff'

      vim.g.desolate_error = '#ff4242'
      vim.g.desolate_warning = '#ffad29'
      vim.g.desolate_success = '#74af68'
      vim.g.desolate_info = '#ffffff'

      vim.o.termguicolors = true
      vim.o.background = 'dark'
      vim.cmd.colorscheme 'desolate'
    end,
  },
  --[[ cfg_lazy_onedark: Colorscheme inspired by Atom ]]
  'navarasu/onedark.nvim',
  --[[ cfg_lazy_fzf: Fuzzy search ]]
  {
    'ibhagwan/fzf-lua',
    dependencies = {
      {
        'junegunn/fzf',
        build = './install --bin',
      },
    },
    config = function()
      local fzf = require 'fzf-lua'

      fzf.setup {
        fzf_colors = true,
        winopts = {
          backdrop = 100,
          border = 'single',
          fullscreen = true,
          preview = {
            border = 'single',
          },
          previewers = {
            builtin = {
              syntax = true,
              syntax_limit_b = 1024 * 64, -- syntax limit (bytes), 0=nolimit
            },
          },
        },
        grep = {
          rg_opts = ''
            .. ' --color=ansi'
            .. ' --colors column:fg:blue'
            .. ' --colors line:fg:green'
            .. ' --colors match:fg:red'
            .. ' --colors path:fg:yellow'
            .. ' --column'
            .. ' --line-number'
            .. ' --max-columns=512'
            .. ' --smart-case'
            .. ' --vimgrep',
          file_ignore_patterns = {
            '^node_modules/',
            '/node_modules/',
            '^.git/',
            '^.yarn/',
          },
        },
      }

      local fzf_files = function()
        fzf.files { fd_opts = '--no-ignore --hidden' }
      end

      local fzf_grep_filename = function()
        fzf.grep { search = vim.fn.expand '%:t' }
      end

      local fzf_git_chronology = function()
        fzf.files {
          cmd = "git log --name-only --pretty=\"\" | sed -e '/^\\s*$/d' | awk '!seen[$0]++'",
          hidden = false,
        }
      end

      --[[ cfg_lazy_fzf_keymaps ]]

      vim.keymap.set('n', '<leader>fp', fzf.builtin, { desc = '[f]zf: [p]allete' })
      vim.keymap.set('n', '<leader>f.', fzf.resume, { desc = '[f]zf: resume' })

      vim.keymap.set('n', '<leader>b', fzf.buffers, { desc = '[f]zf: [b]uffers' })

      vim.keymap.set('n', '<leader>fF', fzf_files, { desc = '[f]zf: all [F]iles' })
      vim.keymap.set('n', '<leader>ff', fzf.git_files, { desc = '[f]zf: git [f]iles' })
      vim.keymap.set('n', '<leader>fd', fzf.git_status, { desc = '[f]zf: git [d]iff' })
      vim.keymap.set('n', '<leader>fh', fzf_git_chronology, { desc = '[f]zf: git c[h]ronology' })

      vim.keymap.set('n', '<leader>f/', fzf.blines, { desc = '[f]zf: buffer lines' })
      vim.keymap.set('n', '<leader>fg', fzf.live_grep, { desc = '[f]zf: [g]rep' })
      vim.keymap.set('n', '<leader>fw', fzf.grep_cword, { desc = '[f]zf: grep [w]' })
      vim.keymap.set('n', '<leader>fW', fzf.grep_cWORD, { desc = '[f]zf: grep [W]' })
      vim.keymap.set('n', '<leader>fu', fzf_grep_filename, { desc = '[f]zf: current file [u]sages' })

      vim.keymap.set('n', '<leader>p', fzf.registers, { desc = '[f]zf: [p]aste from register' })
      vim.keymap.set('n', '<leader>?', fzf.keymaps, { desc = '[f]zf: keymaps' })
      vim.keymap.set('n', '<leader>/', fzf.search_history, { desc = '[f]zf: search history' })
      vim.keymap.set('n', '<leader>:', fzf.command_history, { desc = '[f]zf: command history' })

      -- LSP
      vim.keymap.set('n', '<leader>gd', fzf.lsp_definitions, { desc = 'LSP: [g]oto [d]efinition list' })
      vim.keymap.set('n', '<leader>gr', fzf.lsp_references, { desc = 'LSP: [g]o to fzf [r]eference list' })
    end,
  },
  --[[ cfg_lazy_lsp: LSP configuration & plugins ]]
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
    },
    config = function()
      -- Diagnostic Appearance
      local icon = '⏹'
      vim.diagnostic.config {
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = icon,
            [vim.diagnostic.severity.WARN] = icon,
            [vim.diagnostic.severity.INFO] = icon,
            [vim.diagnostic.severity.HINT] = icon,
          },
        },
        virtual_text = {
          prefix = icon,
        },
      }

      --[[ cfg_lazy_lsp_keymaps ]]
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            vim.keymap.set(mode or 'n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- See also cfg_lazy_fzf_keymaps

          map('<C-k>', vim.lsp.buf.signature_help, 'signature documentation', { 'n', 'i' })

          map('<leader>rn', vim.lsp.buf.rename, '[r]e[n]ame')
          map('<leader>ca', vim.lsp.buf.code_action, '[c]ode [a]ction', { 'n', 'x' })

          map('gd', vim.lsp.buf.definition, '[g]oto [d]efinition')
          map('gD', vim.lsp.buf.type_definition, '[g]oto type [D]efinition')
          map('<leader>gD', vim.lsp.buf.declaration, '[g]oto [D]eclaration')

          map('<leader>ea', vim.lsp.buf.add_workspace_folder, 'workspac[e]: [a]dd folder')
          map('<leader>er', vim.lsp.buf.remove_workspace_folder, 'workspac[e]: [r]emove folder')
          map('<leader>el', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, 'workspac[e]: [l]ist folders')

          vim.api.nvim_buf_create_user_command(event.buf, 'Format', function(_)
            vim.lsp.buf.format()
          end, { desc = 'Format current buffer with LSP' })
        end,
      })

      --[[ cfg_lazy_lsp_servers ]]
      local servers = {
        lua_ls = {},
        ts_ls = {
          filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue' },
          init_options = {
            plugins = {
              {
                -- https://github.com/vuejs/language-tools/wiki/Neovim
                languages = { 'vue' },
                location = vim.fn.stdpath 'data' .. '/mason/packages/vue-language-server/node_modules/@vue/language-server',
                name = '@vue/typescript-plugin',
              },
            },
          },
        },
      }

      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      for server, config in pairs(servers) do
        config.capabilities = vim.tbl_deep_extend('force', {}, capabilities, config.capabilities or {})
        vim.lsp.config(server, config)
      end

      require('mason-lspconfig').setup {
        automatic_enable = true,
        ensure_installed = {
          'lua_ls',
          'ts_ls',
          'vue_ls',
        },
      }
    end,
  },
  --[[ cfg_lazy_cmp: Autocompletion ]]
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
    },
    config = function()
      local cmp = require 'cmp'

      cmp.setup {
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
        },
        --[[ cfg_lazy_cmp_keymaps ]]
        mapping = cmp.mapping.preset.insert {
          ['<C-Space>'] = cmp.mapping.complete {},
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<Esc>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'path' },
        },
      }
    end,
  },
  --[[ cfg_lazy_treesitter: Highlight, edit, and navigate code ]]
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        --[[ cfg_lazy_treesitter_langs ]]
        ensure_installed = {
          'vim',
          'vimdoc',
          'lua',
          'javascript',
          'typescript',
          'tsx',
          'vue',
          'html',
          'css',
          'scss',
        },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },

        --[[ cfg_lazy_treesitter_keymaps ]]

        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<c-space>',
            node_incremental = '<c-space>',
            node_decremental = '<M-space>',
            scope_incremental = '<c-s>',
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ['aa'] = '@parameter.outer',
              ['ia'] = '@parameter.inner',
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
            },
          },
        },
      }
    end,
  },
}, {
  -- lazy.nvim options
  lockfile = '~/dotfiles/nvim/lazy-lock.json',
  ui = {
    backdrop = 100,
    border = 'solid',
    size = { width = 0.85, height = 0.7 },
    icons = {
      cmd = '[cmd]',
      config = '[cfg]',
      event = '[e]',
      favorite = '[*]',
      ft = '[ft]',
      init = '[init]',
      import = '[import]',
      keys = '[keys]',
      lazy = '[lazy]',
      plugin = '[plugin]',
      runtime = '[runtime]',
      require = '[require]',
      source = '</>',
      start = '[+]',
    },
  },
})

-- vim: ts=2 sts=2 sw=2 et
