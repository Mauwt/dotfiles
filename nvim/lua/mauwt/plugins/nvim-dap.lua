return {
	"mfussenegger/nvim-dap",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local keymap = vim.keymap

		keymap.set("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>")
		keymap.set("n", "<leader>dr", "<cmd> DapContinue <CR>")
	end,
}
