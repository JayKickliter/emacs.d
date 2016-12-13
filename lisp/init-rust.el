(require-package 'rust-mode)
(require-package 'racer)
(require-package 'company-racer)
(require-package 'flycheck-rust)

(defun my-rust-mode-hook ()
  (racer-mode)
  (flycheck-mode)
  (hs-minor-mode))

(add-hook 'rust-mode-hook 'my-rust-mode-hook)
(add-hook 'racer-mode-hook 'eldoc-mode)
(with-eval-after-load 'company
  (add-to-list 'company-backends 'company-racer))
(add-hook 'flycheck-mode-hook 'flycheck-rust-setup)

(provide 'init-rust)
