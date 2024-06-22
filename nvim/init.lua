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
   ├─ cfg_lazy_vim_sleuth: Detect tabstop and shiftwidth automatically
   ├─ cfg_lazy_vim_surround: Delete, change and add such surroundings in pairs
   ├─ cfg_lazy_colorizer: Color highlighter
   ├─ cfg_lazy_comment: Toggles linewise and blockwise comments
   ├─ cfg_lazy_leap: Leap motion plugin
   ├─ cfg_lazy_lualine: Statusline
   ├─ cfg_lazy_gitsigns: Git-releated actions and gutter signs
   ├─ cfg_lazy_desolate: Not-so-colorful colorscheme
   ├─ cfg_lazy_onedark: Colorscheme inspired by Atom
   ├─ cfg_lazy_fzf: Fuzzy search
   │  └─ cfg_lazy_fzf_keymaps
   ├─ cfg_lazy_lsp: LSP configuration & plugins
   │  ├─ cfg_lazy_lsp_servers
   │  │  ├─ cfg_lazy_lsp_servers_lua
   │  │  ├─ cfg_lazy_lsp_servers_tsserver
   │  │  └─ cfg_lazy_lsp_servers_volar
   │  └─ cfg_lazy_lsp_keymaps
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
vim.keymap.set({ 'n', 'v' }, '<CR>', leader, { silent = true, remap = true })
vim.keymap.set({ 'n', 'v' }, '<CR><CR>', '<CR>', { silent = true, remap = false })

--[[ cfg_options: See `:help vim.o` ]]

-- Set window title
vim.o.title = true
vim.o.titlestring = '%F'

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
vim.o.timeout = false

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Keeps the same screen lines in all split windows
vim.o.splitkeep = 'screen'

--[[ cfg_filetypes: Filetype aliases ]]

vim.filetype.add {
  extension = {
    pcss = 'css',
  },
}

--[[ cfg_cmds: Commands ]]

-- Ignore :EditQuery command
vim.cmd 'command E Explore'

--[[ cfg_autocmds: Autocomands ]]

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Default insert mode in terminal buffers
local terminal_enter_group = vim.api.nvim_create_augroup('TerminalEnter', { clear = true })
vim.api.nvim_create_autocmd('BufEnter', {
  group = terminal_enter_group,
  pattern = 'term://*',
  command = 'startinsert',
})

-- Disable line numbers for terminal buffers
vim.api.nvim_create_autocmd('TermOpen', { pattern = '*', command = 'setlocal nonumber' })

--[[ cfg_keymaps: General keymaps ]]

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Remap PgUp/PgDown to C-u/C-d
vim.keymap.set('n', '<PageDown>', '<C-d>', { silent = true, desc = 'Ctrl + d but PageDown' })
vim.keymap.set('n', '<PageUp>', '<C-u>', { silent = true, desc = 'Ctrl + u but PageUp' })

-- Open terminal
vim.keymap.set({ 'n' }, '<leader>t', ':terminal<CR>i', { silent = true, desc = 'Open terminal here' })

-- Escape terminal mode
vim.keymap.set({ 't' }, ';;', '<C-\\><C-n>', { silent = true, desc = 'Escape terminal mode' })
vim.keymap.set({ 't' }, ';k', '<C-\\><C-n><C-w>w', { silent = true, desc = 'Jump away from terminal' })

-- Window managment
vim.keymap.set('n', '<leader>w', '<C-w>', { remap = true, desc = 'Alias for Ctrl + w' })
vim.keymap.set('n', '<leader>k', '<C-w>w', { remap = true, desc = 'Jump to the next window' })
vim.keymap.set('n', '<leader>K', ':vs<CR><C-w>w', { desc = 'Split window to ther right' })
vim.keymap.set('n', '<leader>q', ':b#|bd#<CR>', { desc = 'Close current buffer ' })
vim.keymap.set('n', '<leader>h', '<C-o>', { desc = 'Go back' })
vim.keymap.set('n', '<leader>l', '<C-i>', { desc = 'Go forward' })

-- Copy'n'Paste
vim.keymap.set('n', '<leader>y', ':call system("xclip -i -selection clipboard", @@)<cr>', { desc = 'Copy " to system clipboard' })
vim.keymap.set('v', '<leader>y', '"+y', { desc = 'Copy selection to system clipboard' })

-- Diagnostic
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open floating [d]iagnostic message' })
vim.keymap.set('n', '<leader>D', vim.diagnostic.setloclist, { desc = 'Open [D]iagnostics list' })

-- Highlight
vim.keymap.set({ 'n' }, '<BS>', ':nohl<CR>', { silent = true, desc = 'Turn off highlight' })
vim.keymap.set({ 'n' }, '<ESC>', ':nohl<CR>', { silent = true, desc = 'Turn off highlight' })

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
  --[[ cfg_lazy_vim_sleuth: Detect tabstop and shiftwidth automatically ]]
  'tpope/vim-sleuth',
  --[[ cfg_lazy_vim_surround: Delete, change and add surroundings in pairs ]]
  'tpope/vim-surround',
  --[[ cfg_lazy_colorizer: Color highlighter ]]
  'norcalli/nvim-colorizer.lua',
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
        icons_enabled = false,
        component_separators = '|',
        section_separators = '',
        globalstatus = true,
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
        preview_config = {
          border = 'solid',
        },
      }

      vim.keymap.set('n', '[g', ':Gitsigns prev_hunk<CR>', { desc = 'Go to previous git hunk' })
      vim.keymap.set('n', ']g', ':Gitsigns next_hunk<CR>', { desc = 'Go to next git hunk' })
      vim.keymap.set('n', '<leader>gb', ':Gitsigns blame_line<CR>', { desc = 'Show git blame' })
    end,
  },
  --[[ cfg_lazy_desolate: Not-so-colorful colorscheme ]]
  {
    'He4eT/desolate.nvim',
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
    dependencies = {
      'rktjmp/lush.nvim',
    },
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
        winopts = {
          border = 'single',
          fullscreen = true,
          previewers = {
            builtin = {
              syntax = true,
              syntax_limit_b = 1024 * 64, -- syntax limit (bytes), 0=nolimit
            },
          },
        },
        grep = {
          rg_opts = '--vimgrep --smart-case --max-columns=512'
            .. ' --color=ansi'
            .. ' --colors path:fg:yellow'
            .. ' --colors line:fg:green'
            .. ' --colors column:fg:blue'
            .. ' --colors match:fg:red',
          file_ignore_patterns = {
            '^node_modules/',
            '/node_modules/',
            '^.git/',
            '^.yarn/',
          },
        },
        fzf_opts = {
          ['--border'] = 'none',
          ['--preview-window'] = 'border-sharp',
        },
        fzf_colors = {
          ['fg'] = { 'fg', 'CursorLine' },
          ['bg'] = { 'bg', 'Normal' },
          ['hl'] = { 'fg', 'Comment' },
          ['fg+'] = { 'fg', 'Normal' },
          ['bg+'] = { 'bg', 'CursorLine' },
          ['hl+'] = { 'fg', 'Statement' },
          ['info'] = { 'fg', 'Normal' },
          ['prompt'] = { 'fg', 'Conditional' },
          ['pointer'] = { 'fg', 'Exception' },
          ['marker'] = { 'fg', 'Keyword' },
          ['spinner'] = { 'fg', 'Label' },
          ['header'] = { 'fg', 'Comment' },
          ['gutter'] = { 'bg', 'Normal' },
        },
      }

      local fzf_files = function()
        fzf.files { fd_opts = '--no-ignore --hidden' }
      end

      local fzf_grep_filename = function()
        fzf.grep { search = vim.fn.expand '%:t' }
      end

      local fzf_git_chronology = function()
        fzf.files { cmd = "git log --name-only --pretty=\"\" | sed -e '/^\\s*$/d' | awk '!seen[$0]++'" }
      end

      --[[ cfg_lazy_fzf_keymaps ]]

      vim.keymap.set({ 'n' }, '<leader>f.', fzf.resume, { desc = '[F]zf: Resume' })

      vim.keymap.set({ 'n' }, '<leader>b', fzf.buffers, { desc = '[F]zf: [B]uffers' })

      vim.keymap.set({ 'n' }, '<leader>fF', fzf_files, { desc = '[F]zf: all [F]iles' })
      vim.keymap.set({ 'n' }, '<leader>ff', fzf.git_files, { desc = '[F]zf: git [f]iles' })
      vim.keymap.set({ 'n' }, '<leader>fd', fzf.git_status, { desc = '[F]zf: git [d]iff' })
      vim.keymap.set({ 'n' }, '<leader>fh', fzf_git_chronology, { desc = '[F]zf: git c[h]ronology' })

      vim.keymap.set({ 'n' }, '<leader>f/', fzf.blines, { desc = '[F]zf: buffer lines' })
      vim.keymap.set({ 'n' }, '<leader>fg', fzf.live_grep, { desc = '[F]zf: [g]rep' })
      vim.keymap.set({ 'n' }, '<leader>fw', fzf.grep_cword, { desc = '[F]zf: grep [w]' })
      vim.keymap.set({ 'n' }, '<leader>fW', fzf.grep_cWORD, { desc = '[F]zf: grep [W]' })

      vim.keymap.set({ 'n' }, '<leader>fp', fzf.builtin, { desc = '[F]zf: [p]allete' })
      vim.keymap.set({ 'n' }, '<leader>p', fzf.registers, { desc = '[F]zf: [p]aste' })
      vim.keymap.set({ 'n' }, '<leader>?', fzf.keymaps, { desc = '[F]zf: keymaps' })
      vim.keymap.set({ 'n' }, '<leader>/', fzf.search_history, { desc = '[F]zf: search history' })
      vim.keymap.set({ 'n' }, '<leader>:', fzf.command_history, { desc = '[F]zf: command history' })

      -- LSP
      vim.keymap.set({ 'n' }, 'gr', fzf.lsp_references, { desc = 'LSP: [G]o to fzf [R]eference list' })
      vim.keymap.set({ 'n' }, '<leader>gd', fzf.lsp_definitions, { desc = 'LSP: [G]oto [d]efinition list' })
      vim.keymap.set({ 'n' }, '<leader>fu', fzf_grep_filename, { desc = '[F]zf: current file [U]sages' })
    end,
  },
  --[[ cfg_lazy_lsp: LSP configuration & plugins ]]
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'williamboman/mason.nvim',
        config = true,
      },
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      --[[ cfg_lazy_lsp_servers ]]
      local servers = {
        --[[ cfg_lazy_lsp_servers_lua ]]
        lua_ls = {
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
              diagnostics = {
                globals = {
                  'vim',
                  'require',
                },
              },
            },
          },
        },
        --[[ cfg_lazy_lsp_servers_tsserver ]]
        tsserver = {
          filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
          init_options = {
            plugins = {
              {
                name = '@vue/typescript-plugin',
                location = require('mason-registry').get_package('vue-language-server'):get_install_path() .. '/node_modules/@vue/language-server',
                languages = { 'vue' },
              },
            },
          },
          handlers = {
            -- Usually gets called after another code action
            -- https://github.com/jose-elias-alvarez/typescript.nvim/issues/17
            ['_typescript.rename'] = function(_, result)
              return result
            end,
            -- 'Go to definition' workaround
            -- https://github.com/holoiii/nvim/commit/73a4db74fe463f5064346ba63870557fedd134ad
            ['textDocument/definition'] = function(err, result, ...)
              result = vim.islist(result) and result[1] or result
              vim.lsp.handlers['textDocument/definition'](err, result, ...)
            end,
          },
        },
        --[[ cfg_lazy_lsp_servers_volar ]]
        volar = {},
      }

      --[[ cfg_lazy_lsp_keymaps ]]
      local setup_lsp_keymaps = function(_, bufnr)
        local nmap = function(keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end
          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end

        -- See also cfg_lazy_fzf_keymaps

        nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

        nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]tion')

        nmap('gd', vim.lsp.buf.definition, '[G]oto [d]efinition')
        nmap('gD', vim.lsp.buf.type_definition, '[G]oto type [D]efinition')
        nmap('<leader>gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        nmap('<leader>ea', vim.lsp.buf.add_workspace_folder, 'Workspac[e] [A]dd Folder')
        nmap('<leader>er', vim.lsp.buf.remove_workspace_folder, 'Workspac[e] [R]emove Folder')
        nmap('<leader>el', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, 'Workspac[e] [L]ist Folders')

        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
          vim.lsp.buf.format()
        end, { desc = 'Format current buffer with LSP' })
      end

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      require('mason-lspconfig').setup {
        ensure_installed = vim.tbl_keys(servers),
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.on_attach = setup_lsp_keymaps
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }

      -- LSP Appearance

      local diagnostic_icon = '⏹'

      -- Tune popup borders
      vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = 'solid',
      })

      -- Tune virtual_text diagnostic signs
      vim.diagnostic.config {
        virtual_text = {
          prefix = diagnostic_icon,
        },
      }

      -- Tune diagnostic signs
      local signs = { 'Error', 'Warn', 'Hint', 'Info' }
      for _, type in ipairs(signs) do
        local hl = 'DiagnosticSign' .. type
        vim.fn.sign_define(hl, { text = diagnostic_icon, texthl = hl, numhl = hl })
      end
    end,
  },
  --[[ cfg_lazy_cmp: Autocompletion ]]
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      local luasnip = require 'luasnip'

      luasnip.config.setup {
        -- https://stackoverflow.com/questions/70366949/
        region_check_events = 'CursorHold,InsertLeave',
        delete_check_events = 'TextChanged,InsertEnter',
      }

      local cmp = require 'cmp'

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        --[[ cfg_lazy_cmp_keymaps ]]
        mapping = cmp.mapping.preset.insert {
          ['<C-Space>'] = cmp.mapping.complete {},
          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          },
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
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
        indent = { enable = true, disable = { 'python' } },

        --[[ cfg_lazy_treesitter_keymaps ]]

        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<c-space>',
            node_incremental = '<c-space>',
            scope_incremental = '<c-s>',
            node_decremental = '<M-space>',
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              ['aa'] = '@parameter.outer',
              ['ia'] = '@parameter.inner',
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              [']m'] = '@function.outer',
              [']]'] = '@class.outer',
            },
            goto_next_end = {
              [']M'] = '@function.outer',
              [']['] = '@class.outer',
            },
            goto_previous_start = {
              ['[m'] = '@function.outer',
              ['[['] = '@class.outer',
            },
            goto_previous_end = {
              ['[M'] = '@function.outer',
              ['[]'] = '@class.outer',
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
              ['<leader>A'] = '@parameter.inner',
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
    size = { width = 0.85, height = 0.7 },
    backdrop = 100,
    border = 'solid',
    icons = {
      cmd = '[cmd]',
      config = '[cfg]',
      event = '[e]',
      ft = '[ft]',
      init = '[init]',
      keys = '[key]',
      plugin = '[plugin]',
      runtime = '[rt]',
      source = '[src]',
      start = '[active]',
      task = '[task]',
      lazy = '[lazy]',
    },
  },
})

-- vim: ts=2 sts=2 sw=2 et
