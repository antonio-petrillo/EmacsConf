;;; init-ui.el --- Description -*- lexical-binding: t; -*-

(use-package cyberpunk-theme)

(use-package ef-themes
  :init (load-theme 'ef-frost t))

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)

(provide 'init-ui)
;;; init-ui.el ends here
