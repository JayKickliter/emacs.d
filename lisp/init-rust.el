(use-package lsp-mode
  :ensure t
  :hook (rust-mode . lsp)
  :commands lsp
  :config ((setq lsp-idle-delay .500)))

(use-package lsp-ui
  :ensure t)

(use-package rust-mode
  :ensure t)

(provide 'init-rust)
