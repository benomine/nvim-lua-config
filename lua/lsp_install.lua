local status, servers = pcall(require, "nvim-lsp-installer.servers")
local _, lsp_installer = pcall(require, "nvim-lsp-installer")

lsp_installer.settings({
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})

if not status then
  return
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
  'powershell_es'
}

for _, server in pairs(lsp_servers) do
  local server_available , requested_server = servers.get_server(server)
  if server_available then
    if not requested_server:is_installed() then
      print(string.format("Installing %s", requested_server.name))
      requested_server:install()
    end
  end
end

