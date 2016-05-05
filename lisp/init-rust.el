(require-package 'rust-mode)
(require-package 'company-racer)
(require-package 'flycheck)

(with-eval-after-load 'company
  (add-to-list 'company-backends 'company-racer))

(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)

(defun my-rust-mode-hook ()
  (eldoc-mode)
  (flycheck-mode)
  (local-set-key (kbd "M-t") #'racer-find-definition))

(add-hook 'rust-mode-hook 'my-rust-mode-hook)

(with-eval-after-load "racer"
  '(progn
     (define-key racer-mode-map (kbd "M-t") #'racer-find-definition)))

(provide 'init-rust)
