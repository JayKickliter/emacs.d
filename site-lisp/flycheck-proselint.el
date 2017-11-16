;;; flycheck-proselint --- A linter for prose"
;;; Commentary:
;;;
;;; To install flycheck from MELPA, evaluate:
;;;
;;; (add-hook 'markdown-mode-hook #'flycheck-mode)
;;; (add-hook 'text-mode-hook #'flycheck-mode)

;;; Code:
(require 'flycheck)
(flycheck-define-checker proselint "A linter for prose."
                         :command ("proselint" source-inplace)
                         :error-patterns ((warning line-start (file-name) ":" line ":" column ": "
                                                   (id (one-or-more (not (any " "))))
                                                   (message (one-or-more not-newline)
                                                            (zero-or-more "\n" (any " ")
                                                                          (one-or-more
                                                                           not-newline))) line-end))
                         :modes (text-mode markdown-mode gfm-mode))
(add-to-list 'flycheck-checkers 'proselint)
(provide 'flycheck-proselint)

;;; flycheck-proselint.el ends here
