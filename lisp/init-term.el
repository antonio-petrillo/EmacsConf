(when (not (eq system-type 'windows-nt))
  (use-package vterm
	:after general
	:demand t)

  (use-package vterm-toggle
	:after vterm
	:init
	(nto/leader
	  "ot" '(vterm-toggle :wk "vterm"))))

(when (eq system-type 'windows-nt)
  (use-package powershell
	:after general
	:straight (powershell :type git
						  :host github
						  :repo "jschaf/powershell.el")
	:init
	(nto/leader
	  "ot" '(powershell :wk "powershell"))))

(use-package eshell
  :init
  (setq eshell-scroll-to-bottom-on-input 'all
		eshell-error-if-no-glob t
		eshell-hist-ignoredups t
		eshell-save-history-on-exit t
		eshell-prefer-lisp-functions nil
		eshell-destroy-buffer-when-process-dies t))

(use-package eshell-toggle
  :after general
  :init
  (nto/leader
	"oe" '(eshell-toggle :wk "eshell")))

(provide 'init-term)
