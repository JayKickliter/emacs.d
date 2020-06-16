(use-package erlang-mode-abbrev-table
  :bind(("C-c C-f" . erlang-indent-current-buffer)))

(add-to-list 'auto-mode-alist '("\\.beam\\'" . hexl-mode))

(provide 'init-erlang)
