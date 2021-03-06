(add-hook 'hs-minor-mode-hook
          (lambda ()
            (global-set-key (kbd "C-c h a") 'hs-hide-all)
            (global-set-key (kbd "C-c s a") 'hs-show-all)
            (global-set-key (kbd "C-c s s") 'hs-show-block)
            (global-set-key (kbd "C-c h h") 'hs-hide-block)
            (global-set-key (kbd "C-c s l") 'hs-show-level)
            (global-set-key (kbd "C-c h l") 'hs-hide-level)
            (set hs-isearch-open t)
            (setq hs-hide-comments-when-hiding-all nil)))

(defadvice goto-line (after expand-after-goto-line activate compile)
  "Run hideshow-expand affected block when using `goto-line' in a collapsed buffer."
  (save-excursion (hs-show-block)))

(add-hook 'prog-mode-hook 'hs-minor-mode)

(provide 'init-hideshow)
