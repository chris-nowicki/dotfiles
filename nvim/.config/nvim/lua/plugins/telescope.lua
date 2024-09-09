return {
  "nvim-telescope/telescope.nvim",
  opts = {
    defaults = {
      file_ignore_patterns = { "node_modules", ".git" },
    },
    pickers = {
      find_files = {
        hidden = true,
        respect_gitignore = true,
      },
    },
  },
}
