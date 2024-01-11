return {
	"alepez/vim-gtest",
	event = { "BufEnter *.cpp", "BufEnter *.h" },
	config = function()
		local keyset = vim.keymap.set

		keyset("n", "<leader>gt", ":GTestRunUnderCursor <cr>")
	end,
}
