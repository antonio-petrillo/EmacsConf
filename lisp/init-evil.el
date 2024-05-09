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
  (setq evil-want-C-u-scroll nil)
  (setq evil-want-C-i-jump nil)
  (setq evil-want-Y-yank-to-eol t)
  (setq evil-undo-system 'undo-fu)
  (setq evil-search-module 'evil-search)
  (setq evil-split-window-below nil)
  (setq evil-vsplit-window-right nil)
  (setq evil-auto-indent nil)
  (setq undo-limit (* 80 (* 1024 1024))) ;; 80 Mb see, https://tecosaur.github.io/emacs-config/config.html#better-defaults
  (setq evil-want-fine-undo t)
  (evil-mode 1)
  :config
  (setq evil-overriding-maps nil)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-a") 'beginning-of-line)
  (define-key evil-insert-state-map (kbd "C-e") 'end-of-line)
  (define-key evil-insert-state-map (kbd "C-n") 'next-line)
  (define-key evil-insert-state-map (kbd "C-p") 'previous-line)
  (define-key evil-insert-state-map (kbd "C-d") 'delete-char)
  (define-key evil-normal-state-map (kbd "C-a") 'beginning-of-line)
  (define-key evil-normal-state-map (kbd "C-e") 'end-of-line)
  (define-key evil-normal-state-map (kbd "C-n") 'next-line)
  (define-key evil-normal-state-map (kbd "C-p") 'previous-line)
  (define-key evil-normal-state-map (kbd "C-f") 'forward-char)
  (define-key evil-normal-state-map (kbd "C-b") 'backward-char)
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
	"A" '(:ignore t :wk "Apps")
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
  (evil-collection-init)
  :config
  (evil-collection-unimpaired-mode -1)
  (global-evil-collection-unimpaired-mode -1))

(use-package evil-snipe
  :after evil
  :init
  (evil-snipe-mode +1)
  (evil-define-key '(normal motion) evil-snipe-local-mode-map
	"s" 'evil-snipe-s
	"S" 'evil-snipe-S
	"f" 'evil-snipe-f
	"F" 'evil-snipe-F)

  ;; (evil-define-key 'operator evil-snipe-local-mode-map
  ;; 	"z" 'evil-snipe-s
  ;; 	"Z" 'evil-snipe-S
  ;; 	"x" 'evil-snipe-x
  ;; 	"X" 'evil-snipe-X)

  (evil-define-key 'motion evil-snipe-override-local-mode-map
	"f" 'evil-snipe-f
	"F" 'evil-snipe-F
	;; "t" 'evil-snipe-t
	;; "T" 'evil-snipe-T
	)

  (when evil-snipe-override-evil-repeat-keys
	(evil-define-key 'motion map
      ";" 'evil-snipe-repeat
      "," 'evil-snipe-repeat-reverse))

  :config
  (setq evil-snipe-scope 'buffer))

(use-package evil-escape
  :after evil
  :init
  (evil-escape-mode 1)
  :config
  (setq-default evil-escape-delay 0.2)
  (setq-default evil-escape-key-sequence "jk")
  (setq-default evil-escape-unordered-key-sequence nil))

(use-package evil-lion
  :after evil
  :init
  (evil-lion-mode))

(use-package evil-visualstar
  :after evil
  :init
  (global-evil-visualstar-mode))

(use-package evil-matchit
  :after evil
  :init
  (global-evil-matchit-mode 1)
  (setq evilmi-may-jump-by-percentage nil))

(use-package exato
  :after evil
  :init
  (require 'exato)) ;; autoloads don't work properly

(use-package evil-args
  :after evil
  :config
  (setq evil-args-delimiters '(" " "," ";"))
  :init
  (define-key evil-inner-text-objects-map "a" 'evil-inner-arg)
  (define-key evil-outer-text-objects-map "a" 'evil-inner-arg)
  ;; evil-snipe-f is better thatn this
  ;; (define-key evil-normal-state-map "L" 'evil-forward-arg)
  ;; (define-key evil-normal-state-map "H" 'evil-backward-arg)
  ;; (define-key evil-motion-state-map "L" 'evil-forward-arg)
  ;; (define-key evil-motion-state-map "H" 'evil-backward-arg)
  ;; (define-key evil-normal-state-map "K" 'evil-jump-out-args)
  )

(defmacro nto/build-url (url &rest params)
  `(format ,url ,@params))

(defun nto/web-search ()
  (interactive)
  (let ((base-url "https://google.com/search?q=%s")
		(param (if (region-active-p)
				   (buffer-substring-no-properties (region-beginning) (region-end))
				 (read-from-minibuffer "Search: "))))
	(browse-url (nto/build-url base-url param))))

(with-eval-after-load 'evil
  (evil-define-key 'visual 'global
	(kbd "gs") #'nto/web-search)

  (evil-define-key 'normal 'global
	(kbd "gs") #'nto/web-search))

(use-package evil-exchange
  :after evil
  :init
  (setq evil-exchange-key (kbd "zx"))
  (setq evil-exchange-cancel-key (kbd "zX"))
  (evil-exchange-install))

(use-package evil-commentary
  :after evil
  :init
  (evil-commentary-mode))

(use-package evil-numbers
  :after evil
  :init
  (evil-define-key '(normal visual) 'global (kbd "+") 'evil-numbers/inc-at-pt)
  (evil-define-key '(normal visual) 'global (kbd "_") 'evil-numbers/dec-at-pt)
  (evil-define-key '(normal visual) 'global (kbd "C-+") 'evil-numbers/inc-at-pt-incremental)
  (evil-define-key '(normal visual) 'global (kbd "C-_") 'evil-numbers/dec-at-pt-incremental))

(provide 'init-evil)
