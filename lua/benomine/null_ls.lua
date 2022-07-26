local status_null, null_ls = pcall(require, 'null-ls')
if not status_null then
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local actions = null_ls.builtins.code_actions

null_ls.setup {
  debug = false,
  sources = {
    formatting.prettier.with {
      filetypes = {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
        'vue',
        'css',
        'scss',
        'less',
        'html',
        'json',
        'yaml',
        'markdown',
        'graphql',
        'solidity',
      },
      extra_args = { '--no-semi', '--single-quote', '--jsx-single-quote' },
    },
    formatting.black.with({ extra_args = { '--fast' } }),
    formatting.stylua,
    diagnostics.sqlfluff.with({
      extra_args = { "--dialect", "postgres" }
    }),
    actions.gitsigns
  },
}
