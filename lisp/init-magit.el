(use-package magit
  :after general
  :defer t
  :init
  (nto/leader
	"gg" '(magit-status :wk "status")))

(use-package forge
  :after magit
  :defer t)

(use-package magit-todos
  :after magit
  :config
  (magit-todos-mode 1))

(use-package smerge
  :straight (:type built-in)
  :after magit
  :init
  (nto/local-leader
	:keymaps 'smerge-mode-map
	"j" '(smerge-keep-lower :wk "keep lower")
	"k" '(smerge-keep-upper :wk "keep upper")
	"n" '(smerge-next :wk "next")
	"p" '(smerge-prev :wk "previous")
	"r" '(smerge-resolve :wk "resolve")))

(provide 'init-magit)
