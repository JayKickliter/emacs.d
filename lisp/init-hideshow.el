(add-hook 'hs-minor-mode-hook
          (lambda ()
            (global-set-key (kbd "C-c h a") 'hs-hide-all)
            (global-set-key (kbd "C-c s a") 'hs-show-all)
            (global-set-key (kbd "C-c s s") 'hs-show-block)
            (global-set-key (kbd "C-c h h") 'hs-hide-block)))

(provide 'init-hideshow)
