;;; init-keys.el --- Description -*- lexical-binding: t; -*-

(use-package emacs
  :init
  (global-unset-key (kbd "C-z"))
  (global-unset-key (kbd "C-j"))
  (global-unset-key (kbd "M-a"))
  (global-set-key (kbd "C-=") 'text-scale-increase)
  (global-set-key (kbd "C--") 'text-scale-decrease))

(use-package emacs
  :init
  (defadvice keyboard-escape-quit
      (around keyboard-escape-quit-dont-close-windows activate)
    (let ((buffer-quit-function (lambda () ())))
      ad-do-it)))

(use-package general
  :demand t
  :config
  (general-evil-setup)

  (general-create-definer nto/leader-keys
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "C-SPC")

  (general-create-definer nto/local-leader-keys
    :states '(normal visual)
    :keymaps 'override
    :prefix ","
    :global-prefix "SPC m")

  (nto/leader-keys
    "SPC" '(execute-extended-command :which-key "execute command")
    "<escape>" 'keyboard-escape-quit
    "b" '(:ignore t :which-key "buffer")
    "br"  'revert-buffer
    "bk"  'kill-current-buffer
    "bb"  'switch-to-buffer
    "bi"  'ibuffer
    "f" '(:ignore t :which-key "file")
    "ff"  'find-file
    "fs" 'save-buffer

    "h" '(:ignore t :which-key "describe")
    "he" 'view-echo-area-messages
    "hf" 'describe-function
    "hF" 'describe-face
    "hl" 'view-lossage
    "hL" 'find-library
    "hm" 'describe-mode
    "hk" 'describe-key
    "hK" 'describe-keymap
    "hp" 'describe-package
    "hv" 'describe-variable

    "u" '(universal-argument :wk "universal")

    "w" '(:ignore t :which-key "window")
    "wl"  'windmove-right
    "wh"  'windmove-left
    "wk"  'windmove-up
    "wj"  'windmove-down
    "wr"  'winner-redo
    "wc"  'delete-window
    "w="  'balance-windows-area
    "wD"  'kill-buffer-and-window
    "wu"  'winner-undo
    "wr"  'winner-redo
    "wm"  '(delete-other-windows :wk "maximize")))

(use-package evil
  :demand
  :general
  (nto/leader-keys
    "wv" 'evil-window-vsplit
    "ws" 'evil-window-split)
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump t)
  (setq evil-want-Y-yank-to-eol t)
  (setq evil-undo-system 'undo-fu)
  (setq evil-search-module 'evil-search)
  (setq evil-split-window-below t)
  (setq evil-vsplit-window-right t)
  (setq evil-auto-indent nil)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-motion-state-map "0" 'evil-beginning-of-line)
  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :defer 1
	:init
	(setq evil-collection-magit-use-z-for-folds nil)
  :config
  (evil-collection-init))

(use-package evil-escape
  :after evil
  :init
  (evil-escape-mode 1)
  :config
  (setq-default evil-escape-delay 0.2)
  (setq-default evil-escape-key-sequence "jk")
  (setq-default evil-escape-unordered-key-sequence t))

(provide 'init-keys)
;;; init-keys.el ends here
