vim.opt.completeopt = { "menu", "menuone", "noselect" }

vim.opt.shortmess:append("c")

vim.api.nvim_set_keymap(
	"i",
	"<C-x><C-m>",
	[[<c-r>=luaeval('require('complextras').complete_matching_line()')<CR>]],
	{ noremap = true }
)

vim.api.nvim_set_keymap(
	"i",
	"<C-x><C-d>",
	[[<c-r>=luaeval('require('complextras').complete_line_from_cwd()')<CR>]],
	{ noremap = true }
)

local status, lspkind = pcall(require, "lspkind")

if not status then
	return
end

lspkind.init({
	mode = "symbol_text",
	symbol_map = {
		Text = "",
		Method = "ƒ",
		Function = "ﬦ",
		Constructor = "",
		Variable = "",
		Class = "",
		Interface = "",
		Module = "",
		Property = "",
		Unit = "",
		Value = "",
		Enum = "",
		Keyword = "",
		Snippet = "﬌",
		Color = "",
		File = "",
		Folder = "",
		EnumMember = "",
		Constant = "",
		Struct = "",
		Event = "",
		Operator = "",
		TypeParameter = "",
	},
})

local status_cmp, cmp = pcall(require, "cmp")

if not status_cmp then
	return
end

cmp.setup({
	mapping = {
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-e>"] = cmp.mapping.close(),
		["<c-y>"] = cmp.mapping(
			cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Insert,
				select = true,
			}),
			{ "i", "c" }
		),
		["<CR>"] = cmp.mapping({
			i = cmp.mapping.confirm({ select = true }),
		}),
		["<Right>"] = cmp.mapping({
			i = cmp.mapping.confirm({ select = true }),
		}),
		["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
		["<c-space>"] = cmp.mapping({
			i = cmp.mapping.complete(),
			c = function()
				if cmp.visible() then
					if not cmp.confirm({ select = true }) then
						return
					end
				else
					cmp.complete()
				end
			end,
		}),

		["<c-q>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
	},

	sources = {
		{ name = "gh_issues" },
		{ name = "nvim_lua" },
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "luasnip" },
		{ name = "buffer", keyword_length = 5 },
		{ name = "file", keyword_length = 5 },
		{ name = "file_line", keyword_length = 5 },
		{ name = "spell" },
    { name = "plugins" },
	},

	sorting = {
		comparators = {
			cmp.config.compare.offset,
			cmp.config.compare.exact,
			cmp.config.compare.score,

			function(entry1, entry2)
				local _, entry1_under = entry1.completion_item.label:find("^_+")
				local _, entry2_under = entry2.completion_item.label:find("^_+")
				entry1_under = entry1_under or 0
				entry2_under = entry2_under or 0
				if entry1_under > entry2_under then
					return false
				elseif entry1_under < entry2_under then
					return true
				end
			end,

			cmp.config.compare.kind,
			cmp.config.compare.sort_text,
			cmp.config.compare.length,
			cmp.config.compare.order,
		},
	},
	window = {
		documentation = cmp.config.window.bordered(),
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},

	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol",
			menu = {
				nvim_lsp = "ﲳ",
				nvim_lua = "",
				luasnip = "פֿ",
				treesitter = "",
				path = "ﱮ",
				buffer = "﬘",
				zsh = "",
				vsnip = "",
				spell = "暈",
			},
		}),
	},

	experimental = {
		native_menu = false,
		ghost_text = false,
	},
})

cmp.setup.cmdline("/", {
	completion = {
		autocomplete = false,
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp_document_symbol" },
	}, {}),
})

cmp.setup.cmdline(":", {
	completion = {
		autocomplete = false,
	},

	sources = cmp.config.sources({
		{
			name = "path",
		},
	}, {
		{
			name = "cmdline",
			max_item_count = 20,
			keyword_length = 4,
		},
	}),
})
