;;; init-completion.el --- Description -*- lexical-binding: t; -*-
(use-package marginalia
  :after vertico
  :init
  (setq marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  (marginalia-mode)
  (with-eval-after-load 'projectile
    (add-to-list 'marginalia-command-categories '(projectile-find-file . file))))

(use-package vertico
  :straight (vertico :files (:defaults "extensions/*")
                     :includes (vertico-indexed
                                vertico-flat
                                vertico-grid
                                vertico-mouse
                                ;; vertico-quick
                                vertico-buffer
                                vertico-repeat
                                vertico-reverse
                                vertico-directory
                                vertico-multiform
                                vertico-unobtrusive))
  :demand
  :hook
  ((minibuffer-setup . vertico-repeat-save)
   (rfn-eshadow-update-overlay . vertico-directory-tidy))
  :general
  (:keymaps 'vertico-map
            "C-j" #'vertico-next
            "C-k" #'vertico-previous
            "<escape>" #'minibuffer-keyboard-quit
            "M-<backspace>" #'vertico-directory-delete-word)
  :init
  (setq vertico-grid-separator "       ")
  (setq vertico-grid-lookahead 50)
  (setq vertico-buffer-display-action '(display-buffer-reuse-window))
  (setq vertico-multiform-categories
        '((file indexed)
          (consult-grep buffer)
          (consult-location)
          (imenu buffer)
          (library reverse indexed)
          (org-roam-node reverse indexed)
          (t reverse)))
  (setq vertico-multiform-commands
        '(("flyspell-correct-*" grid reverse)
          (org-refile grid reverse indexed)
          (consult-yank-pop indexed)
          (consult-flycheck)
          (consult-lsp-diagnostics)))
  :config
  (vertico-mode))

(use-package ace-window
  :general
  (nto/leader-keys
    "ww" '(ace-window :wk "ace window")))

(use-package orderless
  :init
  (setq completion-styles '(orderless)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

(use-package dired
  :straight (:type built-in)
  :hook
  (dired-mode . dired-hide-details-mode)
  :general
  (nto/leader-keys
    "fd" 'dired
    "." 'dired-jump
    "fj" 'dired-jump)
  (dired-mode-map
    :states 'normal
		"h" 'dired-up-directory)
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
    "jj" 'avy-goto-char-2
    "jl" 'avy-goto-line
    "jw" 'avy-goto-word-0)
  :hook (after-init . avy-setup-default)
  :init
  (setq avy-style 'pre))

(provide 'init-completion)
;;; init-completion.el ends here
