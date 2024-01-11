return {
	"cdelledonne/vim-cmake",
	event = { "BufEnter *.cpp", "BufEnter *.h", "BufEnter *.txt" },
	config = function()
		local keyset = vim.keymap.set

		keyset("n", "<leader>Cg", ":CMakeGenerate <cr>")
		keyset("n", "<leader>Cb", ":CMakeBuild <cr>")
		keyset("n", "<leader>Cr", function()
			-- Solicitar al usuario el path del ejecutable de CMake
			local cmake_executable = vim.fn.input("Ingrese el nombre del ejecutable: ")

			-- Verificar si el usuario ingresó un valor antes de ejecutar CMakeRun
			if cmake_executable and #cmake_executable > 0 then
				-- Ejecutar CMakeRun con el path proporcionado
				vim.cmd(string.format(":CMakeRun %s", vim.fn.shellescape(cmake_executable):gsub("'", "")))
			else
				vim.cmd("echo 'No se proporcionó un ejecutable valido'")
			end
		end)
	end,
}
