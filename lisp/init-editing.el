(add-hook 'prog-mode-hook 'subword-mode)
(add-hook 'org-mode-hook 'subword-mode)

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

(use-package emacs
  :after general
  :init
  (nto/leader
	"tl" '(display-line-numbers-mode :wk "line numbers"))
  (setq display-line-numbers-type 'relative)
  (setq tab-always-indent 'complete)
  (setq-default indent-tabs-mode t)
  (setq-default tab-width 4))

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
   "s-z" 'undo-fu-only-undo
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
  (nto/local-leader 'prog-mode-map
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
	"jl" '(avy-goto-line :wk "line")
	"jw" '(avy-goto-word :wk "word")))

(defun nto/goto-match-paren (arg)
  "Go to the matching parenthesis if on parenthesis. Else go to the
   opening parenthesis one level up."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1))
        (t
         (backward-char 1)
         (cond ((looking-at "\\s\)")
                (forward-char 1) (backward-list 1))
               (t
                (while (not (looking-at "\\s("))
                  (backward-char 1)
                  (cond ((looking-at "\\s\)")
                         (message "->> )")
                         (forward-char 1)
                         (backward-list 1)
                         (backward-char 1)))))))))

(use-package emacs
  :after general
  :init
  (nto/leader
	"js" '(nto/goto-match-paren :wk "start of sexp")))

(use-package rotate-text
  :after general
  :config
  (add-to-list 'rotate-text-words '("len" "length" "size"))
  (add-to-list 'rotate-text-words '("int" "long"))
  (add-to-list 'rotate-text-words '("u8" "u16" "u32" "u64" "u128"))
  (add-to-list 'rotate-text-words '("f16" "f32" "f64" "f128"))
  (add-to-list 'rotate-text-words '("i8" "i16" "i32" "i64" "i128"))
  (add-to-list 'rotate-text-words '("float" "double"))
  (add-to-list 'rotate-text-words '("char" "char*"))
  (add-to-list 'rotate-text-words '("true" "false"))
  (add-to-list 'rotate-text-words '("def" "defn" "fn"))
  (add-to-list 'rotate-text-words '("True" "False"))
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
