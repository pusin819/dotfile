local status, nvim_lsp = pcall(require, "lspconfig")
if not status then
	return
end

local protocol = require("vim.lsp.protocol")

local signs = { Error = " ", Warn = " ", Hint = "󰌆", Info = "󰋼" }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local on_attach = function(client, bufnr)
	-- format on save
	if client.server_capabilities.documentFormattingProvider then
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = vim.api.nvim_create_augroup("Format", { clear = true }),
			buffer = bufnr,
		})
	end
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Clangd
nvim_lsp.clangd.setup({
	on_attach = on_attach,
	capabilities = capabilities,

	cmd = {
		"clangd",
		"--enable-config",
		"--query-driver=/usr/bin/*g++*",
		"--query-driver=/usr/bin/arm-none-eabi-g++",
		-- "--compile-commands-dir=./debug",
	},
	filetypes = { "c", "cpp", "h", "hpp", "objc", "objcpp" },
	root_dir = function()
		return vim.loop.cwd()
	end,
	extraArgs = {
		"-I",
		"/usr/include/c++/11/",
	},
})

-- Cmake
nvim_lsp.cmake.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- TypeScript
nvim_lsp.tsserver.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- CSS
nvim_lsp.cssls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- Tailwind
nvim_lsp.tailwindcss.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- HTML
nvim_lsp.html.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- JSON
nvim_lsp.jsonls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- Eslint
nvim_lsp.eslint.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- Python
nvim_lsp.pyright.setup({
	on_attach = on_attach,
	capabilities = capabilities,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        useLibraryCodeForTypes = true,
        extraPaths = {
        "/home/haru/robocon_ws/install/ros2_aruco_interfaces/local/lib/python3.10/dist-packages",
        "/home/haru/robocon_ws/build/ros2_aruco",
        "/home/haru/robocon_ws/install/ros2_aruco/lib/python3.10/site-packages",
        "/home/haru/robocon_ws/install/realsense2_camera_msgs/local/lib/python3.10/dist-packages",
        "/home/haru/robocon_ws/build/py_usb2can_node",
        "/home/haru/robocon_ws/install/py_usb2can_node/lib/python3.10/site-packages",
        "/home/haru/robocon_ws/build/py_dcmdd_node",
        "/home/haru/robocon_ws/install/py_dcmdd_node/lib/python3.10/site-packages",
        "/home/haru/robocon_ws/build/py_usb2can_param",
        "/home/haru/robocon_ws/install/py_usb2can_param/lib/python3.10/site-packages",
        "/home/haru/robocon_ws/build/py_dcmdd_param",
        "/home/haru/robocon_ws/install/py_dcmdd_param/lib/python3.10/site-packages",
        "/home/haru/robocon_ws/install/dcmdd_msg/local/lib/python3.10/dist-packages",
        "/home/haru/robocon_ws/install/communication_msgs/local/lib/python3.10/dist-packages",
        "/home/haru/robocon_ws/install/apriltag_msgs/local/lib/python3.10/dist-packages",
        "/opt/ros/humble/lib/python3.10/site-packages",
        "/opt/ros/humble/local/lib/python3.10/dist-packages"
        },
      },
    },
  },
})

-- Rust
nvim_lsp.rust_analyzer.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- LaTex
nvim_lsp.texlab.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

nvim_lsp.typst_lsp.setup({
	settings = {
		exportPdf = "onType", -- Choose onType, onSave or never.
		-- serverPath = "" -- Normally, there is no need to uncomment it.
	},
})

