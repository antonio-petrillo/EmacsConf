;;; init-ui.el --- Description -*- lexical-binding: t; -*-

(use-package cyberpunk-theme)
(use-package gruber-darker-theme)

(use-package ef-themes
  :init (load-theme 'ef-frost t))

(use-package emacs
  :init
  (set-fringe-mode 0))

user-mail-address

(provide 'init-ui)
;;; init-ui.el ends here
