(require-package 'projectile)
(require-package 'helm-projectile)

(projectile-mode +1)
(setq projectile-completion-system 'helm)
(helm-projectile-on)
(setq projectile-switch-project-action 'neotree-projectile-action)
(setq projectile-buffers-filter-function 'projectile-buffers-with-file)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "<f13>") 'projectile-switch-to-buffer)
(setq projectile-mode-line "Proj")

(defun neotree-project-dir ()
  "Open NeoTree using the git root."
  (interactive)
  (let ((project-dir (projectile-project-root))
        (file-name (buffer-file-name)))
    (if project-dir (progn (neotree)
                           (neotree-dir project-dir)
                           (neotree-find file-name))
      (message "Could not find git project root."))))

(global-set-key [f8] 'neotree-project-dir)

(provide 'init-projectile)
