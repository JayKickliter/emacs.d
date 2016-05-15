(require-package 'helm)
(global-set-key (kbd "M-x") 'undefined)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-b") 'undefined)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
(setq helm-M-x-fuzzy-match t)
(add-hook 'term-mode-hook
          (lambda ()
            (define-key term-raw-map (kbd "M-x") #'helm-M-x)))
(helm-mode 1)
(provide 'init-helm)

