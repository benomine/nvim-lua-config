M = {}

local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local status_theme_ok, theme = pcall(require, "lualine.themes.nightfox")
if not status_theme_ok then
  return
end

local function contains(t, value)
  for _, v in pairs(t) do
    if v == value then
      return true
    end
  end
  return false
end

local sl_hl = vim.api.nvim_get_hl_by_name("StatusLine", true)

vim.api.nvim_set_hl(0, "SLGitIcon", { fg = "#E8AB53", bg = "#32363e" })
vim.api.nvim_set_hl(0, "SLTermIcon", { fg = "#b668cd", bg = "#32363e" })
vim.api.nvim_set_hl(0, "SLBranchName", { fg = "#abb2bf", bg = "#32363e" })
vim.api.nvim_set_hl(0, "SLProgress", { fg = "#b668cd", bg = "#32363e" })
vim.api.nvim_set_hl(0, "SLLocation", { fg = "#519fdf", bg = "#32363e" })
vim.api.nvim_set_hl(0, "SLFT", { fg = "#46a6b2", bg = "#32363e" })
vim.api.nvim_set_hl(0, "SLIndent", { fg = "#c18a56", bg = "#32363e" })
vim.api.nvim_set_hl(0, "SLLSP", { fg = "#6b727f", bg = sl_hl.background })
vim.api.nvim_set_hl(0, "SLSep", { fg = "#32363e", bg = "NONE" })
vim.api.nvim_set_hl(0, "SLFG", { fg = "#abb2bf", bg = sl_hl.background })
vim.api.nvim_set_hl(0, "SLSeparator", { fg = "#6b727f", bg = sl_hl.background, italic = true })
vim.api.nvim_set_hl(0, "SLError", { fg = "#bf616a", bg = sl_hl.background })
vim.api.nvim_set_hl(0, "SLWarning", { fg = "#D7BA7D", bg = sl_hl.background })
vim.api.nvim_set_hl(0, "SLCopilot", { fg = "#6CC644", bg = "#32363e" })

local hl_str = function(str, hl)
  return "%#" .. hl .. "#" .. str .. "%*"
end

local mode_color = {
  n = "#519fdf",
  i = "#c18a56",
  v = "#b668cd",
  ["^V"]  = "#b668cd",
  V = "#b668cd",
  -- c = '#B5CEA8',
  -- c = '#D7BA7D',
  c = "#46a6b2",
  no = "#D16D9E",
  s = "#88b369",
  S = "#c18a56",
  ["^S"] = "#c18a56",
  ic = "#d05c65",
  R = "#D16D9E",
  Rv = "#d05c65",
  cv = "#519fdf",
  ce = "#519fdf",
  r = "#d05c65",
  rm = "#46a6b2",
  ["r?"] = "#46a6b2",
  ["!"] = "#46a6b2",
  t = "#d05c65",
}

local left_pad = {
  function()
    return " "
  end,
  padding = 0,
  color = function()
    return { fg = "#32363e", bg = "none" }
  end,
}

local right_pad = {
  function()
    return " "
  end,
  padding = 0,
  color = function()
    return { fg = "#32363e", bg = "none" }
  end,
}

-- local left_pad_alt = {
--   function()
--     return " "
--   end,
--   padding = 0,
--   color = function()
--     return { bg = "#32363e" }
--   end,
-- }
--
-- local right_pad_alt = {
--   function()
--     return " "
--   end,
--   padding = 0,
--   color = function()
--     return { bg = "#32363e" }
--   end,
-- }

local mode = {
  function()
    return " "
  end,
  color = function()
    return { fg = mode_color[vim.fn.mode()], bg = "#32363e" }
  end,
  padding = 0,
}

local hide_in_width_60 = function()
  return vim.o.columns > 60
end

local hide_in_width = function()
  return vim.o.columns > 80
end

local hide_in_width_100 = function()
  return vim.o.columns > 100
end

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = {
    error = " " ,
    warn = " ",
  },
  diagnostics_color = {
    error = { fg = "#d05c65", bg = "#32363e" },
    warn = { fg = "#c18a56", bg = "#32363e" },
  },
  colored = true,
  update_in_insert = false,
  always_visible = true,
  padding = 0,
}

local diff = {
  "diff",
  colored = true,
  symbols = { added = ' ', modified = ' ', removed = ' ' }, -- changes diff symbols
  cond = hide_in_width_60,
  separator = "%#SLSeparator#" .. "│ " .. "%*",
  color = function()
    return { bg = "#32363e" }
  end,
}

local filetype = {
  "filetype",
  fmt = function(str)
    local ui_filetypes = {
      "help",
      "packer",
      "neogitstatus",
      "NvimTree",
      "Trouble",
      "lir",
      "Outline",
      "spectre_panel",
      "toggleterm",
      "DressingSelect",
      "",
      "nil",
    }

    local return_val = function(string)
      return hl_str(" ", "SLSep") .. hl_str(string, "SLFT") .. hl_str("", "SLSep")
    end

    if str == "TelescopePrompt" then
      return return_val('')
    end

    local function get_term_num()
      local t_status_ok, toggle_num = pcall(vim.api.nvim_buf_get_var, 0, "toggle_number")
      if not t_status_ok then
        return ""
      end
      return toggle_num
    end

    if str == "toggleterm" then
      local term = "%#SLTermIcon#" .. " " .. "%*" .. "%#SLFT#" .. get_term_num() .. "%*"
      return return_val(term)
    end

    if contains(ui_filetypes, str) then
      return ""
    else
      return return_val(str)
    end
  end,
  icons_enabled = false,
  padding = 0,
}

local branch = {
  "branch",
  icons_enabled = true,
  icon = "%#SLGitIcon#" .. " " .. "%*" .. "%#SLBranchName#",
  colored = false,
  padding = 0,
  fmt = function(str)
    if str == "" or str == nil then
      return "!=vcs"
    end

    return str
  end,
}

local progress = {
  "progress",
  fmt = function(_)
    return hl_str("", "SLSep") .. hl_str("%P/%L", "SLProgress") .. hl_str(" ", "SLSep")
  end,
  padding = 0,
}

local current_signature = {
  function()
    local buf_ft = vim.bo.filetype

    if buf_ft == "toggleterm" or buf_ft == "TelescopePrompt" then
      return ""
    end
    if not pcall(require, "lsp_signature") then
      return ""
    end
    local sig = require("lsp_signature").status_line(30)
    local hint = sig.hint

    if not require("user.functions").isempty(hint) then
      return "%#SLSeparator# " .. hint .. "%*"
    end

    return ""
  end,
  cond = hide_in_width_100,
  padding = 0,
}

local spaces = {
  function()
    local buf_ft = vim.bo.filetype

    local ui_filetypes = {
      "help",
      "packer",
      "neogitstatus",
      "NvimTree",
      "Trouble",
      "lir",
      "Outline",
      "spectre_panel",
      "DressingSelect",
      "",
    }
    local space = ""

    if contains(ui_filetypes, buf_ft) then
      space = " "
    end

    local shiftwidth = vim.api.nvim_buf_get_option(0, "shiftwidth")

    if shiftwidth == nil then
      return ""
    end

    return hl_str(" ", "SLSep") .. hl_str(" " .. shiftwidth .. space, "SLIndent") .. hl_str("", "SLSep")
  end,
  padding = 0,
}

local language_server = {
  function()
    local buf_ft = vim.bo.filetype
    local ui_filetypes = {
      "help",
      "packer",
      "neogitstatus",
      "NvimTree",
      "Trouble",
      "lir",
      "Outline",
      "spectre_panel",
      "toggleterm",
      "DressingSelect",
      "TelescopePrompt",
      "lspinfo",
      "lsp-installer",
      "",
    }

    if contains(ui_filetypes, buf_ft) then
      if M.language_servers == nil then
        return ""
      else
        return M.language_servers
      end
    end

    local clients = vim.lsp.buf_get_clients()
    local client_names = {}
    local copilot_active = false

    -- add client
    for _, client in pairs(clients) do
      if client.name ~= "copilot" and client.name ~= "null-ls" then
        table.insert(client_names, client.name)
      end
      if client.name == "copilot" then
        copilot_active = true
      end
    end

    -- add formatter
    local s = require "null-ls.sources"
    local available_sources = s.get_available(buf_ft)
    local registered = {}
    for _, source in ipairs(available_sources) do
      for method in pairs(source.methods) do
        registered[method] = registered[method] or {}
        table.insert(registered[method], source.name)
      end
    end

    local formatter = registered["NULL_LS_FORMATTING"]
    local linter = registered["NULL_LS_DIAGNOSTICS"]
    if formatter ~= nil then
      vim.list_extend(client_names, formatter)
    end
    if linter ~= nil then
      vim.list_extend(client_names, linter)
    end

    -- join client names with commas
    local client_names_str = table.concat(client_names, ", ")

    -- check client_names_str if empty
    local language_servers = ""
    local client_names_str_len = #client_names_str
    if client_names_str_len ~= 0 then
      language_servers = hl_str(" ", "SLSep") .. hl_str(client_names_str, "SLCopilot") .. hl_str("", "SLSep")
    end
    if copilot_active then
      language_servers = language_servers .. "%#SLCopilot#" .. " " .. "%*"
    end

    if client_names_str_len == 0 and not copilot_active then
      return ""
    else
      M.language_servers = language_servers
      return language_servers:gsub(", anonymous source", "")
    end
  end,
  padding = 0,
  cond = hide_in_width,
}

local location = {
  "location",
  fmt = function(str)
    return hl_str(" ", "SLSep") .. hl_str(str, "SLLocation") .. hl_str(" ", "SLSep")
  end,
  padding = 0,
}

lualine.setup {
  options = {
    globalstatus = true,
    icons_enabled = true,
    theme = 'tokyonight',
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "alpha", "dashboard" },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { left_pad, mode, branch, diff, right_pad },
    lualine_b = { left_pad, diagnostics, right_pad },
    lualine_c = { left_pad, current_signature, right_pad },
    lualine_x = { language_server, spaces, filetype },
    lualine_y = {},
    lualine_z = { location, progress },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
}
