local pid = vim.fn.getpid()
local lspconfig = require('lspconfig')
local lsp_servers_path = vim.fn.stdpath('data') .. '/lsp_servers'

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local lsp_servers = {'omnisharp', 'gopls' , 'fsautocomplete', 'vimls', 'yamlls',  'angularls', 'dockerls', 'tsserver', 'terraformls', 'vls', 'cssls', 'jsonls', 'pyright', 'html', 'sumneko_lua', 'ltex' }

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
    }
  elseif server == 'ltex' then
    lspconfig[server].setup {
       cmd = { lsp_servers_path .. '/ltex-ls/bin/ltex-ls.bat' },
       settings = {
         ltex = {
           enabled= {"latex", "tex", "bib", "md"},
           checkFrequency="save",
           language="fr-CA"
         }
       }
    }
  elseif server == 'gopls' then
    lspconfig[server].setup {
      cmd = { 'gopls', '-log', 'debug', '-mode', 'go' },
      capabilities = capabilities,
    }
  elseif server == 'sumneko_lua' then
      lspconfig[server].setup {
        cmd = {sumneko_binary, '-E', sumneko_root_path .. '/main.lua'};
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
              library = vim.api.nvim_get_runtime_file("", true),
          },
           telemetry = {
             enable = false,
          },
       },
     },
     capabilities = capabilities,
  }
  else
    lspconfig[server].setup { capabilities = capabilities }
  end
end

