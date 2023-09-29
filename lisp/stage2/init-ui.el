;;; init-ui.el --- Description -*- lexical-binding: t; -*-

(use-package cyberpunk-theme)

(use-package gruber-darker-theme)

(use-package ef-themes)

(use-package doom-themes)

(use-package anti-zenburn-theme)

(use-package emacs
  :diminish eldoc-mode
  :diminish hs-minor-mode
  :hook (prog-mode . hs-minor-mode)
  :init
  (add-hook 'hs-minor-mode-hook (lambda () (diminish 'hs-minor-mode)))
  (set-fringe-mode 0)
  (load-theme selected-theme t)
  (evil-define-key 'normal 'global
	(kbd "za") 'hs-toggle-hiding
	(kbd "zc") 'hs-hide-block
	(kbd "zo") 'hs-show-block)
  (when (or (eq 'laptop machine)
			(eq 'pc machine))
	(add-to-list 'initial-frame-alist '(fullscreen . maximized))))

(when (find-font (font-spec :name preferred-font))
  (set-face-attribute 'default nil :font preferred-font :height 120)
  (set-face-attribute 'fixed-pitch nil :font preferred-font :height 120)
  (set-face-attribute 'variable-pitch nil :font preferred-font :height 120 :weight 'regular))

(with-window-system
	(use-package all-the-icons-dired
	  :hook (dired-mode . all-the-icons-dired-mode)))


(provide 'init-ui)
;;; init-ui.el ends here
