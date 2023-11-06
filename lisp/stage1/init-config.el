;;; init-config.el --- Description -*- lexical-binding: t; -*-
(use-package emacs
  :init
  (setq user-full-name "Antonio Petrillo"
        user-mail-address "antonio.petrillo4@unina.it"
		default-theme 'gruber-darker
		org-directory "~/Documents/Org"
		selected-theme default-theme
		preferred-theme (nth 0 '(light dark))
		machine (nth 0 '(laptop pc rpi termux docker))
		preferred-font "JetBrains Mono"))
  
(provide 'init-config)
;;; init-config.el ends here
