;;; init-app.el --- Description -*- lexical-binding: t; -*-
(use-package ace-window
  :general
  (nto/leader-keys
    "ww" '(ace-window :wk "ace window")))

(use-package dired
  :straight (:type built-in)
  :hook
  (dired-mode . dired-hide-details-mode)
  :general
  (nto/leader-keys
    "fd" 'dired
    "." 'dired-jump
    "fj" 'dired-jump)
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "h" 'dired-up-directory
    "l" 'dired-find-file)
  :init
  (setq dired-listing-switches "-lah")
  (setq dired-dwim-target t)
  (setf dired-kill-when-opening-new-dired-buffer t)

(use-package dired-hide-dotfiles
  :hook (dired-mode . dired-hide-dotfiles-mode)
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
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
    "jj" 'avy-goto-char
    "jl" 'avy-goto-line
    "jw" 'avy-goto-word-0)
  :hook (after-init . avy-setup-default)
  :init
  (setq avy-style 'pre))

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
   "h" 'multi-vterm-prev))


(provide 'init-app)
;;; init-app.el ends here
