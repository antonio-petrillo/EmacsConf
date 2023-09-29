;;; init-workspaces.el --- Description -*- lexical-binding: t; -*-
(use-package perspective
  :custom
  (persp-mode-prefix-key (kbd "C-c M-p"))
  :config
  (nto/leader-keys
	"<tab>" '(:ignore t :wk "perspective")
	"<tab> b" '(persp-switch-to-buffer :wk "switch to buffer")
	"<tab> <tab>" '(persp-switch :wk "switch to persp")
	"<tab> n" '(persp-switch :wk "new")
	"<tab> m" '(persp-merge :wk "merge")
	"<tab> f" '(persp-forget-buffer :wk "forget buffer")
	"<tab> r" '(persp-rename :wk "rename")
	"<tab> c" '(persp-kill :wk "close")
	"<tab> d" '(persp-kill :wk "close")
	"<tab> j" '(persp-next :wk "next")
	"<tab> k" '(persp-prev :wk "prev")
	"<tab> S" '(persp-state-save :wk "save")
	"<tab> l" '(persp-state-load :wk "load"))
  :init
  (persp-mode))

;; BEFRAME?

(provide 'init-workspaces)
;;; init-workspaces.el ends here
