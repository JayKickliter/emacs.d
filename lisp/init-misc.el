;;----------------------------------------------------------------------------
;; Misc config - yet to be placed in separate files
;;----------------------------------------------------------------------------

;; Open header for source file
(global-set-key (kbd "C-x C-o") 'ff-find-other-file)


(require 'linum)
(global-linum-mode t)
;; use customized linum-format: add a addition space after the line number


(provide 'init-misc)
