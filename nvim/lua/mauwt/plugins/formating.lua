return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				sh = { "beautysh", "shfmt" },
				--	cpp = { "clang-format" },
				cmake = { "cmakelang" },
				--	java = { "google-java-format" },
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				lua = { "stylua" },
				python = { "black", "isort" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				css = { "prettier" },
			},
			format_on_save = {
				lsp_ = true,
				async = false,
				timeout_ms = 500,
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			})
		end)
	end,
}
