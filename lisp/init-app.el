(use-package screenshot)

(use-package selectric-mode
  :commands selectric-mode)

(use-package erc
  :init
  (defun start-irc ()
	"Connect to irc."
	(interactive)
	(when (y-or-n-p (format "connect to: %s?" my-erc-server))
	  (erc-tls :server my-erc-server
			   :port my-erc-port
			   :nick my-erc-nick
			   :full-name my-erc-full-name
			   :password my-erc-passwd
			   :client-certificate t)))
  :config
  (require 'erc-autoaway)

  ;; connection params
  (setq erc-server my-erc-server
		erc-nick my-erc-nick
		erc-user-full-name my-erc-full-name
		erc-track-shorten-start 8
		erc-autojoin-channels-alist my-erc-autojoin-channels
		erc-kill-buffer-on-part t
		erc-auto-query 'bury)
  ;; erc config
  (setq erc-interpret-mirc-color t
		erc-kill-buffer-on-part t
		erc-kill-queries-on-quit t
		erc-kill-server-buffer-on-quit t

		erc-autoaway-idle-method 'user
		erc-auto-discard-away t
		erc-autoaway-idle-seconds 600))

(provide 'init-app)
