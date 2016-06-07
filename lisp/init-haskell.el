(require-package 'haskell-mode)

(require-package 'intero)
(add-hook 'haskell-mode-hook 'intero-mode)

(provide 'init-haskell)
