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

(provide 'init-magit)
