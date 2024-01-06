(use-package embark
  :init
  (global-set-key (kbd "C-,") #'embark-act)
  (global-set-key (kbd "M-,") #'embark-dwim)
  (setq prefix-help-command #'embark-prefix-help-command)
  (nto/leader
	"a" '(:ignore t :wk "embark")
	"aa" '(embark-act :wk "act")
	"ad" '(embark-dwim :wk "dwim")
	"ab" '(embark-become :wk "become")
	"ac" '(embark-collect :wk "collect"))
  :config
  (add-to-list 'display-buffer-alist
			   '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
				 nil
				 (window-parameters (mode-line-format . none)))))

(use-package embark-consult
  :after '(embark consult)
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

  (with-eval-after-load 'embark
    (eval-when-compile
  	(defmacro nto/embark-ace-action (fn)
  	  `(defun ,(intern (concat "nto/embark-ace-" (symbol-name fn))) ()
  		 (interactive)
  		 (with-demoted-errors "%s"
  		   (require 'ace-window)
  		   (let ((aw-dispatch-always t))
  			 (aw-switch-to-window (aw-select nil))
  			 (call-interactively (symbol-function ',fn)))))))

    ;; RMB: work when there are at least 3 window
    (define-key embark-file-map (kbd "o") (nto/embark-ace-action find-file))
    (define-key embark-buffer-map (kbd "o") (nto/embark-ace-action switch-to-buffer))
    (define-key embark-bookmark-map (kbd "o") (nto/embark-ace-action bookmark-jump)))

  (with-eval-after-load 'embark
    (eval-when-compile
  	(defmacro nto/embark-split-action (fn split-type)
        `(defun ,(intern (concat "nto/embark-"
  							   (symbol-name fn)
  							   "-"
  							   (car (last  (split-string
  											(symbol-name split-type) "-")))))
  		   (interactive)
  		 (funcall #',split-type)
  		 (call-interactively #',fn))))

    (define-key embark-file-map     (kbd "s") (nto/embark-split-action find-file split-window-below))
    (define-key embark-buffer-map   (kbd "s") (nto/embark-split-action switch-to-buffer split-window-below))
    (define-key embark-bookmark-map (kbd "s") (nto/embark-split-action bookmark-jump split-window-below))

    (define-key embark-file-map     (kbd "v") (nto/embark-split-action find-file split-window-right))
    (define-key embark-buffer-map   (kbd "v") (nto/embark-split-action switch-to-buffer split-window-right))
    (define-key embark-bookmark-map (kbd "v") (nto/embark-split-action bookmark-jump split-window-right)))

(provide 'init-embark)
