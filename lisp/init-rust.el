(require-package 'rust-mode)
(require-package 'toml-mode)

(add-hook 'rust-mode-hook
          (lambda ()
            (lsp)
            (flycheck-mode)))

(provide 'init-rust)
