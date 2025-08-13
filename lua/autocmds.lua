require "nvchad.autocmds"

-- Autocommands
local remember_folds = vim.api.nvim_create_augroup("remember_folds", { clear = true })

vim.api.nvim_create_autocmd("BufWinLeave", {
  pattern = "*",
  callback = function() vim.cmd("silent! mkview") end,
  group = remember_folds,
  desc = "Save folds when leaving buffer"
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*",
  callback = function() vim.cmd("silent! loadview") end,
  group = remember_folds,
  desc = "Load folds when entering buffer"
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})

-- show all lsp messges warnings if they are from clang-tidy and errors if they are clang clang
-- Keep original handler
local orig_handler = vim.lsp.handlers["textDocument/publishDiagnostics"]

vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
  if result and result.diagnostics then
    for _, d in ipairs(result.diagnostics) do
      -- Detect clang-tidy diagnostics
      -- clang-tidy messages usually contain "[clang-tidy]" in `source` or `message`
      if (d.source and d.source:match("clang%-tidy"))
         or (d.message and d.message:match("%[clang%-tidy%]")) then
        d.severity = vim.lsp.protocol.DiagnosticSeverity.Warning
      else
        -- All other diagnostics → treat as errors
        d.severity = vim.lsp.protocol.DiagnosticSeverity.Error
      end
    end
  end

  return orig_handler(err, result, ctx, config)
end

-- Make sure underline display is enabled for all severities
vim.diagnostic.config({
  underline = {
    severity = { min = vim.diagnostic.severity.HINT }
  },
})

-- Give them different underline colors
vim.cmd([[
  highlight DiagnosticUnderlineError gui=undercurl guisp=#ff3333
  highlight DiagnosticUnderlineWarn  gui=undercurl guisp=#586b03
]])

vim.api.nvim_create_autocmd({ "CursorHold", "CursorMoved" }, {
  callback = function()
    require("functions").show_cursor_diagnostic()
  end
})
