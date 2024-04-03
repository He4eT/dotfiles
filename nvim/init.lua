-- Leader keymaps
local leader = ' '
vim.g.mapleader = leader
vim.g.maplocalleader = leader
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Use the Enter key as the second Leader
vim.keymap.set({ 'n', 'v' }, '<CR>', leader, { silent = true, remap = true })
vim.keymap.set({ 'n', 'v' }, '<CR><CR>', '<CR>', { silent = true, remap = false })

-- [[ Setting options ]]
-- See `:help vim.o`

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

-- Disable line numbers for terminal buffers
vim.api.nvim_create_autocmd({ 'TermOpen' }, { pattern = { '*' }, command = 'setlocal nonumber' })

-- Tune diagnostic signs
local signs = { Error = '■ ', Warn = '■ ', Hint = '■ ', Info = '■ ' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Filetype aliases
vim.filetype.add {
  extension = {
    pcss = 'css',
  },
}

-- [[ Basic Keymaps ]]

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Remap PgUp/PgDown to C-u/C-d
vim.keymap.set('n', '<PageDown>', '<C-d>', { silent = true })
vim.keymap.set('n', '<PageUp>', '<C-u>', { silent = true })

-- Open terminal
vim.keymap.set({ 'n' }, '<leader>t', ':terminal<CR>i', { silent = true })

-- Escape terminal mode
vim.keymap.set({ 't' }, ';;', '<C-\\><C-n>', { silent = true })

-- Window managment
vim.keymap.set('n', '<leader>w', '<C-w>', { remap = true })
vim.keymap.set('n', '<leader>k', '<C-w>w', { remap = true })
vim.keymap.set('n', '<leader>K', ':vs<CR><C-w>w')
vim.keymap.set('n', '<leader>q', ':b#|bd#<CR>')
vim.keymap.set('n', '<leader>h', '<C-o>')
vim.keymap.set('n', '<leader>l', '<C-i>')

-- Copy'n'Paste
vim.keymap.set('n', '<leader>y', ':call system("xclip -i -selection clipboard", @@)<cr>')
vim.keymap.set('v', '<leader>y', '"+y')

-- Diagnostic
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open floating [d]iagnostic message' })
vim.keymap.set('n', '<leader>D', vim.diagnostic.setloclist, { desc = 'Open [D]iagnostics list' })

-- Gitsigns
vim.keymap.set('n', '[g', ':Gitsigns prev_hunk<CR>', { desc = 'Go to previous git hunk' })
vim.keymap.set('n', ']g', ':Gitsigns next_hunk<CR>', { desc = 'Go to next git hunk' })
vim.keymap.set('n', '<leader>gb', ':Gitsigns blame_line<CR>', { desc = 'Show git blame' })

-- Highlight
vim.keymap.set({ 'n' }, '<BS>', ':nohl<CR>', { desc = 'Turn off highlight' })
vim.keymap.set({ 'n' }, '<ESC>', ':nohl<CR>', { desc = 'Turn off highlight' })

-- [[ Highlight on yank ]]
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Lazy ]]
-- Install package manager
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
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',
  -- Color highlighter
  'norcalli/nvim-colorizer.lua',
  { -- `gc` to comment visual regions/lines
    'numToStr/Comment.nvim',
    opts = {},
  },
  { -- Leap motion plugin
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
  { -- Set lualine as statusline
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
  { -- Adds git releated signs to the gutter
    'lewis6991/gitsigns.nvim',
    opts = {
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
    },
  },
  { -- Main colorscheme
    'He4eT/desolate.nvim',
    config = function()
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
  -- Backup mainstream colorscheme inspired by Atom
  'navarasu/onedark.nvim',
  { -- FZF
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

      local fzf_git_history = function()
        fzf.files { cmd = "git log --name-only --pretty=\"\" | sed -e '/^\\s*$/d' | awk '!seen[$0]++'" }
      end

      -- fzf keymaps
      vim.keymap.set({ 'n' }, 'gr', fzf.lsp_references, { desc = 'LSP: [G]o to fzf [R]eference list' })
      vim.keymap.set({ 'n' }, '<leader>fu', fzf_grep_filename, { desc = '[F]zf: current file [U]sages' })

      vim.keymap.set({ 'n' }, '<leader>fp', fzf.builtin, { desc = '[F]zf: [p]allete' })
      vim.keymap.set({ 'n' }, '<leader>f.', fzf.resume, { desc = '[F]zf: Resume' })

      vim.keymap.set({ 'n' }, '<leader>b', fzf.buffers, { desc = '[F]zf: [B]uffers' })

      vim.keymap.set({ 'n' }, '<leader>fF', fzf_files, { desc = '[F]zf: all [F]iles' })
      vim.keymap.set({ 'n' }, '<leader>ff', fzf.git_files, { desc = '[F]zf: git [f]iles' })
      vim.keymap.set({ 'n' }, '<leader>fd', fzf.git_status, { desc = '[F]zf: git [d]iff' })
      vim.keymap.set({ 'n' }, '<leader>fh', fzf_git_history, { desc = '[F]zf: git [h]istory' })

      vim.keymap.set({ 'n' }, '<leader>fg', fzf.live_grep, { desc = '[F]zf: [g]rep' })
      vim.keymap.set({ 'n' }, '<leader>fw', fzf.grep_cword, { desc = '[F]zf: grep [w]' })
      vim.keymap.set({ 'n' }, '<leader>fW', fzf.grep_cWORD, { desc = '[F]zf: grep [W]' })

      vim.keymap.set({ 'n' }, '<leader>p', fzf.registers, { desc = '[F]zf: [p]aste' })
      vim.keymap.set({ 'n' }, '<leader>/', fzf.blines, { desc = '[F]zf: buffer lines' })
      vim.keymap.set({ 'n' }, '<leader>f?', fzf.keymaps, { desc = '[F]zf: keymaps' })
      vim.keymap.set({ 'n' }, '<leader>f/', fzf.search_history, { desc = '[F]zf: search history' })
      vim.keymap.set({ 'n' }, '<leader>f:', fzf.command_history, { desc = '[F]zf: command history' })
    end,
  },
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      { -- Automatically install LSPs to stdpath for neovim
        'williamboman/mason.nvim',
        config = true,
      },
      'williamboman/mason-lspconfig.nvim',
    },
  },
  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
  },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
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
  {
    'nomnivore/ollama.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    cmd = { 'Ollama', 'OllamaModel' },
    keys = {
      {
        '<leader>j',
        ':Ollama<CR>',
        desc = 'Ollama Menu',
        mode = { 'v' },
      },
      {
        '<leader>j',
        ":lua require('ollama').prompt('Generate_Code')<cr>",
        desc = 'Ollama Code Generation',
        mode = { 'n' },
      },
    },
    opts = {
      model = 'mistral',
      url = 'http://ollama.internal:11434', -- see /etc/hosts
      prompts = {
        Ask_About_Code = false,
        Simplify_Code = false,
        Improve_Text = {
          prompt = 'Make this text simple and readable. Respond with improved version of this text: ```$sel```',
          extract = false,
          action = 'replace',
        },
        Modify_Text = {
          prompt = 'Modify this text in the following way: $input\n\n' .. '```$sel```',
          extract = false,
          action = 'replace',
        },
        Use_selection_as_prompt = {
          prompt = '$sel',
          extract = false,
          action = 'replace',
        },
      },
    },
  },
}, {
  -- Lazy options
  ui = {
    size = { width = 0.85, height = 0.7 },
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

-- [[ LSP settings ]]
-- This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  -- LSP keymaps

  -- Hover Documentation
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Basic LSP functionality
  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]tion')
  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>gD', vim.lsp.buf.type_definition, 'Type Definition')

  -- LSP workspace managment
  nmap('<leader>ea', vim.lsp.buf.add_workspace_folder, 'Workspac[e] [A]dd Folder')
  nmap('<leader>er', vim.lsp.buf.remove_workspace_folder, 'Workspac[e] [R]emove Folder')
  nmap('<leader>el', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, 'Workspac[e] [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Enable the following language servers
local servers = {
  lua_ls = {
    settings = {
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {
            'vim',
            'require',
          },
        },
      },
    },
  },
  tsserver = {
    on_attach = on_attach,
    capabilities = capabilities,
    init_options = {
      plugins = {
        {
          name = '@vue/typescript-plugin',
          location = require('mason-registry').get_package('vue-language-server'):get_install_path() .. '/node_modules/@vue/language-server',
          languages = { 'vue' },
        },
      },
    },
    filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
    handlers = {
      -- Usually gets called after another code action
      -- https://github.com/jose-elias-alvarez/typescript.nvim/issues/17
      ['_typescript.rename'] = function(_, result)
        return result
      end,
      -- 'Go to definition' workaround
      -- https://github.com/holoiii/nvim/commit/73a4db74fe463f5064346ba63870557fedd134ad
      ['textDocument/definition'] = function(err, result, ...)
        result = vim.tbl_islist(result) and result[1] or result
        vim.lsp.handlers['textDocument/definition'](err, result, ...)
      end,
    },
  },
  volar = {},
}

require('mason-lspconfig').setup {
  ensure_installed = vim.tbl_keys(servers),
  handlers = {
    function(server_name)
      local server = servers[server_name] or {}
      server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
      require('lspconfig')[server_name].setup(server)
    end,
  },
}

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'solid',
})

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'

luasnip.config.setup {
  -- https://stackoverflow.com/questions/70366949/
  region_check_events = 'CursorHold,InsertLeave',
  delete_check_events = 'TextChanged,InsertEnter',
}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },
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
  },
}

-- npx @johnnymorganz/stylua-bin ./init.lua
-- vim: ts=2 sts=2 sw=2 et
