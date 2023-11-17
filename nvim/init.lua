-- Leader keymaps
local leader = ' '
vim.g.mapleader = leader
vim.g.maplocalleader = leader
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Use the Enter key as the second Leader
vim.keymap.set({ 'n', 'v' }, '<CR>', leader, { silent = true, remap = true })
vim.keymap.set({ 'n', 'v' }, '<CR><CR>', '<CR>', { silent = true, remap = false })

-- Install package manager
-- https://github.com/folke/lazy.nvim
-- See `:help lazy.nvim.txt` for more info
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
  -- Backup mainstream colorscheme inspired by Atom
  'navarasu/onedark.nvim',
  { -- Main colorscheme
    'He4eT/desolate.nvim',
    dependencies = {
      'rktjmp/lush.nvim',
    },
  },
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
  },
  { -- FZF
    'ibhagwan/fzf-lua',
    dependencies = {
      {
        'junegunn/fzf',
        build = './install --bin',
      },
    },
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
  { -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
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
  { -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        component_separators = '|',
        section_separators = '',
        globalstatus = true,
      },
    },
  },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },
  {
    'Exafunction/codeium.vim',
    keys = { { '<C-h>', mode = 'i' } },
    config = function()
      vim.g.codeium_manual = 1
      vim.g.codeium_disable_bindings = 1
      vim.keymap.set('i', '<C-h>', function()
        return vim.fn['codeium#Complete']()
      end, { expr = true })
      vim.keymap.set('i', '<C-l>', function()
        return vim.fn['codeium#Accept']()
      end, { expr = true })
      vim.keymap.set('i', '<C-u>', function()
        return vim.fn['codeium#Clear']()
      end, { expr = true })

      vim.keymap.set('i', '<C-j>', function()
        vim.fn['codeium#CycleCompletions'](1)
        print(vim.fn['codeium#GetStatusString']())
      end, { expr = true })

      vim.keymap.set('i', '<C-k>', function()
        vim.fn['codeium#CycleCompletions'](-1)
        print(vim.fn['codeium#GetStatusString']())
      end, { expr = true })
    end,
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

-- [[ Setting options ]]
-- See `:help vim.o`

-- Set window title
vim.o.title = true
vim.o.titlestring = '%F'

-- Hide mode in cmd
vim.o.showmode = false

-- Set highlight on search
vim.o.hlsearch = false

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

-- [[ Appearance ]]

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Set dark background
vim.o.background = 'dark'

-- Set colorscheme options
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

-- Set colorscheme
vim.cmd.colorscheme 'desolate'

-- Disable line numbers for terminal buffers
vim.api.nvim_create_autocmd({ 'TermOpen' }, { pattern = { '*' }, command = 'setlocal nonumber' })

-- Tune diagnostic signs
local signs = { Error = '■ ', Warn = '■ ', Hint = '■ ', Info = '■ ' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- [[ Basic Keymaps ]]

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Remap PgUp/PgDown to C-u/C-d
vim.keymap.set('n', '<PageDown>', '<C-d>', { silent = true })
vim.keymap.set('n', '<PageUp>', '<C-u>', { silent = true })

-- Open terminal
vim.keymap.set({ 'n' }, '<leader>t', ':terminal<CR>i', { silent = true })

-- Escaping Terminal mode
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

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Configure Leap ]]
require('leap').add_default_mappings()
require('leap').opts.highlight_unlabeled_phase_one_targets = true
require('leap').opts.safe_labels = {}

-- [[ Configure fzf-lua ]]
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

local fzf_grep_current_file = function ()
  fzf.grep({ search = vim.fn.expand('%:t') })
end

local fzf_git_history = function ()
  fzf.files({ cmd = "git log --name-only --pretty=\"\" | sed -e '/^\\s*$/d' | awk '!seen[$0]++'" })
end
-- fzf keymaps

vim.keymap.set({ 'n' }, 'gr', fzf.lsp_references, { desc = 'LSP: [G]o to fzf [R]eference list' })
vim.keymap.set({ 'n' }, '<leader>fu', fzf_grep_current_file, { desc = '[F]zf: current file [U]sage' })

vim.keymap.set({ 'n' }, '<leader>fp', fzf.builtin, { desc = '[F]zf: [p]allete' })
vim.keymap.set({ 'n' }, '<leader>f.', fzf.resume, { desc = '[F]zf: Resume' })

vim.keymap.set({ 'n' }, '<leader>b', fzf.buffers, { desc = '[F]zf: [B]uffers' })
vim.keymap.set({ 'n' }, '<BS>', fzf.buffers, { desc = '[F]zf: [B]uffers' })

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

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
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
        -- You can use the capture groups defined in textobjects.scm
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

vim.filetype.add({
  extension = {
    pcss = 'css',
  }
})

local prevent_lsp_conflicts = function(starting_client)
  -- Note: check autostart parameter in server config.
  -- https://www.reddit.com/r/neovim/comments/10n795v/comment/j689u7k/
  local active_clients = vim.lsp.get_active_clients()

  -- Stop 'tsserver' when 'volar' starts
  if starting_client.name == 'volar' then
    for _, active_client in pairs(active_clients) do
      if active_client.name == 'tsserver' then
        active_client.stop()
      end
    end
  end

  -- Do not start 'tsserver' if 'volar' is running
  if starting_client.name == 'tsserver' then
    for _, active_client in pairs(active_clients) do
      if active_client.name == 'volar' then
        starting_client.stop()
      end
    end
  end
end

-- [[ LSP settings ]]
-- This function gets run when an LSP connects to a particular buffer.
local on_attach = function(client, bufnr)
  prevent_lsp_conflicts(client)

  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  -- LSP keymaps

  -- See `:help K` for why this keymap
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

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  lua_ls = {
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
}

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'solid',
})

require('lspconfig').tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  handlers = {
    -- Usually gets called after a code action
    -- like in moving an anonymous function to outer scope
    -- https://github.com/jose-elias-alvarez/typescript.nvim/issues/17
    ['_typescript.rename'] = function(_, result)
      local line = result.position.line
      local character = result.position.character
      local column = vim.str_byteindex(vim.fn.getline '.', character, true)
      vim.api.nvim_win_set_cursor(0, { line + 1, column })
      vim.lsp.buf.rename()
      return result
    end,
    -- 'Go to definition' workaround
    -- https://github.com/holoiii/nvim/commit/73a4db74fe463f5064346ba63870557fedd134ad
    ['textDocument/definition'] = function(err, result, ...)
      result = vim.tbl_islist(result) and result[1] or result
      vim.lsp.handlers['textDocument/definition'](err, result, ...)
    end,
  },
}

require('lspconfig').volar.setup {
  autostart = false,
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
}

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

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
