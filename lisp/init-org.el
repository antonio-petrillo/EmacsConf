;;; init-org.el --- Description -*- lexical-binding: t; -*-

(straight-use-package 'org)
(require 'org)

(setq org-export-with-toc t
	  org-export-headline-levels 3
	  org-refile-use-outline-path 'file
	  org-outline-path-complete-in-steps nil
	  org-refile-allow-creating-parent-nodes 'confirm)

(setq org-confirm-babel-evaluate nil
	  org-src-window-setup 'current-window
      org-edit-src-content-indentation 0)

(advice-add 'org-refile :after 'org-save-all-org-buffers)

(define-key org-mode-map (kbd "C-'") nil)
(define-key org-mode-map (kbd "C-,") nil)
(define-key org-mode-map (kbd "M-,") nil)
(define-key org-mode-map (kbd "M-;") nil)

(with-eval-after-load 'org
  (nto/local-leader
	:keymaps 'org-mode-map
	"k" '(outline-up-heading :wk "previous header")
	"j" '(outline-next-visible-heading :wk "next header")
    "t" '(org-todo :wk "cycle todo")
	"c" '(org-ctrl-c-minus :wk "cycle bullets or insert separator")
    "m" '(:ignore t :wk "move heading")
    "ml" '(org-meta-left :wk "demote")
    "mh" '(org-meta-right :wk "promote")
    "mj" '(org-meta-up :wk "move up")
    "mk" '(org-meta-down :wk "move down")))

(use-package org-modern
  :after org
  :init
  (add-hook 'org-mode-hook #'org-modern-mode))

(defun nto/org-roam-node-has-any-tags-p (node tags)
  "Predicate that return `t' if node has at least one of `tags', `nil' otherwise"
  (seq-intersection (org-roam-node-tags node) tags))

(defun nto/org-roam-node-filter-by-tags-any ()
  "Find and open an Org-roam node if it has any of the specified tags."
  (interactive)
  (let ((tags (completing-read-multiple "select tags: " (org-roam-tag-completions))))
    (org-roam-node-find nil nil (lambda (node) (nto/org-roam-node-has-any-tags-p node tags)))))

(defun nto/org-roam-node-has-all-tags-p (node tags)
  "Predicate that return `t' if node has all the `tags', `nil' otherwise"
  (not (seq-difference tags (org-roam-node-tags node))))

(defun nto/org-roam-node-filter-by-tags-all ()
  "Find and open an Org-roam node if it has all the specified tags."
  (interactive)
  (let ((tags (sort (completing-read-multiple "select tags: " (org-roam-tag-completions)) #'string-lessp)))
    (org-roam-node-find nil nil (lambda (node) (nto/org-roam-node-has-all-tags-p node tags)))))

(use-package org-roam
  :when (and (boundp 'org-directory) org-directory)
  :after general
  :init
  (setq org-roam-v2-ack t
		org-roam-completion-everywhere nil)
  (org-roam-db-autosync-mode)
  (nto/leader
	"n" '(:ignore t :wk "notes")
	"nI" '(org-id-get-create :wk "gen ID")
	"na" '(:ignore t :wk "alias")
	"naa" '(org-roam-alias-add :wk "add")
	"nar" '(org-roam-alias-remove :wk "remove")
	"nt" '(:ignore t :wk "tag")
	"nta" '(org-roam-tag-add :wk "add")
	"ntr" '(org-roam-tag-remove :wk "remove")
	"nr" '(:ignore t :wk "refs")
	"ns" '(:ignore t :wk "filter by tags")
	"nsa" '(nto/org-roam-node-filter-by-tags-any :wk "any tags")
	"nsA" '(nto/org-roam-node-filter-by-tags-all :wk "all tags")
	"nd" '(:ignore t :wk "date")
	"ndt" '(org-roam-dailies-goto-today :wk "today")
	"ndT" '(org-roam-dailies-goto-tomorrow :wk "tomorrow")
	"ndy" '(org-roam-dailies-goto-yesterday :wk "yesterday")
	"ndp" '(org-roam-dailies-goto-previous-note :wk "previous")
	"ndn" '(org-roam-dailies-goto-next-note :wk "next")
	"ndc" '(org-roam-dailies-goto-date :wk "calendar")
	"ndd" '(org-roam-dailies-find-directory :wk "dired")
	"nra" '(org-roam-ref-add :wk "add")
	"nrr" '(org-roam-ref-remove :wk "remove")
	"ni" '(org-roam-node-insert :wk "link")
	"nb" '(org-roam-buffer-toggle :wk "toggle buffer")
	"nf" '(org-roam-node-find :wk "new node"))
  :custom
  (org-roam-directory (expand-file-name "roam" org-directory))
  (org-roam-db-location (expand-file-name "db/org-roam.db" org-directory))
  (org-roam-dailies-directory "daily/")
  :config
  (org-roam-setup))

(use-package org-roam-ui
  :after org-roam
  :init
  (setq org-roam-ui-sync-theme t
		org-roam-ui-follow t
		org-roam-ui-update-on-save t
		ort-roam-ui-open-on-start nil))

(use-package consult-org-roam
  :after org-roam
  :diminish consult-org-roam-mode
  :init
  (require 'consult-org-roam)
  (consult-org-roam-mode 1)
  (nto/leader
	"nc" '(:ignore t :wk "consult")
	"ncf" '(consult-org-roam-file-find :wk "find")
	"ncb" '(consult-org-roam-backlinks :wk "backlinks")
	"ncl" '(consult-org-roam-forward-links :wk "forward links")
	"ncs" '(consult-org-roam-search :wk "search"))
  :custom
  (consult-org-roam-grep-func #'consult-ripgrep)
  (consult-org-roam-buffer-after-buffers t))

(provide 'init-org)
