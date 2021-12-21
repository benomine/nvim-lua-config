local pid = vim.fn.getpid()
local lspconfig = require('lspconfig')
local lsp_servers_path = vim.fn.stdpath('data') .. '/lsp_servers'

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local on_attach = function(_ , bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap=true, silent=true }

  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

local lsp_servers = {
  'omnisharp',
  'gopls',
  'fsautocomplete',
  'vimls',
  'yamlls',
  'dockerls',
  'tsserver',
  'vuels',
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
}

local omnisharp_path_bin = lsp_servers_path .. '/omnisharp/Omnisharp.exe'

local system_name
if vim.fn.has('mac') == 1 then
  system_name = 'macOS'
elseif vim.fn.has('unix') == 1 then
  system_name = 'Linux'
elseif vim.fn.has('win32') == 1 then
  system_name = 'Windows'
else
  print('Unsupported system for sumneko')
end

local sumneko_root_path = lsp_servers_path ..'/sumneko_lua/lua-language-server'
local sumneko_binary = sumneko_root_path..'/bin/'..system_name..'/lua-language-server'
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

for _, server in ipairs(lsp_servers) do
  if server == 'omnisharp' then
    lspconfig[server].setup {
      cmd = { omnisharp_path_bin, '--languageserver', '--hostPID', tostring(pid) },
      capabilities = capabilities,
      on_attach = on_attach,
    }
  elseif server == 'fsautocomplete' then
    lspconfig[server].setup {
      cmd = { lsp_servers_path .. '/fsautocomplete/fsautocomplete.exe', '--background-service-enabled' },
      capabilities = capabilities,
      on_attach = on_attach,
    }
  elseif server == 'ltex' then
    lspconfig[server].setup {
      cmd = { lsp_servers_path .. '/ltex-ls/bin/ltex-ls.bat' },
      settings = {
        ltex = {
          enabled = { 'latex', 'tex', 'bib', 'md' },
          checkFrequency = 'save',
          language = 'fr-CA'
        }
      },
      on_attach = on_attach,
    }
  elseif server == 'gopls' then
    lspconfig[server].setup {
      cmd = { 'gopls', '-log', 'debug', '-mode', 'go' },
      capabilities = capabilities,
      on_attach = on_attach,
    }
  elseif server == 'jsonls' then
    lspconfig[server].setup {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        json = {
          schemas = require('schemastore').json.schemas(),
        },
      },
    }
  elseif server == 'groovyls' then
    lspconfig[server].setup {
      cmd = { 'java', '-jar', lsp_servers_path .. '/groovyls/build/libs/groovyls-all.jar' },
      capabilities = capabilities,
      on_attach = on_attach,
    }
  elseif server == 'sumneko_lua' then
    lspconfig[server].setup {
      cmd = {sumneko_binary, '-E', sumneko_root_path .. '/main.lua'};
      on_attach = on_attach,
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
            path = runtime_path,
          },
          diagnostics = {
            globals = {'vim'},
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file('', true),
          },
          telemetry = {
            enable = false,
          },
        },
      },
      capabilities = capabilities,
    }
  else
    lspconfig[server].setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }
  end
end

local null_ls = require('null-ls')

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

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
    formatting.black.with { extra_args = { '--fast' } },
    formatting.stylua,
  },
}

require('flutter-tools').setup{}
