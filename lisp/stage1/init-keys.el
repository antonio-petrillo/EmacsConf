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
  :after consult
  :init
  (general-evil-setup))

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


(use-package evil
  :after general
  :general
  (nto/leader-keys
    "wv" '(evil-window-vsplit :wk "split v")
    "ws" '(evil-window-split :wk "split o"))
  (nto/leader-keys
    "SPC" '(execute-extended-command :which-key "execute command")
    "<escape>" '(keyboard-escape-quit :wk "quit")

    "b" '(:ignore t :which-key "buffer")
    "br"  '(revert-buffer :wk "revert")
    "bk"  '(kill-current-buffer :wk "kill")
    "bb"  '(consult-buffer :wk "switch")
    "bi"  '(ibuffer :wk "ibuffer")

    "f"  '(:ignore t :which-key "file")
    "ff" '(find-file :wk "find")
    "fg" '(consult-ripgrep :wk "ripgrep")
    "fF" '(consult-fd :wk "fd find")
    "."  '(find-file :wk "find")
    "fs" '(save-buffer :wk "save")
    "fr" '(consult-recent-file :wk "recent")

    "h" '(:ignore t :which-key "describe")
    "he" '(view-echo-area-messages :wk "messages buffer")
    "hf" '(describe-function :wk "function")
    "hF" '(describe-face :wk "face")
    "hl" '(view-lossage :wk "lossage")
    "hL" '(find-library :wk "library")
    "hm" '(describe-mode :wk "mode")
    "hk" '(describe-key :wk "keybind")
    "hK" '(describe-keymap :wk "keymap")
    "hp" '(describe-package :wk "package")
    "ht" '(consult-theme :wk "load theme")
    "hv" '(describe-variable :wk "variable")

    "j" '(:ignore t :wk "jump")
    "jc" '(consult-line :wk "consult")

    "o" '(:ignore t :wk "open")

    "t" '(:ignore t :wk "toggle")
    "tl" '(display-line-numbers-mode :wk "line numbers")

    "u" '(universal-argument :wk "universal")

    "w" '(:ignore t :which-key "window")
    "wl"  '(windmove-right :wk "move right")
    "wh"  '(windmove-left :wk "move left")
    "wk"  '(windmove-up :wk "move up")
    "wj"  '(windmove-down :wk "move down")
    "wc"  '(delete-window :wk "delete")
    "w="  '(balance-windows-area :wk "equal")
    "wD"  '(kill-buffer-and-window :wk "kill buffer and window")
    "wu"  '(winner-undo :wk "undo")
    "wr"  '(winner-redo :wk "redo")
    "wm"  '(delete-other-windows :wk "maximize"))

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
  (evil-mode 1)
  :config
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
