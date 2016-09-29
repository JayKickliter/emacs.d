(add-hook 'hs-minor-mode-hook
          (lambda ()
            (global-set-key (kbd "C-c h a") 'hs-hide-all)
            (global-set-key (kbd "C-c s a") 'hs-show-all)
            (global-set-key (kbd "C-c s b") 'hs-show-block)
            (global-set-key (kbd "C-c h b") 'hs-hide-block)))

(provide 'init-hideshow)
