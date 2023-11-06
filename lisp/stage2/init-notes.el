;;; init-notes.el --- Description -*- lexical-binding: t; -*-

;; (use-package org-ref)

;; (use-package org-cite)


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
  :init
  (setq org-roam-v2-ack t
	org-roam-completion-everywhere nil)
  (org-roam-db-autosync-mode)
  (nto/leader-keys
   "d" '(:ignore t :wk "notes")
   "dI" '(org-id-get-create :wk "gen ID")
   "da" '(:ignore t :wk "alias")
   "daa" '(org-roam-alias-add :wk "add")
   "dar" '(org-roam-alias-remove :wk "remove")
   "dt" '(:ignore t :wk "tag")
   "dta" '(org-roam-tag-add :wk "add")
   "dtr" '(org-roam-tag-remove :wk "remove")
   "dr" '(:ignore t :wk "refs")
   "d/" '(:ignore t :wk "filter by tags")
   "d/a" '(nto/org-roam-node-filter-by-tags-any :wk "any tags")
   "d/A" '(nto/org-roam-node-filter-by-tags-all :wk "all tags")
   "dD" '(:ignore t :wk "date")
   "dDt" '(org-roam-dailies-goto-today :wk "today")
   "dDT" '(org-roam-dailies-goto-tomorrow :wk "tomorrow")
   "dDy" '(org-roam-dailies-goto-yesterday :wk "yesterday")
   "dDp" '(org-roam-dailies-goto-previous-note :wk "previous")
   "dDn" '(org-roam-dailies-goto-next-note :wk "next")
   "dDc" '(org-roam-dailies-goto-date :wk "calendar")
   "dDd" '(org-roam-dailies-find-directory :wk "dired")
   "dra" '(org-roam-ref-add :wk "add")
   "drr" '(org-roam-ref-remove :wk "remove")
   "di" '(org-roam-node-insert :wk "link")
   "db" '(org-roam-buffer-toggle :wk "toggle buffer")
   "df" '(org-roam-node-find :wk "new node"))
  :custom
  (org-roam-directory (expand-file-name "roam" org-directory))
  (org-roam-db-location (expand-file-name "db/org-roam.db" org-directory))
  (org-roam-dailies-directory "daily/")
  :config
  (org-roam-setup))

(use-package org-roam-ui
  :after org-roam
  :config
  (setq org-roam-ui-sync-theme t
	org-roam-ui-follow t
	org-roam-ui-update-on-save t
	ort-roam-ui-open-on-start nil))

;; TODO: replace "d" with "n"
(use-package consult-org-roam
  :after org-roam
  :diminish consult-org-roam-mode
  :init
  (require 'consult-org-roam)
  (consult-org-roam-mode 1)
  (nto/leader-keys
   "dc" '(:ignore t :wk "consult")
   "dcf" '(consult-org-roam-file-find :wk "find")
   "dcb" '(consult-org-roam-backlinks :wk "backlinks")
   "dcl" '(consult-org-roam-forward-links :wk "forward links")
   "dcs" '(consult-org-roam-search :wk "search"))
  :custom
  (consult-org-roam-grep-func #'consult-ripgrep)
  (consult-org-roam-buffer-after-buffers t))

(use-package deft
  :init
  (setq deft-directory (expand-file-name "deft" org-directory)
        deft-extensions '("org" "txt" "tex" "md")
        deft-recursive t)
  (nto/leader-keys
   "dT" '(:ignore t :wk "temp (deft)")
   "dTf" '(deft :wk "deft ui")
   "dTn" '(deft-new-file-named :wk "new")
   "dTs" '(deft-find-file :wk "search")
   "dTd" '(deft-delete-file :wk "delete")))

(provide 'init-notes)
;;; init-notes.el ends here
