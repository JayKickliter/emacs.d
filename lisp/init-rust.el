(use-package lsp-mode
  :ensure t
  :hook (rust-mode . lsp)
  :commands lsp)

(use-package lsp-ui
  :ensure t)

(use-package rust-mode
  :ensure t
  :bind (("C-c C-e" . lsp-rust-analyzer-expand-macro)
         ("M-." . lsp-find-definition))
  :config (set-fill-column 84))

(provide 'init-rust)
