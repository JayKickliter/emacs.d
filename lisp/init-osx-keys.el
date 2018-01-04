(when *is-a-mac*
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier 'alt)
  (setq default-input-method "MacOSX")
  ;; Make mouse wheel / trackpad scrolling less jerky
  (setq mouse-wheel-scroll-amount '(1 ((shift) . 5)
                                      ((control))))
  (dolist (multiple '("" "double-" "triple-"))
    (dolist (direction '("right" "left"))
      (global-set-key (read-kbd-macro (concat "<" multiple "wheel-" direction ">")) 'ignore)))
  (global-set-key (kbd "M-`") 'ns-next-frame)
  (global-set-key (kbd "M-h") 'ns-do-hide-emacs)
  (global-set-key (kbd "M-˙") 'ns-do-hide-others)
  (global-set-key (kbd "A-<left>") 'left-word)
  (global-set-key (kbd "A-<right>") 'right-word)
  (global-set-key (kbd "A-<up>") 'beginning-of-defun)
  (global-set-key (kbd "A-<down>") 'end-of-defun)
  (global-set-key (kbd "M-<left>") 'move-beginning-of-line)
  (global-set-key (kbd "M-<right>") 'move-end-of-line)
  (after-load 'nxml-mode (define-key nxml-mode-map (kbd "M-h") nil))
  (global-set-key (kbd "M-ˍ") 'ns-do-hide-others) ;; what describe-key reports for cmd-option-h
  )

(provide 'init-osx-keys)
