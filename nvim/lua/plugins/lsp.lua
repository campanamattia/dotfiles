return {
	-- lazydev for Lua config editing
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},

	-- Mason
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},

	-- Bridge
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"clangd",
					"rust_analyzer",
					"pyright",
					"ts_ls",
					"lua_ls",
				},
			})
		end,
	},

	-- LSP config with LspAttach pattern
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"saghen/blink.cmp",
			"folke/lazydev.nvim",
		},
		config = function()
			-- enable servers
			vim.lsp.enable("clangd")
			vim.lsp.enable("rust_analyzer")
			vim.lsp.enable("pyright")
			vim.lsp.enable("ts_ls")
			vim.lsp.enable("lua_ls")

			-- keymaps only when LSP attaches
			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP keymaps",
				callback = function(args)
					local buffer = args.buf
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if not client then return end

					local map = function(mode, lhs, rhs, desc)
						vim.keymap.set(mode, lhs, rhs,
							{ buffer = buffer, silent = true, desc = desc })
					end
					local mapdel = function(mode, lhs)
						pcall(vim.keymap.del, mode, lhs, { buffer = buffer })
					end

					mapdel("n", "grn")
					mapdel("n", "gra")
					mapdel("n", "grr")
					mapdel("n", "gri")
					mapdel("n", "grt")

					map("n", "gd", vim.lsp.buf.definition, "Go to definition")
					map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
					map("n", "gI", vim.lsp.buf.implementation, "Go to implementation")
					map("n", "gu", vim.lsp.buf.references, "Show references")
					map("n", "gs", vim.lsp.buf.document_symbol, "Show document symbols")
					map("n", "K", vim.lsp.buf.hover, "Hover docs")
					map("n", "ga", vim.lsp.buf.code_action, "Code actions")
					map("n", "gr", vim.lsp.buf.rename, "Rename symbol")

					client.server_capabilities.semanticTokensProvider = nil

					map("i", "<C-s>", vim.lsp.buf.signature_help, "Signature help")

					-- auto format on save if server supports it
					if client:supports_method("textDocument/formatting") then
						map("n", "gf", vim.lsp.buf.format, "Format file")
						vim.api.nvim_create_autocmd("BufWritePre", {
							buffer = buffer,
							callback = function()
								vim.lsp.buf.format({ bufnr = buffer, id = client.id })
							end,
						})
					end
				end,
			})
		end,
	},
}
