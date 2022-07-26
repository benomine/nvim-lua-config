local mason_status, mason = pcall(require, 'mason')
if not mason_status then
  return
end

mason.setup {
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = '➜',
      package_uninstalled = '✗'
    }
  }
}

local mason_config_status, mason_config = pcall(require, 'mason-lspconfig')
if not mason_config_status then
  return
end

mason_config.setup {
  ensure_installed = {
    'clangd',
    'omnisharp',
    'gopls',
    'fsautocomplete',
    'vimls',
    'yamlls',
    'dockerls',
    'tsserver',
    'volar',
    'cssls',
    'jsonls',
    'pyright',
    'html',
    'sumneko_lua',
    'ltex',
    'svelte',
    'groovyls',
    'sqlls',
    'dartls',
    'powershell_es',
    'rust_analyzer',
    'taplo',
    'jtdls',
    'sqlfluff',
  },
}
