(add-hook 'latex-mode-hook
          (lambda ()
            (flyspell-mode)
            (prettify-symbols-mode -1)
            (toggle-truncate-lines -1)
            (turn-on-reftex)
            (visual-line-mode)))

(provide 'init-tex)
