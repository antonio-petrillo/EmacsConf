(use-package vterm
  :after general
  :when (not (eq system-type 'windows-nt)))

(use-package vterm-toggle
  :after vterm
  :when (not (eq system-type 'windows-nt))
  :init
  (nto/leader
	"ot" '(vterm-toggle :wk "vterm")))

(use-package powershell
  :after general
  :when (eq system-type 'windows-nt)
  :straight (powershell :type git
						:host github
						:repo "jschaf/powershell.el")
  :init
  (nto/leader
	"ot" '(powershell :wk "powershell(sucks)")))

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
