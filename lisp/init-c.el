;;; Completions
(require-package 'company-irony)
(require-package 'company-irony-c-headers)

(add-hook 'c-mode-common-hook 'irony-mode)

;; Replace the `completion-at-point' and `complete-symbol' bindings in
;; irony-mode's buffers by irony-mode's asynchronous function
(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point] 'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol] 'irony-completion-at-point-async))

(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
(after-load 'company (add-to-list 'company-backends '(company-irony-c-headers company-irony)))


;;; Eldoc integration
(require-package 'irony-eldoc)
(add-hook 'irony-mode-hook 'irony-eldoc)


;;; Flycheck integration
(require-package 'flycheck-irony)
(after-load 'flycheck (add-hook 'flycheck-mode-hook #'flycheck-irony-setup))
(add-hook 'c-mode-common-hook 'flycheck-mode)


;;; Basic settings
(setq-default c-basic-offset 4)
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))


;;; Formatting
(require-package 'clang-format)
(defun clang-format-region-or-buffer ()
  "Run clang-format on region or buffer."
  (interactive)
  (if (region-active-p)
      (clang-format-region (region-beginning)
                           (region-end))
    (clang-format-buffer)))

(add-hook 'c-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c C-f") 'clang-format-region-or-buffer)
            (hs-minor-mode)))

(add-hook 'c++-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c C-f") 'clang-format-region-or-buffer)
            (hs-minor-mode)
            (setq comment-start   "/*" comment-end     "*/" comment-padding " ")))

;; Don't indent in extern "C" regions
(add-hook 'c-mode-common-hook
          (lambda()
            (c-set-offset 'inextern-lang 0)))


;;; Tags
(require-package 'helm-gtags)

(add-hook 'c-mode-common-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)

;; customize
(custom-set-variables '(helm-gtags-path-style 'relative)
                      '(helm-gtags-ignore-case t)
                      '(helm-gtags-auto-update t))

;; key bindings
(after-load "helm-gtags" (define-key helm-gtags-mode-map (kbd "M-t") 'helm-gtags-find-tag)
            (define-key helm-gtags-mode-map (kbd "M-r") 'helm-gtags-find-rtag)
            (define-key helm-gtags-mode-map (kbd "M-s") 'helm-gtags-find-symbol)
            (define-key helm-gtags-mode-map (kbd "M-g M-p") 'helm-gtags-parse-file)
            (define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
            (define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)
            (define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-find-tag-from-here)
            (define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack))


;;; Create Header Guards with f12
(global-set-key [f12]
                '(lambda ()
                   (interactive)
                   (if (buffer-file-name)
                       (let* ((fName (upcase (file-name-nondirectory (file-name-sans-extension
                                                                      buffer-file-name))))
                              (ifDef (concat "#ifndef " fName "_H" "\n#define " fName "_H" "\n"))
                              (begin (point-marker)))
                         (progn
					; If less then 5 characters are in the buffer, insert the class definition
			   (if (< (- (point-max)
                                     (point-min)) 5 )
                               (progn (insert "\nclass " (capitalize fName)
                                              "{\npublic:\n\nprivate:\n\n};\n")
                                      (goto-char (point-min))
                                      (next-line-nomark 3)
                                      (setq begin (point-marker))))
                                        ;Insert the Header Guard
			   (goto-char (point-min))
                           (insert ifDef)
                           (goto-char (point-max))
                           (insert "\n#endif" " /* " fName "_H" " */")
                           (goto-char begin)))
                                        ;else
		     (message (concat "Buffer " (buffer-name) " must have a filename")))))

(provide 'init-c)
