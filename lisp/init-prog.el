(use-package tree-sitter
  :config
  (setq treesit-language-source-alist
   '((bash "https://github.com/tree-sitter/tree-sitter-bash")
     (cmake "https://github.com/uyha/tree-sitter-cmake")
     (css "https://github.com/tree-sitter/tree-sitter-css")
     (elisp "https://github.com/Wilfred/tree-sitter-elisp")
     (go "https://github.com/tree-sitter/tree-sitter-go")
	 (gleam "https://github.com/gleam-lang/tree-sitter-gleam")
     (html "https://github.com/tree-sitter/tree-sitter-html")
     (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
     (json "https://github.com/tree-sitter/tree-sitter-json")
     (make "https://github.com/alemuller/tree-sitter-make")
     (markdown "https://github.com/ikatyang/tree-sitter-markdown")
     (python "https://github.com/tree-sitter/tree-sitter-python")
     (toml "https://github.com/tree-sitter/tree-sitter-toml")
     (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
     (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
     (yaml "https://github.com/ikatyang/tree-sitter-yaml"))))

(use-package tree-sitter-langs)

(use-package tree-sitter-indent)

(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(use-package eglot)

(use-package go-mode)

(use-package zig-mode)

(use-package python-mode)

(use-package lua-mode)

(use-package lox-mode)

(use-package clojure-ts-mode)
(use-package clojure-mode)
(use-package cider)

(use-package elm-mode)

(add-to-list 'exec-path "~/.opam/default/bin")
(use-package tuareg)

(use-package dune)

(use-package merlin
  :config
  (add-hook 'tuareg-mode-hook #'merlin-mode))

(use-package merlin-eldoc
  :hook ((tuareg-mode) . merlin-eldoc-setup))

(use-package flycheck-ocaml
  :config
  (flycheck-ocaml-setup))

(use-package utop
  :config
  (add-hook 'tuareg-mode-hook #'utop-minor-mode))

(use-package ocamlformat)

(use-package gleam-mode
  :straight (gleam-mode :type git
						:host github
						:repo "gleam-lang/gleam-mode"
						:nonrecursive nil))

(use-package json-mode)
(use-package csv-mode)
(use-package yaml-mode)

(provide 'init-prog)
