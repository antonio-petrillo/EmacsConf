;;; init-ui.el --- Description -*- lexical-binding: t; -*-

(use-package cyberpunk-theme)

(use-package gruber-darker-theme)

(use-package ef-themes)

(use-package doom-themes)

(use-package anti-zenburn-theme)

(defvar selected-theme 'anti-zenburn)

(use-package emacs
  :init
  (set-fringe-mode 0)
  (load-theme selected-theme t))

(use-package diminish
  :init
  (diminish 'which-key-mode)
  (diminish 'gcmh-mode)
  (diminish 'evil-snipe-mode)
  (diminish 'evil-snipe-local-mode)
  (diminish 'evil-escape-mode)
  (diminish 'eldoc-mode)
  (diminish 'evil-goggles-mode))

(provide 'init-ui)
;;; init-ui.el ends here
