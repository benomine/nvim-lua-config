local status_project, project = pcall(require, "project_nvim")
if not status_project then
	return
end

project.setup({
	detection_methods = { "pattern" },
	patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "sln", "csproj" }
})
