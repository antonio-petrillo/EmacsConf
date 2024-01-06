(use-package tab-bar
  :after general
  :config
  (setq tab-bar-button-relief 5)
  (nto/leader
	"<tab>" '(:ignore t :wk "workspaces")
	"<tab> <tab>" '(tab-switch :wk "switch")
	"<tab> n" '(tab-new :wk "new")
	"<tab> b" '(switch-to-buffer-other-tab :wk "buffer")
	"<tab> d" '(dired-other-tab :wk "dired")
	"<tab> f" '(find-file-other-tab :wk "find file")
	"<tab> c" '(tab-close :wk "close")
	"<tab> r" '(tab-rename :wk "rename")
	"<tab> u" '(tab-undo :wk "undo")
	"<tab> j" '(tab-next :wk "next")
	"<tab> k" '(tab-previous :wk "prev")))

(provide 'init-workspaces)
