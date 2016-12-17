(add-hook 'hs-minor-mode-hook
          (lambda ()
            (global-set-key (kbd "C-c h a") 'hs-hide-all)
            (global-set-key (kbd "C-c s a") 'hs-show-all)
            (global-set-key (kbd "C-c s s") 'hs-show-block)
            (global-set-key (kbd "C-c h h") 'hs-hide-block)))

;; Show code when incremental searching
(set hs-isearch-open t)

(defadvice goto-line (after expand-after-goto-line activate compile)
  "Run hideshow-expand affected block when using `goto-line' in a collapsed buffer."
  (save-excursion
    (hs-show-block)))

(provide 'init-hideshow)
