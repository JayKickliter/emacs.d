(require-package 'markdown-mode)

(after-load 'whitespace-cleanup-mode
  (push 'markdown-mode whitespace-cleanup-mode-ignore-modes))

(setq markdown-command "pandoc -f markdown_github -s")

(provide 'init-markdown)
