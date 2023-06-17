;;; init-utils.el --- Description -*- lexical-binding: t; -*-

(use-package gcmh
  :demand
  :config
  (gcmh-mode 1))

(use-package helpful
  :after evil
  :init
  (setq evil-lookup-func #'helpful-at-point)
  :bind
  ([remap describe-function] . helpful-callable)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . helpful-variable)
  ([remap describe-key] . helpful-key))

(use-package evil-goggles
  :after evil
  :demand
  :init
  (setq evil-goggles-duration 0.05)
  :config
  (push '(evil-operator-eval
          :face evil-goggles-yank-face
          :switch evil-goggles-enable-yank
          :advice evil-goggles--generic-async-advice)
        evil-goggles--commands)
  (evil-goggles-mode)
  (evil-goggles-use-diff-faces))

(use-package evil-snipe
	:after evil
	:demand
	:config
	(evil-snipe-mode +1)

(use-package evil-surround
  :general
  (:states 'operator
   "s" 'evil-surround-edit
   "S" 'evil-Surround-edit)
  (:states 'visual
   "S" 'evil-surround-region
   "gS" 'evil-Surround-region))
  (evil-snipe-override-mode +1))

(use-package evil-indent-plus
	:after evil
	:demand
  :config
  (define-key evil-inner-text-objects-map "i" 'evil-indent-plus-i-indent)
  (define-key evil-outer-text-objects-map "i" 'evil-indent-plus-a-indent)
	(define-key evil-inner-text-objects-map "k" 'evil-indent-plus-i-indent-up)
	(define-key evil-outer-text-objects-map "k" 'evil-indent-plus-a-indent-up)
	(define-key evil-inner-text-objects-map "j" 'evil-indent-plus-i-indent-up-down)
	(define-key evil-outer-text-objects-map "j" 'evil-indent-plus-a-indent-up-down))

(use-package which-key
  :demand
  :general
  (nto/leader-keys
    "?" 'which-key-show-top-level)
  :init
  (setq which-key-separator " ")
  (setq which-key-prefix-prefix "+")
  (setq which-key-show-early-on-C-h t)
  (setq which-key-idle-delay 10000)
  (setq which-key-idle-secondary-delay 0.05)
  :config
  (which-key-mode))

(use-package all-the-icons)

(provide 'init-utils)
;;; init-utils.el ends here
