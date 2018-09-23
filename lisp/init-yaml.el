(require-package 'yaml-mode)
(require-package 'flycheck-yamllint)

(add-auto-mode 'yaml-mode "\\.yml\\.erb\\'")

(eval-after-load 'flycheck '(add-hook 'flycheck-mode-hook 'flycheck-yamllint-setup))

(provide 'init-yaml)
