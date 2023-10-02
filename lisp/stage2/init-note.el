;;; init-note.el --- Description -*- lexical-binding: t; -*-
(use-package denote)
(use-package denote-menu
  :init
  (require 'denote-org-dblock)

  (setq denote-directory (expand-file-name "notes" org-directory))
  (setq denote-prompts '(title keywords))
  (setq denote-file-type 'org)
  (setq denote-known-keywords '("journals" "tirocinio" "clojure" "java" "project"
								"ideas" "emacs" "cli" "book" "health" "pattern"
								"architecture" "art" "math" "master" "philosophy"
								"security" "music" "films" "series"))

  (add-hook 'dired-mode-hook #'denote-dired-mode)
  (add-hook 'find-file-hook #'denote-link-buttonize-buffer)

  (defun nto/dired-denote ()
	(interactive)
	(dired denote-directory))

  (nto/leader-keys
	"d" '(:ignore t :wk "denotes")
	"df" '(denote :wk "new note")
	"dm" '(list-denote :wk "list")
	"dd" '(nto/dired-denote :wk "dired")
	"dD" '(denote-date :wk "date")
	"dr" '(denote-dired-rename-file :wk "rename front matter")
	"dR" '(denote-dired-rename-file :wk "rename front matter")
	"di" '(denote-link-or-create :wk "insert or create")
	"dl" '(denote-find-link :wk "link")
	"db" '(denote-find-backlink :wk "backlink")
	"dq" '(denote-org-dblock-insert-links :wk "query")))

(provide 'init-note)
;;; init-note.el ends here
