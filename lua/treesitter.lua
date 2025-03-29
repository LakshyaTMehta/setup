-- treesitter config
-- require("nvim-treesitter.install".compilers)
require("lazy").setup({{
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "help", "javascript", "html" },
          highlight = { enable = true },
          indent = { enable = true },
        })
    end
}})
