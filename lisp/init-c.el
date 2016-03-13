;; C formatting 
(require-package 'clang-format)

;; C mode settings
(setq-default c-basic-offset 4)
(add-hook 'c-mode-common-hook
	  (lambda () (c-toggle-auto-state 1))
	  (lambda () (hs-minor-mode 1)))

(provide 'init-c)
