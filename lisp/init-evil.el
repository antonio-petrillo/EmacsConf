(defadvice keyboard-escape-quit
	(around keyboard-escape-quit-dont-close-windows activate)
  (let ((buffer-quit-function (lambda () ())))
	ad-do-it))

(use-package general
  :after evil
  :init
  (general-create-definer nto/leader
	:states '(normal insert visual emacs)
	:keymaps 'override
	:prefix "SPC"
	:global-prefix "C-SPC")

  (general-create-definer nto/local-leader
	:states '(normal visual)
	:prefix "m"
	:global-prefix "C-m")

  (nto/leader "?" '(which-key-show-top-level :wk "?"))
  (general-evil-setup))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  (setq evil-want-Y-yank-to-eol t)
  (setq evil-undo-system 'undo-fu)
  (setq evil-search-module 'evil-search)
  (setq evil-split-window-below nil)
  (setq evil-vsplit-window-right t)
  (setq evil-auto-indent nil)
  (evil-mode 1)
  :config
  (setq evil-overriding-maps nil)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-n") 'next-line)
  (define-key evil-insert-state-map (kbd "C-p") 'previous-line)
  (define-key evil-insert-state-map (kbd "C-h") 'backward-delete-char)
  (define-key evil-insert-state-map (kbd "C-d") 'delete-char)
  (define-key evil-normal-state-map (kbd "C-n") 'next-line)
  (define-key evil-normal-state-map (kbd "C-p") 'previous-line)
  (define-key evil-normal-state-map (kbd "C-h") 'backward-delete-char)
  (define-key evil-normal-state-map (kbd "C-d") 'delete-char)
  (define-key evil-motion-state-map "0" 'evil-beginning-of-line)
  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package emacs
  :after general
  :init
  (nto/leader
	"SPC" '(execute-extended-command :which-key "M-x but faster")
	"<escape>" '(keyboard-escape-quit :wk "quit")
	"g" '(:ignore t :wk "git")
	"j" '(:ignore t :wk "jump")
	"jc" '(consult-line :wk "consult line")
	"l" '(:ignore t :wk "language")
	"o" '(:ignore t :wk "open")
	"p" '(:ignore t :wk "project")
	"r" '(:ignore t :wk "rotate")
	"s" '(:ignore t :wk "search")
	"t" '(:ignore t :wk "toggle")
	"u" '(universal-argument :wk "universal")))

(use-package evil-collection
  :after evil
  :init
  (setq evil-collection-magit-use-z-for-folds nil)
  :config
  (setq evil-want-C-i-jump nil)
  (evil-collection-init)
  (evil-collection-unimpaired-mode -1)
  (global-evil-collection-unimpaired-mode -1))

(use-package evil-snipe
  :after evil
  :config
  (evil-snipe-mode +1)
  (setq evil-snipe-scope 'buffer))

(use-package evil-escape
  :after evil
  :init
  (evil-escape-mode 1)
  :config
  (setq-default evil-escape-delay 0.2)
  (setq-default evil-escape-key-sequence "jk")
  (setq-default evil-escape-unordered-key-sequence nil))

(provide 'init-evil)
