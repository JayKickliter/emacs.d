(defun ninja (command)
  (interactive
   (let* ((make-directory (locate-dominating-file (buffer-file-name)
                          "build.ninja"))
      (command (concat "ninja -C "
               (expand-file-name make-directory))))
     (list (compilation-read-command command))))
    (compile command))

(provide 'init-ninja)
