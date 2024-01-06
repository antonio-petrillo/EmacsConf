(use-package emacs
  :after general
  :init
  (nto/leader
	"b" '(:ignore t :which-key "buffer")
	"br"  '(revert-buffer :wk "revert")
	"bk"  '(kill-current-buffer :wk "kill")
	"bb"  '(consult-buffer :wk "switch")
	"bi"  '(ibuffer :wk "ibuffer")

	"f"  '(:ignore t :which-key "file")
	"ff" '(find-file :wk "find")
	"fg" '(consult-ripgrep :wk "ripgrep")
	"fF" '(consult-fd :wk "fd find")
	"."  '(find-file :wk "find")
	"fs" '(save-buffer :wk "save")
	"fr" '(consult-recent-file :wk "recent")))

(provide 'init-buffer)
