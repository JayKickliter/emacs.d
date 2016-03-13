(add-hook 'hs-minor-mode-hook
          (lambda ()
            (global-set-key (kbd "C-M-0") 'hs-hide-all)
            (global-set-key (kbd "C-M-1") 'hs-show-all)
            (global-set-key (kbd "C-M-9") 'hs-show-block)))

(provide 'init-hideshow)
