;; C formatting 
(require-package 'clang-format)

;; C mode settings
(setq-default c-basic-offset 4)
(add-hook 'c-mode-common-hook
	  (lambda () (c-toggle-auto-state 1))
	  (lambda () (hs-minor-mode 1)))

; Create Header Guards with f12
(global-set-key [f12]
		'(lambda ()
		   (interactive)
		   (if (buffer-file-name)
		       (let*
			   ((fName (upcase (file-name-nondirectory (file-name-sans-extension buffer-file-name))))
			    (ifDef (concat "#ifndef " fName "_H" "\n#define " fName "_H" "\n"))
			    (begin (point-marker))
			    )
			 (progn
					; If less then 5 characters are in the buffer, insert the class definition
			   (if (< (- (point-max) (point-min)) 5 )
			       (progn
				 (insert "\nclass " (capitalize fName) "{\npublic:\n\nprivate:\n\n};\n")
				 (goto-char (point-min))
				 (next-line-nomark 3)
				 (setq begin (point-marker))
				 )
			     )
			   ;Insert the Header Guard
			   (goto-char (point-min))
			   (insert ifDef)
			   (goto-char (point-max))
			   (insert "\n#endif" " //" fName "_H")
			   (goto-char begin))
			 )
		     ;else
		     (message (concat "Buffer " (buffer-name) " must have a filename"))
		     )
		   )
		)
(provide 'init-c)
