(when (< emacs-major-version 24)
  (require-package 'color-theme))

(require-package 'color-theme-solarized)

(load-theme 'solarized t)

(add-hook 'after-make-frame-functions
          (lambda (frame)
            (let ((mode (if (display-graphic-p frame) 'light 'dark)))
              (set-frame-parameter frame 'background-mode mode)
              (set-terminal-parameter frame 'background-mode mode))
                        (enable-theme 'solarized)))

(provide 'init-themes)
