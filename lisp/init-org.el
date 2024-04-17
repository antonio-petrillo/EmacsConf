;;; init-org.el --- Description -*- lexical-binding: t; -*-

(straight-use-package 'org)
(require 'org)

(setq org-export-with-toc t
	  org-export-headline-levels 3
	  org-refile-use-outline-path 'file
	  org-outline-path-complete-in-steps nil
	  org-refile-allow-creating-parent-nodes 'confirm)

(setq org-confirm-babel-evaluate nil
	  org-src-window-setup 'current-window
      org-edit-src-content-indentation 0)

(setq org-cite-global-bibliography `(,(expand-file-name "assets/bibliography.bib" org-directory)))

(setq org-startup-indented t
	  org-pretty-entities t
	  org-use-sub-superscripts "{}"
	  org-hide-emphasis-markers nil
	  org-startup-with-inline-images t
	  org-image-actual-width '(300))

(advice-add 'org-refile :after 'org-save-all-org-buffers)

(define-key org-mode-map (kbd "C-'") nil)
(define-key org-mode-map (kbd "C-,") nil)
(define-key org-mode-map (kbd "M-,") nil)
(define-key org-mode-map (kbd "M-;") nil)

(with-eval-after-load 'org
  (nto/local-leader
	:keymaps 'org-mode-map
	"k" '(outline-up-heading :wk "previous header")
	"j" '(outline-next-visible-heading :wk "next header")
    "t" '(org-todo :wk "cycle todo")
	"c" '(org-ctrl-c-minus :wk "cycle bullets or insert separator")
    "m" '(:ignore t :wk "move heading")
    "ml" '(org-meta-left :wk "demote")
    "mh" '(org-meta-right :wk "promote")
    "mj" '(org-meta-up :wk "move up")
    "mk" '(org-meta-down :wk "move down")))

(use-package org-modern
  :after org
  :init
  (add-hook 'org-mode-hook #'org-modern-mode))

(use-package org-appear
  :hook
  (org-mode . org-appear-mode))

(use-package citar
  :no-require
  :custom
  (org-cite-insert-processor 'citar)
  (org-cite-follow-processor 'citar)
  (org-cite-activate-processor 'citar)
  (citar-bibliography org-cite-global-bibliography)
  :hook
  (LaTex-mode . citar-capf-setup)
  (org-mode . citar-capf-setup)
  :bind
  (:map org-mode-map
		:package org
		("C-c b" . #'org-cite-insert)))

(use-package citar-embark
  :after citar embark
  :no-require
  :config
  (citar-embark-mode))

;; checkout denote silos (for work notes)
(use-package denote
  :after general
  :init
  (setq denote-infer-keywords t)
  (setq denote-sort-keywords t)
  (setq denote-directory (expand-file-name "notes" org-directory))
  (setq denote-prompts '(title keywords))
  (setq denote-file-type 'org)
  (setq denote-known-keywords '("emacs" "programming" "algorithm" "datastructure"
								"pattern" "math" "art" "music"
								"film" "book" "philosophy" "meta"
								"linux" "windows" "fitness"))
  (setq denote-journal-extras-title-format 'day-date-month-year)
  (setq denote-journal-extras-directory (expand-file-name "journal" denote-directory))

  (add-hook 'dired-mode-hook #'denote-dired-mode)
  (add-hook 'find-file-hook #'denote-link-buttonize-buffer)

  (nto/leader
	"n" '(:ignore t :wk "denote")
	"nf" '(denote-open-or-create :wk "find")
	"nd" '(list-denote :wk "dired")
	"nr" '(denote-rename-file :wk "rename")
	"ni" '(denote-link-or-create :wk "link")
	"nb" '(denote-backlink :wk "backlink")
	"nj" '(denote-journal-extras-new-entry :wk "journal")
;;	"dq" '(denote-org-dblock-insert-links :wk "query") need further reading on this feature
	))

(use-package denote-menu
  :after denote
  :config
  (define-key denote-menu-mode-map (kbd "c") #'denote-menu-clear-filters)
  (define-key denote-menu-mode-map (kbd "/ r") #'denote-menu-filter)
  (define-key denote-menu-mode-map (kbd "/ k") #'denote-menu-filter-by-keyword)
  (define-key denote-menu-mode-map (kbd "/ o") #'denote-menu-filter-out-keyword)
  (define-key denote-menu-mode-map (kbd "e") #'denote-menu-export-to-dired))

(use-package denote-explore
  :straight (denote-explore :type git
						:host github
						:repo "pprevos/denote-explore")
  :after denote
  :custom
  (denote-explore-network-directory (expand-file-name "network" denote-directory))
  (denote-explore-network-filename "denote-network")
  :init
  (nto/leader
	"nJ" '(:ignore t :wk "janitor")
	"nJd" '(denote-explore-identify-duplicate-notes :wk "duplicate")
	"nJz" '(denote-explore-zero-keywords :wk "zero keywords")
	"nJs" '(denote-explore-single-keywords :wk "single keywords")
	"nJS" '(denote-explore-sort-keywords :wk "sort keywords")
	"nJr" '(denote-explore-rename-keywords :wk "rename keywords")

	"ne" '(:ignore t :wk "explore")
	"nen" '(denote-explore-network :wk "network")
	"nei" '(denote-explore-isolated-notes :wk "isolated")
	"ner" '(denote-explore-network-regenerate :wk "regenerate")
	"neb" '(denote-explore-degree-barchart :wk "degree chart")

	"ns" '(:ignore t :wk "statistics")
	"nsc" '(denote-explore-count-notes :wk "count notes")
	"nsC" '(denote-explore-count-keywords :wk "keywords notes")
	"nsb" '(denote-explore-keywords-barchart :wk "keywords chart")
	"nsx" '(denote-explore-extensions-barchart :wk "extensions chart")
	"nsB" '(denote-explore-degree-barchart :wk "degree chart")

	"nw" '(:ignore t  :wk "walk")
	"nwr" '(denote-explore-random-note :wk "note")
	"nwr" '(denote-explore-random-link :wk "link")
	"nwr" '(denote-explore-random-keyword :wk "keyword")))

(provide 'init-org)
