local status, tele = pcall(require, 'telescope')

if not status then
  return
end

tele.setup {
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },
    extensions = {
      --'fzf',
      'gh',
      'packer',
      'projects'
    }
  }
}
