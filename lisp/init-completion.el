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

(when (display-graphic-p)
  (use-package corfu
    :straight (corfu :files (:defaults "extensions/*")
                     :includes (corfu-popupinfo corfu-history))
    :custom
    (corfu-cycle t)
    (corfu-auto t)
    (corfu-scroll-margin 5)
	(corfu-quit-no-match 'separator)
    :bind
    (:map corfu-map
          ("C-j" . corfu-next)
          ("C-k" . corfu-previous)
          ("M-d" . corfu-popupinfo-toggle)
          ("TAB" . corfu-next)
          ([tab] . corfu-next)
          ("S-TAB" . corfu-previous)
          ([backtab] . corfu-previous))
    ;; :config
    ;; (setq corfu-auto t
    ;;       corfu-quit-no-match 'separator)
    :init
    (global-corfu-mode)
    (corfu-popupinfo-mode)))

(unless (display-graphic-p)
  (use-package corfu-terminal
    :when (eq system-type 'gnu/linux)
    :straight (corfu-terminal :type git
                              :repo "https://codeberg.org/akib/emacs-corfu-terminal.git")
    :custom
    (corfu-cycle t)
    (corfu-auto t)
    (corfu-scroll-margin 5)
    :bind
    (:map corfu-map
          ("C-j" . corfu-next)
          ("C-k" . corfu-previous)
          ("TAB" . corfu-next)
          ([tab] . corfu-next)
          ("S-TAB" . corfu-previous)
          ([backtab] . corfu-previous))
    :config
    (setq corfu-auto t
          corfu-quit-no-match 'separator)
    :init
    (corfu-terminal-mode +1)))

(unless (display-graphic-p)
  (use-package corfu-doc-terminal
	:after corfu-terminal
    :when (eq system-type 'gnu/linux)
    :straight (corfu-doc-terminal :type git
								  :repo "https://codeberg.org/akib/emacs-corfu-doc-terminal.git")
    :init
    (corfu-doc-terminal-mode +1)))

(use-package cape
  ;; Bind dedicated completion commands
  ;; Alternative prefix keys: C-c p, M-p, M-+, ...
  :after corfu
  :bind (("C-c c p" . completion-at-point) ;; capf
         ("C-c c t" . complete-tag)        ;; etags
         ("C-c c d" . cape-dabbrev)        ;; or dabbrev-completion
         ("C-c c h" . cape-history)
         ("C-c c f" . cape-file)
         ("C-c c k" . cape-keyword)
         ("C-c c s" . cape-elisp-symbol)
         ("C-c c e" . cape-elisp-block)
         ("C-c c a" . cape-abbrev)
         ("C-c c l" . cape-line)
         ("C-c c w" . cape-dict)
         ("C-c c :" . cape-emoji)
         ("C-c c \\" . cape-tex)
         ("C-c c _" . cape-tex)
         ("C-c c ^" . cape-tex)
         ("C-c c &" . cape-sgml)
         ("C-c c r" . cape-rfc1345))
  :init
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-elisp-block)
  ;;(add-to-list 'completion-at-point-functions #'cape-history)
  ;;(add-to-list 'completion-at-point-functions #'cape-keyword)
  ;;(add-to-list 'completion-at-point-functions #'cape-tex)
  ;;(add-to-list 'completion-at-point-functions #'cape-sgml)
  ;;(add-to-list 'completion-at-point-functions #'cape-rfc1345)
  ;;(add-to-list 'completion-at-point-functions #'cape-abbrev)
  (add-to-list 'completion-at-point-functions #'cape-dict)
  ;;(add-to-list 'completion-at-point-functions #'cape-elisp-symbol)
  ;;(add-to-list 'completion-at-point-functions #'cape-line)
)

(use-package nerd-icons-corfu
  :after corfu
  :init
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

(use-package yasnippet
  :init
  (setq yas-snippet-dirs `(,(concat user-emacs-directory "snippets")))
  (yas-global-mode 1))

(provide 'init-completion)
