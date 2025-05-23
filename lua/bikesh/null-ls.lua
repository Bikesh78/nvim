local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
  debug = true,
  -- format on save
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
  -- select sources
  sources = {
    -- null_ls.builtins.formatting.prettierd,
    -- null_ls.builtins.diagnostics.golangci_lint,
    -- null_ls.builtins.formatting.eslint,
    --null_ls.builtins.formatting.stylua,
    -- null_ls.builtins.diagnostics.eslint_d,
    -- null_ls.builtins.diagnostics.pylint,
    --null_ls.builtins.completion.spell,
  },
})
