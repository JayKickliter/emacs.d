(require-package 'haskell-mode)

(require-package 'intero)

(add-hook 'haskell-mode-hook
          (lambda ()
            (intero-mode)
            (local-set-key (kbd "C-c C-f") 'haskell-mode-stylish-buffer)))


(provide 'init-haskell)
