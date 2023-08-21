(use-package lsp-mode
  :ensure t
  :hook (rust-mode . lsp)
  :commands lsp)

(use-package lsp-ui
  :ensure t)

(use-package rust-mode
  :ensure t
  :bind (("C-c C-e" . lsp-rust-analyzer-expand-macro)
         ("M-." . xref-find-definitions)
         ("M-," . xref-pop-marker-stack))
  :config (set-fill-column 84))

(lsp-register-client
 (make-lsp-client :new-connection (lsp-tramp-connection "rust-analyzer")
                  :major-modes '(rust-mode)
                  :remote? t
                  :server-id 'rust-analyzer-remote))

(provide 'init-rust)
