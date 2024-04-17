(add-hook 'prog-mode-hook 'subword-mode)
(add-hook 'org-mode-hook 'subword-mode)

(setq whitespace-line-column nil
      whitespace-style
      '(face indentation tabs tab-mark spaces space-mark newline newline-mark
        trailing lines-tail)
      whitespace-display-mappings
      '((tab-mark ?\t [?� ?\t])
        (newline-mark ?\n [?� ?\n])
        (space-mark ?\  [?�] [?.])))

(defun nto/backward-kill-word()
  "Same as `backward-kill-word' but if it is invoked on a white space character
at the beginning of the line it will stop at it, furthermore if it is invoked
on the beginning of the line it will go the end of the previous line instead
of delete the previous word."
  (interactive)
  (let ((same? (save-excursion
				 (let ((orig (line-number-at-pos (point)))
					   (dest (progn
							   (backward-word)
							   (line-number-at-pos (point)))))
				   (eq orig dest))))
		(start? (eq (point) (line-beginning-position))))
	(cond (start? (backward-delete-char 1))
		  (same? (backward-kill-word 1))
		  (:else (kill-line 0)))))

(global-set-key (kbd "C-<backspace>") 'nto/backward-kill-word)

(show-paren-mode t)

(electric-pair-mode 1)
(push '(?{ . ?}) electric-pair-pairs)

(setq-default display-line-numbers-width 3)
(use-package emacs
  :after general
  :init
  (nto/leader
	"tl" '(display-line-numbers-mode :wk "line numbers"))
  (setq display-line-numbers-type 'relative)
  (setq tab-always-indent 'complete)
  (setq-default indent-tabs-mode t)
  (setq-default tab-width 4))

(use-package ws-butler
  :init
  (ws-butler-global-mode 1)
  :config
  (setq ws-butler-keep-whitespace-before-point nil))

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

(use-package evil-commentary
  :after evil
  :config (evil-commentary-mode +1))

(use-package evil-surround
  :after general
  :general
  (:states 'operator
		   "s" 'evil-surround-edit
		   "S" 'evil-Surround-edit)
  (:states 'visual
		   "S" 'evil-surround-region
		   "gS" 'evil-Surround-region))

(use-package undo-fu
  :after evil
  :init
  (general-define-key
   :states 'normal
   "u" 'undo-fu-only-undo
   "\C-r" 'undo-fu-only-redo))

(use-package undo-fu-session
  :after undo-fu
  :demand
  :init
  (setq undo-fu-session-incompatible-files
		'("/COMMIT_EDITMSG\\'"
		  "/git-rebase-todo\\'"))
  :config
  (global-undo-fu-session-mode))

(use-package string-inflection
  :after evil
  :init
  (nto/local-leader
	:keymaps 'prog-mode-map
	"i" '(string-inflection-all-cycle :wk "inflection (all)")
	"k" '(string-inflection-kebab-case :wk "inflection (lisp)")
	"j" '(string-inflection-java-style-cycle :wk "inflection (java)")
	"_" '(string-inflection-underscore :wk "inflection (c)")
	"u" '(string-inflection-upcase :wk "inflection (upcase)")))

(use-package emacs
  :hook (prog-mode . hs-minor-mode)
  :init
  (add-hook 'prog-mode-hook 'display-line-numbers-mode)
  (evil-define-key 'normal 'global
	(kbd "za") 'hs-toggle-hiding
	(kbd "zc") 'hs-hide-block
	(kbd "zo") 'hs-show-block))

(use-package avy
  :after general
  :hook (after-init . avy-setup-default)
  :init (setq avy-style 'pre)
  (nto/leader
	"jj" '(avy-goto-char-timer :wk "char")
	"je" '(avy-goto-end-of-line :wk "end line")
	"jp" '(avy-goto-line-above :wk "above line")
	"jn" '(avy-goto-line-below :wk "below line")
	"jl" '(avy-goto-line :wk "line")
	"jw" '(:ignore t :wk "word")
	"jwp" '(avy-goto-word-0-above :wk "prev")
	"jwn" '(avy-goto-word-0-below :wk "next")))

(use-package darkroom
  :init
  (nto/leader
	"tz" '(darkroom-tentative-mode :wk "zen")))

(use-package rotate-text
  :after general
  :config
  (add-to-list 'rotate-text-words '("len" "length" "size"))
  (add-to-list 'rotate-text-words '("int" "long"))
  (add-to-list 'rotate-text-words '("float" "double"))
  (add-to-list 'rotate-text-words '("char" "char*"))
  (add-to-list 'rotate-text-words '("true" "false"))
  (add-to-list 'rotate-text-words '("def" "defn" "fn" "defun"))
  (add-to-list 'rotate-text-words '("fun" "func" "function"))
  (add-to-list 'rotate-text-words '("True" "False"))
  (add-to-list 'rotate-text-words '("true" "false"))
  (add-to-list 'rotate-text-words '("t" "nil"))
  :init
  (global-set-key (kbd "M-r") 'rotate-text)
  (global-set-key (kbd "M-R") 'rotate-text-backward)
  (nto/leader
	"rt" '(rotate-text :wk "text")
	"rT" '(rotate-text-backward :wk "text")))

(use-package apheleia
  :init
  (apheleia-global-mode +1))

(provide 'init-editing)
