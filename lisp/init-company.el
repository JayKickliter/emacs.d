(require-package 'company)

(add-hook 'after-init-hook 'global-company-mode)
(setq company-tooltip-align-annotations t)
(setq company-idle-delay 0.2)

(provide 'init-company)
