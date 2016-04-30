;;----------------------------------------------------------------------------
;; Misc config - yet to be placed in separate files
;;----------------------------------------------------------------------------

;; Open header for source file
(global-set-key (kbd "C-x C-o") 'ff-find-other-file)


(require 'linum)
(global-linum-mode t)
;; use customized linum-format: add a addition space after the line number

;; Original idea from
;; http://www.opensubscriber.com/message/emacs-devel@gnu.org/10971693.html
(defun comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command.
  If no region is selected and current line is not blank and we are not at the end of the line,
  then comment current line.
  Replaces default behaviour of comment-dwim, when it inserts comment at the end of the line."
    (interactive "*P")
    (comment-normalize-vars)
    (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
        (comment-or-uncomment-region (line-beginning-position) (line-end-position))
      (comment-dwim arg)))
(global-set-key "\M-;" 'comment-dwim-line)

;; Truncate lines by default (do not wrap)
(set-default 'truncate-lines t)

(provide 'init-misc)
