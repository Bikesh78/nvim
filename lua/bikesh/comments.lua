local status_ok, comment = pcall(require, "Comment")
if not status_ok then
  return
end

comment.setup {
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
}

require('ts_context_commentstring').setup {
  enable_autocmd = false,
  languages = {
  --     javascript = {
  --       __default = '// %s',
  --       jsx_element = '{/* %s */}',
  --       jsx_fragment = '{/* %s */}',
  --       jsx_attribute = '// %s',
  --       comment = '// %s',
  --     },
    typescript = '// %s',
  },
}
