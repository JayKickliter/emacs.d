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
  ;; what describe-key reports for cmd-option-h
  (global-set-key (kbd "M-ˍ") 'ns-do-hide-others))

(remove-hook 'prog-mode-hook 'flymake-mode)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; use-package                                                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require-package 'use-package)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Global Key Bindings                                                    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "M-j") 'default-indent-new-line)
(global-set-key [f9] 'kill-this-buffer)
(global-set-key (kbd "M-;") 'comment-dwim)
(global-set-key [f5]
                (lambda ()
                  (interactive)
                  (revert-buffer t t t)
                  (message "buffer is reverted")))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; multiple-cursors                                                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package multiple-cursors
  :bind ("A-M-c" . mc/edit-lines))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LSP/Rust                                                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package lsp-mode
  :ensure t
  :hook (rust-mode . lsp)
  :commands lsp)

(use-package lsp-ui
  :ensure t)

(defun start-file-process-shell-command@around (start-file-process-shell-command name buffer &rest args)
  "Start a program in a subprocess.  Return the process object for it.
Similar to `start-process-shell-command', but calls `start-file-process'."
  ;; On remote hosts, the local `shell-file-name' might be useless.
  (let ((command (mapconcat 'identity args " ")))
    (funcall start-file-process-shell-command name buffer command)))

(advice-add 'start-file-process-shell-command :around #'start-file-process-shell-command@around)

(with-eval-after-load "lsp-rust"
  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-tramp-connection
                     (executable-find (car lsp-rust-analyzer-server-command)))
    :major-modes '(rust-mode rustic-mode)
    :priority (if (eq lsp-rust-server 'rust-analyzer) 1 -1)
    :remote? t
    :initialization-options 'lsp-rust-analyzer--make-init-options
    :notification-handlers (ht<-alist lsp-rust-notification-handlers)
    :action-handlers (ht<-alist lsp-rust-action-handlers)
    :library-folders-fn (lambda (_workspace) lsp-rust-library-directories)
    :ignore-messages nil
    :server-id 'rust-analyzer-remote)))

(with-eval-after-load "rust-mode"
  (define-key rust-mode-map (kbd "C-h C-d") 'lsp-rust-analyzer-open-external-docs))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Neotree                                                                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package neotree
  :ensure t
  :init (require 'neotree)
  :bind (("M-<f8>" . neotree-toggle)
         ([f8] . (lambda ()
                   "Open NeoTree using the git root."
                   (interactive)
                   (let ((project-dir (projectile-project-root))
                         (file-name (buffer-file-name)))
                     (if project-dir (progn (neotree)
                                            (neotree-dir project-dir)
                                            (neotree-find file-name))
                       (message "Could not find git project root."))))))
  ;; For edited files: hightlight (face) and prefix names with `E' (char).
  :custom (neo-vc-integration '(face char)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Golden Ratio                                                           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package golden-ratio
  :ensure t
  :config (golden-ratio-mode))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Clang Format                                                           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package clang-format
  :ensure t
  :init
  (add-hook 'c-mode-common-hook
            #'(lambda ()
                (local-set-key (kbd "C-c C-f") 'clang-format-buffer))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Full width comment box                                                 ;;
;; from http://irreal.org/blog/?p=374                                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun bjm-comment-box (b e)
  "Draw a box comment around the region but arrange for the region to extend to at least the fill column.  Place the point after the comment box."
  (interactive "r")
  (let ((e (copy-marker e t)))
    (goto-char b)
    (end-of-line)
    (insert-char ?  (- fill-column (current-column)))
    (comment-box b e 1)
    (goto-char e)
    (set-marker e nil)))

(global-set-key (kbd "C-c b b") 'bjm-comment-box)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; The command ‘M-x reverse-region’ will reverse the lines a region.      ;;
;; https://www.emacswiki.org/emacs/ReverseWords                           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun reverse-words (beg end)
  "Reverse the order of words in region."
  (interactive "*r")
  (apply
   'insert
   (reverse
    (split-string
     (delete-and-extract-region beg end) "\\b"))))

(provide 'init-local)
