;;; init-workspaces.el --- Description -*- lexical-binding: t; -*-
(use-package perspective
  :custom
  (persp-mode-prefix-key (kbd "C-c M-p"))
  :config
  (nto/leader-keys
	"<tab>" '(:ignore t :wk "perspective")
	"<tab> b" 'persp-switch-to-buffer
	"<tab> <tab>" 'persp-switch
	"<tab> n" 'persp-switch
	"<tab> m" 'persp-merge
	"<tab> f" 'persp-forget-buffer
	"<tab> r" 'persp-rename
	"<tab> c" 'persp-kill
	"<tab> j" 'persp-next
	"<tab> k" 'persp-prev
	"<tab> S" 'persp-state-save
	"<tab> l" 'persp-state-load)
  :init
  (persp-mode))

;; BEFRAME?

(provide 'init-workspaces)
;;; init-workspaces.el ends here
