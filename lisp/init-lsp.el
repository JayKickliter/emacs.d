(require-package 'lsp-mode)
(require-package 'lsp-ui)
(require-package 'company-lsp)

(add-hook 'lsp-mode-hook 'lsp-ui-mode)

(after-load 'company (add-to-list 'company-backends '(company-lsp)))

(provide 'init-lsp)
