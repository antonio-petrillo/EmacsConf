;;; init-core.el --- Description -*- lexical-binding: t; -*-

(setq straight-use-package-by-default t)
(setq straight-vc-git-default-clone-depth 1)
(setq straight-recipes-gnu-elpa-use-mirror t)
;; (setq straight-check-for-modifications '(check-on-save find-when-checking))
(setq straight-check-for-modifications nil)
(setq use-package-always-defer t)
(defvar bootstrap-version)
(let* ((straight-repo-dir
        (expand-file-name "straight/repos" user-emacs-directory))
       (bootstrap-file
        (concat straight-repo-dir "/straight.el/bootstrap.el"))
       (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (shell-command
     (concat
      "mkdir -p " straight-repo-dir " && "
      "git -C " straight-repo-dir " clone "
      "https://github.com/raxod502/straight.el.git && "
      "git -C " straight-repo-dir " checkout 2d407bc")))
  (load bootstrap-file nil 'nomessage))
(straight-use-package 'use-package)
(setq comp-deferred-compilation-black-list nil)
(setq use-package-compute-statistics t)

(use-package emacs
  :init
  (setq inhibit-startup-screen t
        initial-scratch-message nil
        sentence-end-double-space nil
        ring-bell-function 'ignore
        frame-resize-pixelwise t)

  (setq user-full-name "Antonio Petrillo"
        user-mail-address "antonio.petrillo4@unina.it")

  (setq read-process-output-max (* 10 1024 1024)) ;; 10mb

  (defalias 'yes-or-no-p 'y-or-n-p)

  (set-charset-priority 'unicode)
  (setq locale-coding-system 'utf-8
        coding-system-for-read 'utf-8
        coding-system-for-write 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (set-keyboard-coding-system 'utf-8)
  (set-selection-coding-system 'utf-8)
  (prefer-coding-system 'utf-8)
  (setq default-process-coding-system '(utf-8-unix . utf-8-unix))

  (delete-selection-mode t)

  (recentf-mode t)
  (setq recentf-exclude `(,(expand-file-name "straight/build/" user-emacs-directory)
                          ,(expand-file-name "eln-cache/" user-emacs-directory)
                          ,(expand-file-name "etc/" user-emacs-directory)
                          ,(expand-file-name "var/" user-emacs-directory)))

  (global-set-key (kbd "<escape>") 'keyboard-escape-quit)

  (setq custom-file (make-temp-file ""))
  (setq custom-safe-themes t)
  (setq enable-local-variables :all)

  (setq make-backup-files nil
        auto-save-default nil
        create-lockfiles nil)

  (setq vc-follow-symlinks t)

  (show-paren-mode t)

  (setq byte-compile-warnings '(not free-vars unresolved noruntime lexical make-local))
  (setq native-comp-async-report-warnings-errors nil)
  (setq load-prefer-newer t)


  (display-time-mode -1)
  (setq column-number-mode t)
  (global-display-line-numbers-mode)
  (setq display-line-numbers 'relative)

  (setq-default indent-tabs-mode t)
  (setq-default tab-width 4)

  (winner-mode t)
  (setq tab-always-indent 'complete))

(provide 'init-core)
;;; init-core.el ends here
