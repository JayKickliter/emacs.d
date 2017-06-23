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

(defcustom compilation-hide-on-success t
  "Hides *compilation* window if compilation is successful."
  :type 'boolean
  :group 'compilation)

;; compilation - hide compilation buffer on success after 2 seconds
;; from enberg on #emacs
(setq compilation-finish-function
      (lambda (buf str)
        (if (bound-and-true-p compilation-hide-on-success)
            (if (null (string-match ".*exited abnormally.*" str))
                ;;no errors, make the compilation window go away in a few seconds
                (progn (run-at-time "2 sec" nil 'delete-windows-on (get-buffer-create
                                                                    "*compilation*"))
                       (message "No Compilation Errors!"))))))

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
;; Cycle between snake case, camel case, etc.                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'string-inflection)
(global-set-key (kbd "C-c i") 'string-inflection-cycle)
(global-set-key (kbd "C-c c u") 'string-inflection-camelcase) ;; Force to CamelCase
(global-set-key (kbd "C-c c l") 'string-inflection-lower-camelcase) ;; Force to lowerCamelCase
(global-set-key (kbd "C-c c s") 'string-inflection-underscore) ;; Force to snake_case


(provide 'init-misc)
