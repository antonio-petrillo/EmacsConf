;;; init-notes.el --- Description -*- lexical-binding: t; -*-

;; (use-package org-ref)

;; (use-package org-cite)

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
	"dra" '(org-roam-ref-add :wk "add")
	"drr" '(org-roam-ref-remove :wk "remove")
	"di" '(org-roam-node-insert :wk "link")
	"db" '(org-roam-buffer-toggle :wk "toggle buffer")
	"df" '(org-roam-node-find :wk "new node"))
  :custom
  (org-roam-directory (expand-file-name "roam" org-directory))
  (org-roam-db-location (expand-file-name "db/org-roam.db" org-directory))
  :config
  (org-roam-setup))

(use-package org-roam-ui
  :after org-roam
  :config
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
  (nto/leader-keys
	"dc" '(:ignore t :wk "consult")
	"dcf" '(consult-org-roam-file-find :wk "find")
	"dcb" '(consult-org-roam-backlinks :wk "backlinks")
	"dcl" '(consult-org-roam-forward-links :wk "forward links")
	"dcs" '(consult-org-roam-search :wk "search"))
  :custom
  (consult-org-roam-grep-func #'consult-ripgrep)
  (consult-org-roam-buffer-after-buffers t))

(provide 'init-notes)
;;; init-notes.el ends here
