-- Add installed language server
local servers = {
  -- 'tsserver',
  'ts_ls',
  'lua_ls',
  'cssls',
  'emmet_ls',
  'html',
  "tailwindcss",
  "eslint",
  -- "gopls",
  "bashls",
  -- "golangci_lint_ls",
  -- "phpactor",
  "intelephense",
  "pyrefly",
}

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Set up server configs (nvim 0.11 native, merged on top of nvim-lspconfig's defaults)
vim.lsp.config('*', { capabilities = capabilities })
vim.lsp.config('tailwindcss', { -- add lsp support for cva
  settings = {
    tailwindCSS = {
      classFunctions = { "cva", "cx" },
    },
  },
})

-- find the project's python: active venv, then .venv/venv in the root, then poetry's venv
local function python_path(root)
  if vim.env.VIRTUAL_ENV then
    return vim.env.VIRTUAL_ENV .. '/bin/python'
  end
  for _, dir in ipairs({ '.venv', 'venv' }) do
    local path = root .. '/' .. dir .. '/bin/python'
    if vim.uv.fs_stat(path) then
      return path
    end
  end
  if vim.uv.fs_stat(root .. '/poetry.lock') and vim.fn.executable('poetry') == 1 then
    local result = vim.system({ 'poetry', 'env', 'info', '-p' }, { cwd = root, text = true }):wait()
    if result.code == 0 and result.stdout ~= '' then
      return vim.trim(result.stdout) .. '/bin/python'
    end
  end
end

vim.lsp.config('pyrefly', {
  settings = { python = {} }, -- filled in by before_init; pyrefly reads python.pythonPath
  before_init = function(_, config)
    local path = config.root_dir and python_path(config.root_dir)
    if path then
      config.settings.python.pythonPath = path
    end
  end,
})

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gd', ":lua require('telescope.builtin').lsp_definitions()<CR>", bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<k', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', 'gr', ":lua require('telescope.builtin').lsp_references()<CR>", bufopts)
  vim.keymap.set('n', '<space>lf', function() vim.lsp.buf.format { async = true } end, bufopts)
  vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
end

-- run on_attach for every server; an autocmd isn't overridden by
-- nvim-lspconfig's per-server on_attach (eslint, ts_ls, ...)
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    on_attach(vim.lsp.get_client_by_id(args.data.client_id), args.buf)
  end,
})

-- set up mason and mason-lspconfig
-- automatic_enable only starts the servers listed above, not everything installed in mason
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = servers,
  automatic_enable = servers,
})
