vim.filetype.add({
  extension = {
    log = "log",
  },
  pattern = {
    [".*/templates/.*%.yaml"] = { "helm", { priority = 30 } },
    [".*/.gitlab-ci.yaml"] = { "yaml.gitlab", { priority = 30 } },
    [".*/.*values.yaml"] = "yaml.helm-values",
  },
})
