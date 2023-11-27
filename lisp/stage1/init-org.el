;;; init-org.el --- Description -*- lexical-binding: t; -*-

(use-package org-fragtog
  :init
  (add-hook 'org-mode-hook 'org-fragtog-mode))

;; org gtd
(setq inbox (concat org-directory "/agenda/inbox.org")     ;; gtd inbox
	  someday (concat org-directory "/agenda/someday.org") ;; store info about potential task, todo and projects
	  backlog (concat org-directory "/agenda/backlog.org") ;; not properly gtd but I want to keep track of which `milestone' or `target' I've reached
	  agenda (concat org-directory "/agenda/agenda.org") ;; act as calendar
	  projects (concat org-directory "/agenda/projects.org")) ;; projects management

(setq org-agenda-files (list inbox someday agenda projects))

(defun nto/gtd-jump ()
  "Jump to the gtd directory from anywhere"
  (interactive)
  (find-file (concat org-directory "/agenda")))

(define-key global-map (kbd "C-c c") 'org-capture)
(define-key global-map (kbd "C-c a") 'org-agenda)
(define-key global-map (kbd "C-c j") #'nto/gtd-jump)

(setq org-capture-templates
	  `(("i" "Inbox" entry  (file ,inbox)
		 ,(concat "* TODO %?\n"
				  "/Entered on/ %U"))
		("m" "meeting" entry  (file ,agenda)
		 ,(concat "* %? :meeting: \n"
				  "SCHEDULED <%<%Y-%m-%d %a %H:00>>"))
		("u" "urgent" entry  (file ,agenda)
		 ,(concat "* %? :urgent: \n"
				  "DEADLINE <%<%Y-%m-%d %a %H:00>>"))
		("o" "osint" entry  (file ,agenda)
		 ,(concat "* %? :osint: \n"
				  "<%<%Y-%m-%d %a %H:00>>"))
		))

(setq org-agenda-hide-tags-regexp ".")

;; (setq org-agenda-prefix-format
;;       '((agenda . " %i %-12:c%?-12t% s")
;;         (todo   . " %i %-12:c")
;;         (tags   . " %i %-12:c")
;;         (search . " %i %-12:c")))

;; (regexp-opt '("Tasks" "Project"))
;; (regexp-opt '("Done" "Cancelled"))
;; (regexp-opt '("TODO"))

(setq org-refile-targets
	  `((,projects :maxlevel . 1)
		(,agenda :maxlevel . 1)
		(,someday :maxlevel . 1)
		(,backlog :maxlevel . 1)))

(advice-add 'org-refile :after 'org-save-all-org-buffers)

;; TODO: implement refile in a better way
(setq org-refile-use-outline-path 'file)
(setq org-outline-path-complete-in-steps nil)
(setq org-refile-allow-creating-parent-nodes 'confirm)

(setq org-todo-keywords
      '((sequence "TODO(t)" "WAIT(w)" "ORGANIZE(o)" "NEXT(n)" "|" "DONE(d)" "CANCELLED(c)")
		;; (sequence "REPORT(r)" "BUG(b)" "|" "FIXED(f)")
		;; something is missing but what?
		;; git actions pull request, push, pull, merge
		))

(setq org-agenda-custom-commands
	  '(("d" "Dashboard"
		 ((agenda "" ((org-deadline-warning-days 7)))
		  (todo "NEXT"
				((org-agenda-overriding-header "Next Tasks")))
		  (todo "TODO"
				((org-agenda-overriding-header "Todos to process")))
		  (tags "project" ((org-agenda-overriding-header "Projects")))))

		("o" "Organize"
		 ((todo "TODO"
				((org-agenda-overriding-header "To organize")
				 (org-agenda-files org-agenda-files)))))

		("n" "Next Tasks"
		 ((todo "NEXT"
				((org-agenda-overriding-header)))))

		("p" "Projects"
		 ((tags "project"
				((org-agenda-overriding-header "All Projects")))))

		("w" "Workflow Status"
		 ((todo "TODO"
				((org-agenda-overriding-header "Todos")
				 (org-agenda-files org-agenda-files)))
		 (todo "WAIT"
				((org-agenda-overriding-header "Waiting on External")
				 (org-agenda-files org-agenda-files)))
		  (todo "NEXT"
				((org-agenda-overriding-header "Next tasks")
				 (org-agenda-files org-agenda-files)))
		  (todo "DONE"
				((org-agenda-overriding-header "Completed")
				 (org-agenda-todo-list-sublevels nil)
				 (org-agenda-files org-agenda-files)))
		  (todo "CANCELLED"
				((org-agenda-overriding-header "Cancelled")
				 (org-agenda-files org-agenda-files)))
		  ))))

(defun nto/gtd-jump ()
  "Jump to the gtd directory from anywhere"
  (interactive)
  (find-file (concat org-directory "/agenda")))

(nto/leader-keys
  "A"  '(:ignore t :wk "Agenda")
  "Ac" '(org-capture :wk "capture")
  "Aa" '(org-agenda :wk "agenda")
  "Aj" '(nto/gtd-jump :wk "gtd jump"))

;; integrate with org roam dailies

(provide 'init-org)
;;; init-org ends here
