(use-package dired
  :straight (:type built-in)
  :after evil
  :general
  (nto/leader
	"fd" '(dired-jump :wk "find file"))
  :config
  (evil-define-key '(normal insert) dired-mode-map
	"h" 'dired-up-directory
	"l" 'dired-find-file
	"m" 'dired-mark
	"u" 'dired-unmark
	"t" 'dired-toggle-marks
	"C" 'dired-do-copy
	"D" 'dired-do-delete
	"J" 'dired-goto-file
	"M" 'dired-do-chmod
	"O" 'dired-do-chown
	"R" 'dired-do-rename
	"T" 'dired-do-touch
	"Y" 'dired-copy-filename-as-kill
	"+" 'dired-create-directory
	"-" 'dired-up-directory
	(kbd "<return>") 'dired-find-file
	(kbd "% l") 'dired-downcase
	(kbd "% u") 'dired-upcase
	(kbd "; d") 'epa-dired-do-decrypt
	(kbd "; e") 'epa-dired-do-encrypt)
  :init
  (setq delete-by-moving-to-trash t)
  (setq dired-listing-switches "-lah")
  (setq dired-dwim-target t)
  (setf dired-kill-when-opening-new-dired-buffer t))

(use-package dired-hide-dotfiles
  :after dired
  :hook (dired-mode . dired-hide-dotfiles-mode)
  :config
  (evil-define-key 'normal dired-mode-map
    "H" 'dired-hide-dotfiles-mode))

(use-package all-the-icons-dired
  :when (display-graphic-p)
  :defer t
  :hook (dired-mode .all-the-icons-dired-mode))

(use-package trashed
  :init
  (nto/local-leader :keymaps 'trashed-mode-map
	"r" '(trashed-do-restore :wk "restore")
	"d" '(trashed-do-delete :wk "delete")))

(provide 'init-dired)
