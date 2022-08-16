local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end

local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
	[[                                                        ]],
	[[   ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗   ]],
	[[   ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║   ]],
	[[   ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║   ]],
	[[   ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║   ]],
	[[   ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║   ]],
	[[   ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝   ]],
	[[                                                        ]],
}

dashboard.section.buttons.val = {
	dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
	dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("p", "  Find project", ":lua require('telescope').extensions.projects.projects()<CR>"),
	dashboard.button("r", "  Recent files", ":Telescope oldfiles <CR>"),
	dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
	dashboard.button("c", "  Config", ":e " .. vim.fn.stdpath("config") .. "/init.lua <CR>"),
	dashboard.button("u", "  Update", ":PackerSync<CR>"),
	dashboard.button("q", "  Quit", ":qa<CR>"),
}

local function footer()
	local v = vim.version()
	local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
	local platform = vim.fn.has("win32") == 1 and "" or ""
	return string.format(" v%d.%d.%d %s  %s", v.major, v.minor, v.patch, platform, datetime)
end

dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

table.insert(dashboard.config.layout, { type = "padding", val = 1 })
table.insert(dashboard.config.layout, {
	type = "text",
	val = require("alpha.fortune")(),
	opts = {
		position = "center",
		hl = "AlphaQuote",
	},
})

dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)
