(require-package 'helm)
(global-set-key (kbd "M-x") 'undefined)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-c C-b") 'helm-buffers-list)
(setq helm-M-x-fuzzy-match t)
(add-hook 'term-mode-hook
          (lambda ()
            (define-key term-raw-map (kbd "M-x") #'helm-M-x)))
(helm-mode 1)

(defun jk/helm-alive-p ()
  (if (boundp 'helm-alive-p)
      (symbol-value 'helm-alive-p)))

(add-hook 'golden-ratio-mode-hook
          (lambda () (add-to-list 'golden-ratio-inhibit-functions 'jk/helm-alive-p)))


(provide 'init-helm)

