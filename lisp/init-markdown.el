(require-package 'markdown-mode)

(after-load 'whitespace-cleanup-mode (push 'markdown-mode whitespace-cleanup-mode-ignore-modes))

;; Wrap lines in markdown mode
(add-hook 'markdown-mode-hook
          (lambda ()
            (visual-line-mode t)))

(provide 'init-markdown)
