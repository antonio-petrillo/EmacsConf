(global-unset-key (kbd "C-z"))
(global-unset-key (kbd "C-j"))
(global-unset-key (kbd "M-a"))
(global-unset-key (kbd "C-;"))

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

(global-auto-revert-mode 1)
(delete-selection-mode 1)
(recentf-mode t)

(setq auto-revert-verbose t
	  vc-follow-symlinks t
	  confirm-kill-processes nil
	  load-prefer-newer t
	  recentf-exclude `(,(expand-file-name "straight/build/" user-emacs-directory)
						,(expand-file-name "eln-cache/" user-emacs-directory)
						,(expand-file-name "etc" user-emacs-directory)
						,(expand-file-name "var" user-emacs-directory)))

(use-package gcmh
  :demand t
  :config (gcmh-mode))

(use-package use-package)

(use-package consult
  :bind
  (("M-y" . consult-yank-pop)))

;; magit fix transient bug, should fix in emacs 30.x
(use-package magit)

(use-package transient
  :straight t
  :defer t)

(use-package popper
  :bind (("C-`" . popper-toggle)
		 ("M-`" . popper-cycle)
		 ("C-M-`" . popper-toggle-type))
  :init
  (setq popper-reference-buffers
		'("\\*Messages\\*"
		  "Output\\*$"
		  "\\*Async Shell Command\\*"
		  help-mode
		  compilation-mode))
  (popper-mode +1)
  (popper-echo-mode +1))

(provide 'init-core)
