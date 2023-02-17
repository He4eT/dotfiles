-- Install packer

local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  vim.cmd [[packadd packer.nvim]]
end

-- stylua: ignore start
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Package manager

  use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically
  use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } } -- Add git related info in the signs columns and popups
  use { 'L3MON4D3/LuaSnip', requires = { 'saadparwaiz1/cmp_luasnip' } } -- Snippet Engine and Snippet Expansion

  use 'nvim-treesitter/nvim-treesitter' -- Highlight, edit, and navigate code

  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use 'williamboman/mason.nvim' -- Automatically install language servers to stdpath
  use 'williamboman/mason-lspconfig.nvim'
  use { 'hrsh7th/nvim-cmp', requires = { 'hrsh7th/cmp-nvim-lsp' } } -- Autocompletion

  use 'ggandor/leap.nvim' -- Motion plugin
  use 'tpope/vim-repeat' -- Fixup dot-repeat

  use 'ibhagwan/fzf-lua' -- Performant and lightweight fzf client
  use { 'junegunn/fzf', run = "./install --bin" }

  use 'nvim-lualine/lualine.nvim' -- Fancier statusline

  use 'mjlbach/onedark.nvim' -- Theme inspired by Atom
  use 'rktjmp/lush.nvim'
  use 'He4eT/desolate.nvim'

  if is_bootstrap then
    require('packer').sync()
  end
end)
-- stylua: ignore end

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})

-- [[ Setting options ]]
-- See `:help vim.o`

vim.o.title = true
vim.o.titlestring = '%F'
vim.o.showmode = false

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = false
vim.o.wrap = false
vim.o.cursorline = true
vim.o.fillchars = 'eob: '

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set colorscheme
vim.o.termguicolors = true
vim.cmd [[colorscheme desolate]]

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
-- NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Escaping Terminal mode
vim.keymap.set({ 't' }, ';;', '<C-\\><C-n>', { silent = true })

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

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

-- Set lualine as statusline
-- See `:help lualine.txt`
require('lualine').setup {
  options = {
    icons_enabled = false,
    component_separators = '|',
    section_separators = '',
    globalstatus = true,
  },
}

-- Enable Comment.nvim
require('Comment').setup()

-- Gitsigns
-- See `:help gitsigns.txt`
require('gitsigns').setup {
  signs = {
    add = { text = '│' },
    change = { text = '│' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '│' },
  },
}

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'help', 'lua', 'typescript', 'tsx', 'javascript', 'vue', 'html', 'css', 'scss' },

  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
    },
  },
  rainbow = {
    enable = false,
    extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
    max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
  }
}

-- Window managment

vim.keymap.set('n', '<leader>w', '<C-w>', { remap = true })
vim.keymap.set('n', '<leader>k', '<C-w>w', { remap = true })
vim.keymap.set('n', '<leader>K', ':vs<CR>')
vim.keymap.set('n', '<leader>q', ':b#|bd#<CR>')
vim.keymap.set('n', '<leader>h', '<C-o>')
vim.keymap.set('n', '<leader>l', '<C-i>')

-- Copy'n'Paste

vim.keymap.set('n', '<leader>y', ':call system("xclip -i -selection clipboard", @@)<cr>')
vim.keymap.set('v', '<leader>y', '"+y')

-- Diagnostic keymaps

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>E', vim.diagnostic.setloclist)

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]tion')
  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type Definition')
  nmap('<leader>ea', vim.lsp.buf.add_workspace_folder, 'Workspac[e] [A]dd Folder')
  nmap('<leader>er', vim.lsp.buf.remove_workspace_folder, 'Workspac[e] [R]emove Folder')
  nmap('<leader>el', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, 'Workspac[e] [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', vim.lsp.buf.format or vim.lsp.buf.formatting,
    { desc = 'Format current buffer with LSP' })
end

-- nvim-cmp supports additional completion capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Enable the following language servers
local servers = { 'tsserver', 'sumneko_lua' }

-- Ensure the servers above are installed
require("mason").setup {}
require("mason-lspconfig").setup {
  ensure_installed = servers,
}

for _, lsp in ipairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "solid",
})

-- Example custom configuration for lua
--
-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

require('lspconfig').sumneko_lua.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = { library = vim.api.nvim_get_runtime_file('', true) },
    },
  },
}

-- nvim-cmp setup

local cmp = require 'cmp'
local luasnip = require 'luasnip'

if cmp ~= nil then
  cmp.setup {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete({}),
      ['<CR>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
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
end

-- FZF

local fzf = require('fzf-lua')

fzf.setup({
  border = 'single',
  fullscreen = true,

  previewers = {
    builtin = {
      syntax = true,
      syntax_limit_b = 1024*64, -- syntax limit (bytes), 0=nolimit
    }
  },

  grep = {
    rg_opts = "--vimgrep --smart-case --max-columns=512",
    file_ignore_patterns = {
      "^node_modules/",
      "/node_modules/",
      "^.git/",
      "^.yarn/"
    },
  },

  fzf_opts = {
    ['--border'] = 'none'
  },
  fzf_colors = {
      ["fg"]          = { "fg", "CursorLine" },
      ["bg"]          = { "bg", "Normal" },
      ["hl"]          = { "fg", "Comment" },
      ["fg+"]         = { "fg", "Normal" },
      ["bg+"]         = { "bg", "CursorLine" },
      ["hl+"]         = { "fg", "Statement" },
      ["info"]        = { "fg", "PreProc" },
      ["prompt"]      = { "fg", "Conditional" },
      ["pointer"]     = { "fg", "Exception" },
      ["marker"]      = { "fg", "Keyword" },
      ["spinner"]     = { "fg", "Label" },
      ["header"]      = { "fg", "Comment" },
      ["gutter"]      = { "bg", "Normal" },
  },
})

local fzf_files = function()
  fzf.files({ fd_opts = '--no-ignore --hidden' })
end

vim.keymap.set({ 'n' }, 'gr', fzf.lsp_references)

vim.keymap.set({ 'n' }, '<leader>ff', fzf.git_files)
vim.keymap.set({ 'n' }, '<leader>fF', fzf_files)
vim.keymap.set({ 'n' }, '<leader>fg', fzf.live_grep)
vim.keymap.set({ 'n' }, '<leader>fd', fzf.git_status)

vim.keymap.set({ 'n' }, '<leader>fp', fzf.builtin)
vim.keymap.set({ 'n' }, '<leader>f:', fzf.command_history)
vim.keymap.set({ 'n' }, '<leader>f/', fzf.search_history)
vim.keymap.set({ 'n' }, "<leader>f'", fzf.registers)
vim.keymap.set({ 'n' }, '<leader>f?', fzf.keymaps)
vim.keymap.set({ 'n' }, '<leader>f.', fzf.resume)
vim.keymap.set({ 'n' }, '<leader>fw', fzf.grep_cword)
vim.keymap.set({ 'n' }, '<leader>fW', fzf.grep_cWORD)

vim.keymap.set({ 'n' }, '<leader>/', fzf.blines)
vim.keymap.set({ 'n' }, '<leader>b', fzf.buffers)

-- Leap Motion

require('leap').add_default_mappings()
require('leap').opts.highlight_unlabeled_phase_one_targets = true
require('leap').opts.safe_labels = {}

vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })
vim.api.nvim_set_hl(0, 'LeapLabelPrimary', { link = 'Identifier' })
vim.api.nvim_set_hl(0, 'LeapMatch', { link = 'Constant' })

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
