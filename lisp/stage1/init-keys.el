;;; init-keys.el --- Description -*- lexical-binding: t; -*-

(use-package emacs
  :init
  (global-unset-key (kbd "C-z"))
  (global-unset-key (kbd "C-j"))
  (global-unset-key (kbd "M-a"))
  (global-set-key (kbd "C-=") 'text-scale-increase)
  (global-set-key (kbd "C--") 'text-scale-decrease))

(use-package emacs
  :bind* ("M-<return>" . other-window)
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
    :prefix "m"
    :global-prefix "C-,")

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
    "."  'find-file
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
    "ht" 'load-theme
    "hv" 'describe-variable

    "o" '(:ignore t :wk "open")

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
  (setq evil-want-C-i-jump nil)
  (setq evil-want-Y-yank-to-eol t)
  (setq evil-undo-system 'undo-fu)
  (setq evil-search-module 'evil-search)
  (setq evil-split-window-below t)
  (setq evil-vsplit-window-right t)
  (setq evil-auto-indent nil)
  :config
  (evil-mode 1)
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

(use-package evil-collection
  :after evil
  :defer t
  :init
  (setq evil-collection-magit-use-z-for-folds nil)
  :config
  (setq evil-want-C-i-jump nil)
  (evil-collection-init)
  (evil-collection-unimpaired-mode -1)
  (global-evil-collection-unimpaired-mode -1))

(provide 'init-keys)
;;; init-keys.el ends here
