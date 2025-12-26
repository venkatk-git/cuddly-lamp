return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local confs = require("nvim-treesitter.config")
    confs.setup({
      ensure_installed = { "lua", "haskell" },
      highlight = { enable = true },
      indent = { enable = true }
    })
  end
}
