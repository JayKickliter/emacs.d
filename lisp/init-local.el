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
  (global-set-key (kbd "A-<backspace>") 'backward-kill-word)
  (global-set-key (kbd "M-<left>") 'move-beginning-of-line)
  (global-set-key (kbd "M-<right>") 'move-end-of-line)
  (global-set-key (kbd "M-ˍ") 'ns-do-hide-others) ;; what describe-key reports for cmd-option-h
  )

(global-set-key (kbd "C-c C-c") 'mc/edit-lines)

;;; Rust
(use-package lsp-mode
  :ensure t
  :hook (rust-mode . lsp)
  :commands lsp)

(use-package lsp-ui
  :ensure t)

(with-eval-after-load "lsp-rust"
  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-tramp-connection "rust-analyzer")
    :remote? t
    :major-modes '(rust-mode rustic-mode)
    :initialization-options 'lsp-rust-analyzer--make-init-options
    :notification-handlers (ht<-alist lsp-rust-notification-handlers)
    :action-handlers (ht ("rust-analyzer.runSingle" #'lsp-rust--analyzer-run-single))
    :library-folders-fn (lambda (_workspace) lsp-rust-library-directories)
    :after-open-fn (lambda ()
                     (when lsp-rust-analyzer-server-display-inlay-hints
                       (lsp-rust-analyzer-inlay-hints-mode)))
    :ignore-messages nil
    :server-id 'rust-analyzer-remote)))

(use-package neotree
  :ensure t
  :custom
  (neo-vc-integration '(face))
  )

(use-package golden-ratio
  :ensure t
  :hook (golden-ratio-mode (lambda () (add-to-list 'golden-ratio-exclude-buffer-names " *NeoTree*")))
  )

(provide 'init-local)
