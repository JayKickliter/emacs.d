(require-package 'helm)
(global-set-key (kbd "M-x") 'undefined)
(global-set-key (kbd "M-x") 'helm-M-x)
(setq helm-M-x-fuzzy-match t)
(add-hook 'term-mode-hook
          (lambda ()
            (define-key term-raw-map (kbd "M-x") #'helm-M-x)))
(helm-mode 1)
(provide 'init-helm)

