;;----------------------------------------------------------------------------
;; Misc config - yet to be placed in separate files
;;----------------------------------------------------------------------------

;; Open header for source file
(global-set-key (kbd "C-x C-o") 'ff-find-other-file)


(require 'linum)
(add-hook 'prog-mode-hook 'linum-mode)
;; use customized linum-format: add a addition space after the line number

;; Original idea from
;; http://www.opensubscriber.com/message/emacs-devel@gnu.org/10971693.html
(defun comment-dwim-line
    (&optional
     arg)
  "Replacement for the comment-dwim command.
  If no region is selected and current line is not blank and we are not at the end of the line,
  then comment current line.
  Replaces default behaviour of comment-dwim, when it inserts comment at the end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p))
           (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position)
                                   (line-end-position))
    (comment-dwim arg)))
(global-set-key "\M-;" 'comment-dwim-line)

;; Truncate lines by default (do not wrap)
(set-default 'truncate-lines t)


;; Map alt up/down arrow to the common keybinding for jumping to the beginning/end of a function
;; To use, set the following key short cuts in your terminal emulator:
;; M-↑: send hex code `0x1b 0x1b 0x5b 0x41`
;; M-↓: send hex code `0x1b 0x1b 0x5b 0x42`
(define-key key-translation-map (kbd "ESC <up>")
  (kbd "C-M-a"))
(define-key key-translation-map (kbd "ESC <down>")
  (kbd "C-M-e"))

;; Alignment
(global-set-key (kbd "C-x a a") 'align-current)

;; Golden radio mode
(require-package 'golden-ratio)
(golden-ratio-mode)


;; Powerline
(require-package 'powerline)
(powerline-default-theme)

;; Flyspell
(add-hook 'prog-mode-hook 'flyspell-prog-mode)
(add-hook 'text-mode-hook 'flyspell-mode)


;; elisp
(require-package 'elisp-format)
(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c C-f") 'elisp-format-buffer)))

(provide 'init-misc)
