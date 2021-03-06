(require-package 'neotree)

(global-set-key (kbd "C-M-d") 'neotree-toggle)

(setq neo-vc-integration '(face))

(add-hook 'golden-ratio-mode-hook
          (lambda () (add-to-list 'golden-ratio-exclude-buffer-names " *NeoTree*")))

(provide 'init-neotree)
