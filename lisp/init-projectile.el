(require-package 'projectile)
(require-package 'helm-projectile)

(projectile-mode +1)
(setq projectile-completion-system 'helm)
(helm-projectile-on)
(setq projectile-switch-project-action 'neotree-projectile-action)
(setq projectile-buffers-filter-function 'projectile-buffers-with-file)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "<f13>") 'projectile-switch-to-buffer)

(provide 'init-projectile)
