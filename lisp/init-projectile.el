(require-package 'projectile)
(require-package 'helm-projectile)
(require-package 'ripgrep)
(require-package 'projectile-ripgrep)

(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)
(setq projectile-switch-project-action 'neotree-projectile-action)

(provide 'init-projectile)
