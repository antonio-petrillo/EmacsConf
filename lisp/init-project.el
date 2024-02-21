(use-package projectile
  :defer t
  :config
  (setq projectile-sort-order 'recently-active)
  :init
  (nto/leader
	"pf" '(projectile-find-file :wk "find")
	"pF" '(projectile-find-file-in-known-projects :wk "find all")
	"pd" '(projectile-dired :wk "dired")
    "pg" '(projectile-grep :wk "grep")
    "pr" '(projectile-ripgrep :wk "ripgrep")
	"p?" '(projectile-find-references :wk "reference")
    "ph" '(projectile-find-other-file :wk "interface <-> impl")
	"pp" '(projectile-switch-project :wk "switch")
    "pt" '(projectile-test-project :wk "run test")
    "pc" '(projectile-compile-project :wk "compile")
    "p&" '(projectile-run-async-shell-command-in-root :wk "run command"))
  (projectile-mode +1)
  :bind-keymap
  ("C-c p" . projectile-command-map))

(use-package github-browse-file
  :defer t
  :init
  (nto/leader
	"pG" '(github-browse-file :wk "see on Gh")
	"pB" '(github-browse-file-blame :wk "blame on Gh")))

(use-package diff-hl
  :init
  (global-diff-hl-mode))

(use-package hl-todo
  :after general
  :init
  (global-hl-todo-mode 1)
  (nto/leader
	"tt" '(:ignore t :wk "todos")
	"ttt" '(global-hl-todo-mode :wk "toggle")
	"ttp" '(hl-todo-previous :wk "previous")
	"ttn" '(hl-todo-next :wk "next")
	"tto" '(hl-todo-occur :wk "occur")
	"tti" '(hl-todo-insert :wk "insert")))

(use-package consult-todo
  :after general
  :init
  (nto/leader
	"ft" '(consult-todo-all :wk "consult todo")))

(provide 'init-project)
