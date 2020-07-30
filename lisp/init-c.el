
;;; Basic settings
(setq-default c-basic-offset 4)
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))


;;; Code completion and analysis
(use-package lsp-mode :commands lsp)
(use-package lsp-ui :commands lsp-ui-mode)
(use-package company-lsp :commands company-lsp)

(use-package ccls
  :hook ((c-mode c++-mode objc-mode cuda-mode) .
         (lambda ()
           (require 'ccls)
           (lsp))))


;;; Formatting
(use-package clang-format
  :ensure t)

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
(use-package helm-gtags
  :ensure t
  :hook((c-mode-common-hook . helm-gtags-mode)
        (asm-mode-hook . helm-gtags-mode))
  :custom
  (helm-gtags-path-style 'relative)
  (helm-gtags-ignore-case t)
  (helm-gtags-auto-update t)
  :bind (("M-t"     . helm-gtags-find-tag)
         ("M-r"     . helm-gtags-find-rtag)
         ("M-s"     . helm-gtags-find-symbol)
         ("M-g M-p" . helm-gtags-parse-file)
         ("C-c <"   . helm-gtags-previous-history)
         ("C-c >"   . helm-gtags-next-history)
         ("M-."     . helm-gtags-find-tag-from-here)
         ("M-,"     . helm-gtags-pop-stack)))


;;; Create Header Guards with f12
(global-set-key [f12]
                '(lambda ()
                   (interactive)
                   (if (buffer-file-name)
                       (let* ((fName (upcase (file-name-nondirectory (file-name-sans-extension
                                                                      buffer-file-name))))
                              (uId (format "%08X" (random (expt 16 8))))
                              (ifDef (concat "#ifndef " fName "_" uId "\n#define " fName "_" uId
                                             "\n"))
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
                           (insert "\n#endif" " /* " fName "_" uId " */")
                           (goto-char begin)))
                                        ;else
		     (message (concat "Buffer " (buffer-name) " must have a filename")))))

(provide 'init-c)
