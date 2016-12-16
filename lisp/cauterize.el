;;; cauterize.el -- A major mode for editing cauterize schemas

;;; Commentary:

;;; Code:

(defvar cauterize-mode-font-lock nil "Highlighting expressions for Cauterize mode.")
(setq cauterize-mode-font-lock
  (list
   '("\\( \\|\t\\|(\\)\\(name\\|version\\|type\\|array\\|vector\\|union\\|fields\\|field\\|empty\\|synonym\\|enumeration\\|record\\|values\\)"
     . (2 font-lock-keyword-face))
   ;; bool, s8, u64, f32, etc.
   '("\\( \\|\t\\)\\(bool\\|[us]\\(8\\|16\\|32\\|64\\)\\|f\\(32\\|64\\)\\)\\( \\|\t\\|)\\)"
     . (2 font-lock-type-face))))

(defvar cauterize-mode-syntax-table)
(setq cauterize-mode-syntax-table
    (let ((synTable (make-syntax-table)))
        (modify-syntax-entry ?; "<" synTable)
        (modify-syntax-entry ?\n ">" synTable)
        synTable))

(define-derived-mode cauterize-mode prog-mode "cauterize"
    "cauterize-mode is a major mode for editing Cauterize files"

    (setq font-lock-defaults '(cauterize-mode-font-lock))
    (set-syntax-table cauterize-mode-syntax-table)
    (setq comment-start ";;")
    (setq commend-end   ""))

(provide 'cauterize)
;;; cauterize.el ends here
