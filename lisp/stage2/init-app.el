;;; init-app.el --- Description -*- lexical-binding: t; -*-
(use-package ace-window
  :init
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  (defvar aw-dispatch-alist
	'((?x aw-delete-window "Delete Window")
	  (?m aw-swap-window "Swap Windows")
	  (?M aw-move-window "Move Window")
	  (?c aw-copy-window "Copy Window")
	  (?j aw-switch-buffer-in-window "Select Buffer")
	  (?n aw-flip-window)
	  (?u aw-switch-buffer-other-window "Switch Buffer Other Window")
	  (?c aw-split-window-fair "Split Fair Window")
	  (?v aw-split-window-vert "Split Vert Window")
	  (?b aw-split-window-horz "Split Horz Window")
	  (?o delete-other-windows "Delete Other Windows")
	  (?? aw-show-dispatch-help))
	"List of actions for `aw-dispatch-default'.")
  :general
  (nto/leader-keys
    "ww" '(ace-window :wk "ace window")))

(use-package dired
  :straight (:type built-in)
  :after evil
  :hook
  (dired-mode . dired-hide-details-mode)
  :general
  (nto/leader-keys
    "fd" 'dired-jump
    "fj" 'dired-jump)
  :config
  (evil-define-key 'normal dired-mode-map
    "h" 'dired-up-directory
    "l" 'dired-find-file
	"m" 'dired-mark
	"u" 'dired-unmark
	"t" 'dired-toggle-marks
	"C" 'dired-do-copy
	"D" 'dired-do-delete
	"J" 'dired-goto-file
	"M" 'dired-do-chmod
	"O" 'dired-do-chown
	"R" 'dired-do-rename
	"T" 'dired-do-touch
	"Y" 'dired-copy-filename-as-kill
	"+" 'dired-create-directory
	"-" 'dired-up-directory
	(kbd "% l") 'dired-downcase
	(kbd "% u") 'dired-upcase
	(kbd "; d") 'epa-dired-do-decrypt
	(kbd "; e") 'epa-dired-do-encrypt)
  :init
  (setq delete-by-moving-to-trash t)
  (setq dired-listing-switches "-lah")
  (setq dired-dwim-target t)
  (setf dired-kill-when-opening-new-dired-buffer t)

(use-package dired-hide-dotfiles
  :after dired
  :hook (dired-mode . dired-hide-dotfiles-mode)
  :config
  (evil-define-key 'normal dired-mode-map
    "H" 'dired-hide-dotfiles-mode)))

(use-package undo-fu
  :general
  (:states 'normal
           "u" 'undo-fu-only-undo
           "s-z" 'undo-fu-only-undo
           "\C-r" 'undo-fu-only-redo))

(use-package undo-fu-session
  :after undo-fu
  :demand
  :init
  (setq undo-fu-session-incompatible-files '("/COMMIT_EDITMSG\\'" "/git-rebase-todo\\'"))
  :config
  (global-undo-fu-session-mode))

(use-package avy
  :general
  (nto/leader-keys
	"j" '(:ignore t :wk "jump")
    "jj" 'avy-goto-char
    "jl" 'avy-goto-line
    "jw" 'avy-goto-word-0)
  :hook (after-init . avy-setup-default)
  :init
  (setq avy-style 'pre))

(with-windows
	(use-package powershell
	  :straight (powershell :type git
							:host github
							:repo "jschaf/powershell.el")
	  :init
	  (nto/leader-keys "ot" 'powershell)))

(without-windows
  (use-package vterm)

  (use-package vterm-toggle
	:general
	(nto/leader-keys
	  "ot" 'vterm-toggle))

  (use-package multi-vterm
	:config
	(add-hook 'vterm-mode-hook
              (lambda ()
				(evil-insert-state)))
	(define-key vterm-mode-map [return] #'vterm-send-return)
	:general
	(nto/local-leader-keys
	  "c" 'multi-vterm
	  "n" 'multi-vterm-next
	  "p" 'multi-vterm-prev
	  "l" 'multi-vterm-next
	  "h" 'multi-vterm-prev)))

(use-package eshell
  :init
  (setq ;; eshell-buffer-shorthand t ...  Can't see Bug#19391
        eshell-scroll-to-bottom-on-input 'all
        eshell-error-if-no-glob t
        eshell-hist-ignoredups t
        eshell-save-history-on-exit t
        eshell-prefer-lisp-functions nil
        eshell-destroy-buffer-when-process-dies t))

(use-package eshell-toggle
  :init
  (nto/leader-keys
	"oe" 'eshell-toggle))

(use-package google-translate
  :init
  (setq google-translate-translation-directions-alist
        '(("it" . "en") ("en" . "it")))
  (setq google-translate-default-source-language "it")
  (setq google-translate-default-target-language "en")
  (nto/leader-keys
	"l" '(:ignore t :wk "language")
	"lt" 'google-translate-smooth-translate
	"lT" 'google-translate-query-translate
	"lp" 'google-translate-at-point
	"lP" 'google-translate-at-point-reverse))

(use-package olivetti
  :init
  (nto/leader-keys
	"oo" 'olivetti-mode))

(use-package browse-kill-ring
  :init
  (setq browse-kill-ring-highlight-current-entry t)
  (setq browse-kill-ring-separator "?? ------------------------- ?")
  (setq browse-kill-ring-separator-face 'shadow)
  (setq browse-kill-ring-show-preview nil)
  (global-set-key (kbd "M-y") 'browse-kill-ring)
  :config
  (define-key browse-kill-ring-mode-map (kbd "d") 'browse-kill-ring-delete)
  (define-key browse-kill-ring-mode-map (kbd "j") 'browse-kill-ring-forward)
  (define-key browse-kill-ring-mode-map (kbd "k") 'browse-kill-ring-previouse)
  (define-key browse-kill-ring-mode-map (kbd "/") 'browse-kill-ring-occur)
  (define-key browse-kill-ring-mode-map (kbd "n") 'browse-kill-ring-search-forward)
  (define-key browse-kill-ring-mode-map (kbd "p") 'browse-kill-ring-search-backward)
  (define-key browse-kill-ring-mode-map (kbd "C-j") 'browse-kill-ring-forward)
  (define-key browse-kill-ring-mode-map (kbd "C-k") 'browse-kill-ring-previous)
  (define-key browse-kill-ring-mode-map (kbd "<escapte>") 'browse-kill-ring-quit)
  (define-key browse-kill-ring-mode-map (kbd "q") 'browse-kill-ring-quit))

(use-package magit
  :init
  (nto/leader-keys
	"g" '(:ignore t :wk "git")
	"gg" 'magit-status))

(provide 'init-app)
;;; init-app.el ends here
