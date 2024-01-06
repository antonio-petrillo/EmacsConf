(use-package pulsar
  :after consult
  :init
  (pulsar-global-mode 1)
  (add-hook 'consult-after-jump-hook #'pulsar-recenter-top)
  (add-hook 'consult-after-jump-hook #'pulsar-reveal-entry)
  (add-hook 'imenu-after-jump-hook #'pulsar-recenter-top)
  (add-hook 'imenu-after-jump-hook #'pulsar-reveal-entry)
  :config
  (setq pulsar-pulse t
		pulsar-delay 0.055
		pulsar-iteration 10
		pulsar-face 'pulsar-magenta
		pulsar-highlight-face 'pulsar-yellow))

(use-package hide-mode-line
  :after general
  :defer t
  :init
  (nto/leader
	"tm" '(hide-mode-line-mode :wk "modeline")))

(use-package all-the-icons
  :if (display-graphic-p))

(use-package nerd-icons
  ;; :custom
  ;; The Nerd Font you want to use in GUI
  ;; "Symbols Nerd Font Mono" is the default and is recommended
  ;; but you can use any other Nerd Font if you want
  ;; (nerd-icons-font-family "Symbols Nerd Font Mono")
  )

(use-package emacs
  :after general
  :init
  (setq hl-line-sticky-flag nil) 
  (hl-line-mode +1)
  (nto/leader
    "tL" '(hl-line-mode :wk "highlight line")
	"tb" '(toggle-frame-tab-bar :wk "tabs")))

(use-package keycast
  :after general
  :defer t
  :init
  (nto/leader
	"tk" '(keycast-mode-line-mode :wk "keycast (modeline)")
	"tK" '(keycast-tab-bar-mode :wk "keycast (tab bar)")))

(use-package rainbow-mode
  :defer t)  

(use-package rainbow-delimiters
  :defer t
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package gruber-darker-theme)
(use-package ef-themes)
(use-package doom-themes)
(use-package anti-zenburn-theme)
(use-package cyberpunk-theme)
(use-package spacemacs-theme)
(use-package tron-legacy-theme)
(use-package nano-theme)

(defun nto/load-theme-or-default(selected default)
  "If `selected' is available load it, otherwise load `default'"
  (if (memq selected (custom-available-themes))
	  (load-theme selected)
	(load-theme default)))

(nto/load-theme-or-default selected-theme default-theme)

(provide 'init-ui)
