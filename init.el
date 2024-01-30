(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(setq straight-use-package-by-default t)
(setq straight-vc-git-default-clone-depth 1)
(setq straight-recipes-gnu-elpa-use-mirror t)
(setq straight-check-for-modifications '(check-on-save find-when-checking))
(setq straight-check-for-modifications nil)
(setq use-package-always-defer t)

(setq make-backup-files nil
      backup-inhibited nil
      auto-save-default nil
	  initial-buffer-choice t
      create-lockfiles nil)

(when (native-comp-available-p)
  (setq native-comp-async-report-warnings-errors 'silent
	native-compile-prune-cache t))

(setq custom-safe-themes t)

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(require 'init-config)
(require 'init-core)
(require 'init-evil)
(require 'init-help)
(require 'init-buffer)
(require 'init-editing)
(require 'init-completion)
(require 'init-dired)
(require 'init-ui)
(require 'init-writing)
(require 'init-font)
(require 'init-window)
(require 'init-workspaces)
(require 'init-magit)
(require 'init-project)
(require 'init-embark)
(require 'init-term)
(require 'init-org)
(require 'init-mouse)
(require 'init-browser)
(require 'init-os)
(require 'init-app)
