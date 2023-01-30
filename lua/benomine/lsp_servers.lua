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

	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	navic.attach(client, bufnr)

	signature.on_attach(client, bufnr)

	local opts = { noremap = true, silent = true, buffer = bufnr }

	vim.diagnostic.config({ virtual_text = false })

	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
	vim.keymap.set("n", "<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)
	vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
	vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "<space>ed", vim.diagnostic.open_float, opts)
	vim.keymap.set("n", "<space>q", vim.lsp.diagnostic.set_loclist, opts)
	vim.keymap.set("n", "<space>f", vim.lsp.buf.formatting, opts)
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
