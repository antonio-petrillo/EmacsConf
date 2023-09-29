;;; init-utils.el --- Description -*- lexical-binding: t; -*-

(use-package gcmh
  :diminish gcmh-mode
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
  :diminish evil-goggles-mode
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
	:diminish evil-snipe-mode
	:diminish evil-snipe-local-mode
	:demand
	:config
	(evil-snipe-mode +1)
	(setq evil-snipe-scope 'buffer))

(use-package evil-surround
  :diminish global-evil-surround-mode
  :general
  (:states 'operator
   "s" 'evil-surround-edit
   "S" 'evil-Surround-edit)
  (:states 'visual
   "S" 'evil-surround-region
   "gS" 'evil-Surround-region))

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
  :demand t
  :diminish which-key-mode
  :general
  (nto/leader-keys
    "?" '(which-key-show-top-level :wk "help"))
  :init
  (setq which-key-separator " ")
  (setq which-key-prefix-prefix "+")
  (setq which-key-show-early-on-C-h t)
  (setq which-key-idle-delay 0.5)
  (setq which-key-idle-secondary-delay 0.5)
  :config
  (which-key-mode)
  (which-key-setup-minibuffer))

(use-package all-the-icons)

(use-package evil-multiedit
  :after evil
  :init
  (evil-define-key 'normal 'global
	(kbd "M-a")   #'evil-multiedit-match-symbol-and-next
	(kbd "M-A")   #'evil-multiedit-match-symbol-and-prev)

  (evil-define-key 'visual 'global
	"R"           #'evil-multiedit-match-all
	(kbd "M-a")   #'evil-multiedit-match-and-next
	(kbd "M-A")   #'evil-multiedit-match-and-prev)

  (evil-define-key '(visual normal) 'global
	(kbd "C-M-a") #'evil-multiedit-restore)

  (with-eval-after-load 'evil-mutliedit
    (evil-define-key 'multiedit 'global
      (kbd "M-a")   #'evil-multiedit-match-and-next
      (kbd "M-S-a") #'evil-multiedit-match-and-prev
      (kbd "RET")   #'evil-multiedit-toggle-or-restrict-region)
    (evil-define-key '(multiedit multiedit-insert) 'global
      (kbd "C-n")   #'evil-multiedit-next
      (kbd "C-p")   #'evil-multiedit-prev)))

(use-package evil-org
  :after '(org evil)
  :hook (org-mode . (lambda () evil-org-mode))
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(use-package emacs
  :init
  (electric-pair-mode 1)
  (push '(?{ . ?}) electric-pair-pairs))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package evil-escape
  :after evil
  :diminish evil-escape-mode
  :init
  (evil-escape-mode 1)
  :config
  (setq-default evil-escape-delay 0.2)
  (setq-default evil-escape-key-sequence "jk")
  (setq-default evil-escape-unordered-key-sequence t))

(provide 'init-utils)
;;; init-utils.el ends here
