local nightfox_status_ok, nightfox = pcall(require, "nightfox")
if not nightfox_status_ok then
    return
end

nightfox.setup({
  options = {
    styles = {
      comments = 'italic',
      keywords = 'bold',
      types = 'italic,bold',
    }
  }
})

