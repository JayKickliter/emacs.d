(require-package 'helm)
(global-set-key (kbd "M-x")                          'undefined)
(global-set-key (kbd "M-x")                          'helm-M-x)
(setq helm-M-x-fuzzy-match t)
(helm-mode 1)
(provide 'init-helm)

