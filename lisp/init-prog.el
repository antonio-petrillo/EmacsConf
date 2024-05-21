(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(use-package go-mode
  :config
  (add-hook 'go-mode-hook 'lsp-deferred))

(use-package zig-mode)

(use-package python-mode)

(use-package lua-mode)

(use-package lox-mode)

(use-package elm-mode)

(provide 'init-prog)
