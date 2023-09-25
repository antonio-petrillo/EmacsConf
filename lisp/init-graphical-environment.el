;;; init-graphical-environment.el --- Description -*- lexical-binding: t; -*-

(when (window-system)
  (tool-bar-mode -1)
  (toggle-scroll-bar -1)
  (menu-bar-mode -1))


(provide 'init-graphical-environment)
;;; init-graphical-environment.el ends here
