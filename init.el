;; -*- lexical-binding: t -*-

;;; This file bootstraps the configuration, which is divided into
;;; a number of other files.

(let ((minver "24.3"))
  (when (version< emacs-version minver)
    (error
     "Your Emacs is too old -- this config requires v%s or higher"
     minver)))
(when (version< emacs-version "24.5")
  (message
   "Your Emacs is old, and some functionality in this config will be disabled. Please upgrade if possible."))

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(require 'init-benchmarking) ;; Measure startup time

(defconst *spell-check-support-enabled* nil) ;; Enable with t if you prefer
(defconst *is-a-mac* (eq system-type 'darwin))

;; Allow shortened y/n responses to prompts
(defalias 'yes-or-no-p 'y-or-n-p)

;;----------------------------------------------------------------------------
;; Temporarily reduce garbage collection during startup
;;----------------------------------------------------------------------------
(defconst sanityinc/initial-gc-cons-threshold gc-cons-threshold
  "Initial value of `gc-cons-threshold' at start-up time.")
(setq gc-cons-threshold (* 128 1024 1024))
(add-hook 'after-init-hook
          (lambda ()
            (setq gc-cons-threshold sanityinc/initial-gc-cons-threshold)))

;;----------------------------------------------------------------------------
;; Bootstrap config
;;----------------------------------------------------------------------------
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(require 'init-compat)
(require 'init-utils)
(require 'init-site-lisp) ;; Must come before elpa, as it may provide package.el
;; Calls (package-initialize)
(require 'init-elpa) ;; Machinery for installing required packages
(require 'init-exec-path) ;; Set up $PATH

;;----------------------------------------------------------------------------
;; Allow users to provide an optional "init-preload-local.el"
;;----------------------------------------------------------------------------
(require 'init-preload-local nil t)

;;----------------------------------------------------------------------------
;; Load configs for specific features and modes
;;----------------------------------------------------------------------------

(require-package 'wgrep)
(require-package 'diminish)
(require-package 'scratch)
(require-package 'use-package)

(require 'init-frame-hooks)
(require 'init-themes)
(require 'init-osx-keys)
(require 'init-gui-frames)

(require 'init-isearch)
(require 'init-flycheck)
(require 'init-ido)
(require 'init-company)

(require 'init-windows)
(require 'init-sessions)

(require 'init-editing-utils)
(require 'init-whitespace)

(require 'init-vc)
(require 'init-git)
(require 'init-github)

(require 'init-compile)
(require 'init-markdown)
(require 'init-erlang)
(require 'init-haskell)

(require 'init-paredit)
(require 'init-yas)

(require 'init-hideshow)
(require 'init-helm)
(require 'init-c)
(require 'init-mouse)
(require 'init-neotree)
(require 'init-ninja)
(require 'init-projectile)
(require 'init-clipboard)
(require 'init-rust)

(require 'cauterize)
(require 'init-tex)
(require 'init-yaml)

(when *spell-check-support-enabled*
  (require 'init-spelling))

(require 'init-misc)

(require 'init-dash)
(require 'init-ledger)
;; Extra packages which don't require any configuration
(require-package 'lua-mode)
(require-package 'htmlize)
(require-package 'dsvn)
(when *is-a-mac* (require-package 'osx-location))
(require-package 'regex-tool)

;;----------------------------------------------------------------------------
;; Allow access from emacsclient
;;----------------------------------------------------------------------------
(require 'server)
(unless (server-running-p)
  (server-start))


;;----------------------------------------------------------------------------
;; Variables configured via the interactive 'customize' interface
;;----------------------------------------------------------------------------
(when (file-exists-p custom-file)
  (load custom-file))


;;----------------------------------------------------------------------------
;; Allow users to provide an optional "init-local" containing personal settings
;;----------------------------------------------------------------------------
(when (file-exists-p (expand-file-name "init-local.el" user-emacs-directory))
  (error
   "Please move init-local.el to ~/.emacs.d/lisp"))
(require 'init-local nil t)


;;----------------------------------------------------------------------------
;; Locales (setting them earlier in this file doesn't work in X)
;;----------------------------------------------------------------------------
(require 'init-locales)

(add-hook 'after-init-hook
          (lambda ()
            (message "init completed in %.2fms" (sanityinc/time-subtract-millis after-init-time
                                                                                before-init-time))))







(setq tramp-ssh-controlmaster-options "")


;;(setq disable-tramp-backups nil) ;; allow all tramp files to be backuped
;;(setq disable-tramp-backups '("su" "sudo")) ;; only 'su' and 'sudo'
;;(setq disable-tramp-backups '("ssh" "sftp")) ;; only 'ssh' and 'sftp'
(defvar disable-tramp-backups '(all))

(eval-after-load "tramp" '(progn
                            ;; Modified from https://www.gnu.org/software/emacs/manual/html_node/tramp/Auto_002dsave-and-Backup.html
                            (setq backup-enable-predicate
                                  (lambda (name)
                                    (and (normal-backup-enable-predicate name)
                                         ;; Disable all tramp backups
                                         (and disable-tramp-backups
                                              (member 'all disable-tramp-backups)
                                              (not (file-remote-p name 'method)))
                                         (not ;; disable backup for tramp with the listed methods
                                          (let ((method (file-remote-p name 'method)))
                                            (when (stringp method)
                                              (member method disable-tramp-backups)))))))
                            (defun tramp-set-auto-save--check (original)
                              (if (funcall backup-enable-predicate (buffer-file-name))
                                  (funcall original)
                                (auto-save-mode -1)))
                            (advice-add 'tramp-set-auto-save
                                        :around #'tramp-set-auto-save--check)

                            ;; Use my ~/.ssh/config control master settings according to https://puppet.com/blog/speed-up-ssh-by-reusing-connections
                            (setq tramp-ssh-controlmaster-options "")))

(with-current-buffer (get-buffer "*scratch*")
  (shell-command "ls -al")) ;; just a sample shell command



(provide 'init)

;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:
