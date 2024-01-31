(setq frame-resize-pixelwise t
      frame-inhibit-implied-resize t
      frame-title-format '("%b")
      ring-bell-function 'ignore
      use-dialog-box t
      use-file-dialog nil
      use-short-answers t
      package-enable-at-startup nil ;; for straight.el
      custom-file (make-temp-file "emacs-custom-") ;; avoid custom file
      inhibit-startup-screen t
      inhibit-splash-screen t
      inhibit-startup-buffer-menu t)

(menu-bar-mode 1)
(scroll-bar-mode 1)
(tool-bar-mode -1)

(fset 'yes-or-no-p 'y-or-n-p)

(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.5)

(defvar nto/file-name-handler-alist file-name-handler-alist)

(defvar nto/vc-handled-backends vc-handled-backends)

(setq file-name-handler-alist nil
      vc-handled-backends nil)

(add-hook 'emacs-startup-hook
	  (lambda ()
	    (setq gc-cons-threshold (* 1024 1024 100) ;; 100 MB 
		  gc-cons-percentage 0.2
		  file-name-handler-alist nto/file-name-handler-alist
		  vc-handled-backends nto/vc-handled-backends)))

(defun nto/avoid-initial-flash-of-light ()
  (set-face-attribute 'default nil :background "#000000" :foreground "#ffffff")
  (set-face-attribute 'mode-line nil :background "#000000" :foreground "#ffffff" :box 'unspecified))

(nto/avoid-initial-flash-of-light)

(defun nto/set-frame-params()
  (mapc (lambda (target-list)
		  (add-to-list target-list '(width . (text-pixels . 900)))
		  (add-to-list target-list '(height . (text-pixels . 600)))
		  (add-to-list target-list '(scroll-bar-width . 7)))
		'(default-frame-alist initial-frame-alist)))

(nto/set-frame-params)
