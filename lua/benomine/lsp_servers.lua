local mason_status, mason = pcall(require, "mason")
if not mason_status then
	return
end

local lsp_servers = {
	"omnisharp",
	"gopls",
	"fsautocomplete",
	"vimls",
	"yamlls",
	"dockerls",
	"tsserver",
	"volar",
	"cssls",
	"jsonls",
	"pyright",
	"html",
	"sumneko_lua",
	"ltex",
	"svelte",
	"groovyls",
	"rust_analyzer",
	"taplo",
	"clangd",
	"jdtls",
	"sqls",
}

mason.setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

local mason_config_status, mason_config = pcall(require, "mason-lspconfig")
if not mason_config_status then
	return
end

mason_config.setup({
	ensure_installed = lsp_servers,
	automatic_installation = true,
})

mason_config.setup_handlers({
	function(server_name)
		require('lspconfig')[server_name].setup {}
	end,
})

local status, lspconfig = pcall(require, "lspconfig")
if not status then
	return
end

local saga_status, lspsaga = pcall(require, "lspsaga")
if not saga_status then
	return
end

lspsaga.init_lsp_saga()

local signature_status, signature = pcall(require, "lsp_signature")
if not signature_status then
	return
end

signature.setup({
	bind = true,
	handler_opts = {
		border = "rounded",
	},
})

require("luasnip.loaders.from_vscode").lazy_load()

local navic_status, navic = pcall(require, "nvim-mavic")
if not navic_status then
	return
end

navic.setup({
	icons = {
		File = " ",
		Module = " ",
		Namespace = " ",
		Package = " ",
		Class = " ",
		Method = " ",
		Property = " ",
		Field = " ",
		Constructor = " ",
		Enum = "練",
		Interface = "練",
		Function = " ",
		Variable = " ",
		Constant = " ",
		String = " ",
		Number = " ",
		Boolean = "◩ ",
		Array = " ",
		Object = " ",
		Key = " ",
		Null = "ﳠ ",
		EnumMember = " ",
		Struct = " ",
		Event = " ",
		Operator = " ",
		TypeParameter = " ",
	},
	highlight = false,
	separator = " > ",
	depth_limit = 0,
	depth_limit_indicator = "..",
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	navic.attach(client, bufnr)

	signature.on_attach(client, bufnr)

	local opts = { noremap = true, silent = true }

	vim.diagnostic.config({ virtual_text = false })

	buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "<space>ed", '<cmd>lua vim.diagnostic.open_float({"line"})<CR>', opts)
	buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
	buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

for _, server in ipairs(lsp_servers) do
	if server == "ltex" then
		lspconfig[server].setup({
			settings = {
				ltex = {
					enabled = { "latex", "tex", "bib", "md" },
					checkFrequency = "save",
					language = "fr-CA",
				},
			},
			on_attach = on_attach,
			capabilities = capabilities,
		})
	elseif server == "jsonls" then
		lspconfig[server].setup({
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				json = {
					schemas = require("schemastore").json.schemas(),
				},
			},
		})
	elseif server == "sumneko_lua" then
		lspconfig[server].setup({
			on_attach = on_attach,
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
					},
					diagnostics = {
						globals = { "vim" },
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
		})
	elseif server == "rust_analyzer" then
		local keymap = vim.keymap.set
		local key_opts = { silent = true }

		keymap("n", "<leader>rh", "<cmd>RustSetInlayHints<Cr>", key_opts)
		keymap("n", "<leader>rhd", "<cmd>RustDisableInlayHints<Cr>", key_opts)
		keymap("n", "<leader>th", "<cmd>RustToggleInlayHints<Cr>", key_opts)
		keymap("n", "<leader>rr", "<cmd>RustRunnables<Cr>", key_opts)
		keymap("n", "<leader>rem", "<cmd>RustExpandMacro<Cr>", key_opts)
		keymap("n", "<leader>roc", "<cmd>RustOpenCargo<Cr>", key_opts)
		keymap("n", "<leader>rpm", "<cmd>RustParentModule<Cr>", key_opts)
		keymap("n", "<leader>rjl", "<cmd>RustJoinLines<Cr>", key_opts)
		keymap("n", "<leader>rha", "<cmd>RustHoverActions<Cr>", key_opts)
		keymap("n", "<leader>rhr", "<cmd>RustHoverRange<Cr>", key_opts)
		keymap("n", "<leader>rmd", "<cmd>RustMoveItemDown<Cr>", key_opts)
		keymap("n", "<leader>rmu", "<cmd>RustMoveItemUp<Cr>", key_opts)
		keymap("n", "<leader>rsb", "<cmd>RustStartStandaloneServerForBuffer<Cr>", key_opts)
		keymap("n", "<leader>rd", "<cmd>RustDebuggables<Cr>", key_opts)
		keymap("n", "<leader>rv", "<cmd>RustViewCrateGraph<Cr>", key_opts)
		keymap("n", "<leader>rw", "<cmd>RustReloadWorkspace<Cr>", key_opts)
		keymap("n", "<leader>rss", "<cmd>RustSSR<Cr>", key_opts)
		keymap("n", "<leader>rxd", "<cmd>RustOpenExternalDocs<Cr>", key_opts)

		require("rust-tools").setup({
			tools = {
				on_initialized = function()
					vim.cmd([[
            autocmd BufEnter,CursorHold,InsertLeave,BufWritePost *.rs silent! lua vim.lsp.codelens.refresh()
          ]])
				end,
			},
			server = {
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					["rust-analyzer"] = {
						completion = {
							postfix = {
								enable = false,
							},
						},
						lens = {
							enable = true,
						},
						checkOnSave = {
							command = "clippy",
						},
					},
				},
			},
		})
	else
		lspconfig[server].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})
	end
end
