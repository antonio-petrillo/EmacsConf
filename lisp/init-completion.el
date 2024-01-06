(use-package vertico
  :demand t
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
  :custom
  (vertico-cycle t)
  :config
  (vertico-mode 1))

(use-package vertico-mouse
  :after vertico
  :straight nil
  :load-path "straight/repos/vertico/extensions/"
  :init
  (vertico-mouse-mode))

(use-package marginalia
  :after vertico
  :init
  (setq marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  (marginalia-mode)
  (with-eval-after-load 'projectile
    (add-to-list 'marginalia-command-categories '(projectile-find-file . file))))

(use-package orderless
  :init
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles . (partial-completion))))))

(use-package company
  :init
  (add-hook 'after-init-hook 'global-company-mode)
  :config
  (define-key company-active-map (kbd "C-j") 'company-select-next)
  (define-key company-active-map (kbd "C-k") 'company-select-previous))

(use-package yasnippet
  :init
  (yas-global-mode 1)
  :config
  (setq yas-snippet-dirs `(,(concat user-emacs-directory "snippets"))))

(provide 'init-completion)
