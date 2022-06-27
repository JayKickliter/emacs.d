(use-package lsp-mode
  :ensure t
  :hook (rust-mode . lsp)
  :commands lsp)

(use-package lsp-ui
  :ensure t)

(use-package rust-mode
  :ensure t
  :bind (("C-c C-e" . lsp-rust-analyzer-expand-macro)
         ("M-." . xref-find-definitions)
         ("M-," . xref-pop-marker-stack))
  :config (set-fill-column 84))

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

(provide 'init-rust)
