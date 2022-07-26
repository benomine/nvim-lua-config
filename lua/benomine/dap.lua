local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
  return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
  return
end

-- local dap_install_status, dap_install = pcall(require, 'dap-install')
-- if not dap_install_status then
--   return
-- end
--
-- dap_install.setup {}
--
-- dap_install.config("python", {})
-- dap_install.config('rust', {})

dapui.setup()

-- dapui.setup {
--   layouts = {
--     {
--       elements = {
--         'scopes',
--         'breakpoints',
--         'stacks',
--         'watches',
--       },
--       size = 40,
--       position = 'left',
--     },
--     {
--       elements = {
--         'repl',
--         'console',
--       },
--       size = 10,
--       position = 'bottom',
--     },
--   icons = { expanded = "▾", collapsed = "▸" },
--   mappings = {
--     expand = { "<CR>", "<2-LeftMouse>" },
--     open = "o",
--     remove = "d",
--     edit = "e",
--     repl = "r",
--     toggle = "t",
--   },
--   floating = {
--     max_height = nil,
--     max_width = nil,
--     border = "rounded",
--     mappings = {
--       close = { "q", "<Esc>" },
--     },
--   },
--   windows = { indent = 1 },
--   }

vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DiagnosticSignError', linehl = '', numhl = '' })

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
