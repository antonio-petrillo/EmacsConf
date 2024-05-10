(when (eq system-type 'gnu/linux)
  (use-package exwm
	:config
	;; make more room for x11 windows
	(menu-bar-mode -1)
	;; battery status in modeline
	(display-battery-mode)

	;; time display in modeline
	(display-time-mode)

	(setq exwm-workspace-number 9)

	;; system tray
	(require 'exwm-systemtray)
	(exwm-systemtray-enable)
	(setq exwm-systemtray-height 15)

	;; multi monitor
	(require 'exwm-randr)
	;; config randr
	(setq exwm-randr-workspace-monitor-plist '(0 "eDP" 1 "DisplayPort-3"))

	(exwm-randr-enable)

	(setq nto/layout "us")

	(setq exwm-input-global-keys
		  `(
			(,(kbd "s-r") . exwm-reset)
			(,(kbd "s-w") . exwm-workspace-switch)
			(,(kbd "s-m") . exwm-workspace-move-window)

			,@(mapcar (lambda (i)
						`(,(kbd (format "s-%d" i)) .
						  (lambda ()
							(interactive)
							(exwm-workspace-switch-create ,i))))
					  (number-sequence 0 9))

			(,(kbd "s-f") . exwm-layout-toggle-fullscreen)
			(,(kbd "s-F") . exwm-floating-toggle-floating)

			(,(kbd "s-q") . delete-window)
			(,(kbd "s-o") . ace-window)

			(,(kbd "s-h") . windmove-left)
			(,(kbd "s-j") . windmove-down)
			(,(kbd "s-k") . windmove-up)
			(,(kbd "s-l") . windmove-right)

			(,(kbd "s-H") . (lambda () (interactive) (exwm-layout-shrink-window-horizontally 20)))
			(,(kbd "s-J") . (lambda () (interactive) (exwm-layout-shrink-window 20)))
			(,(kbd "s-K") . (lambda () (interactive) (exwm-layout-enlarge-window 20)))
			(,(kbd "s-L") . (lambda () (interactive) (exwm-layout-enlarge-window-horizontally 20)))

			(,(kbd "s-i") . (lambda ()
							  (interactive)
							  (if (string= nto/layout "us")
								  (progn
									(setq nto/layout "us-intl")
									(start-process "" nil "/usr/bin/setxkbmap" "us" "-variant" "intl" "-option" "ctrl:nocaps")
									(message "switching to us intl"))
								(progn
								  (setq nto/layout "us")
								  (start-process "" nil "/usr/bin/setxkbmap" "us" "-option" "ctrl:nocaps")
								  (message "switching to us")))))))

	(setq exwm-floating-border-width 5)

	(add-hook 'exwm-update-class-hook
			  (lambda ()
				(unless (or (string-prefix-p "sun-awt-X11-" exwm-instance-name)
							(string= "gimp" exwm-instance-name))
				  (exwm-workspace-rename-buffer exwm-class-name))))
	(add-hook 'exwm-update-title-hook
			  (lambda ()
				(when (or (not exwm-instance-name)
						  (string-prefix-p "sun-awt-X11-" exwm-instance-name)
						  (string= "gimp" exwm-instance-name))
				  (exwm-workspace-rename-buffer exwm-title))))

	(setq exwm-input-simulation-keys
		  '(([?\C-b] . [left])
			([?\C-f] . [right])
			([?\C-p] . [up])
			([?\C-n] . [down])
			([?\C-a] . [home])
			([?\C-e] . [end])
			([?\M-v] . [prior])
			([?\C-v] . [next])
			([?\C-d] . [delete])
			([?\C-k] . [S-end delete])
			([?\C-s] . [?\C-f])))

	(add-hook 'exwm-init-hook
			  (lambda ()
				(progn
				  ;; setup composite transparency and background
				  (start-process "" nil "/usr/bin/picom" "-b")
				  ;; setup italian layout for keyboard
				  (start-process "setxkbmap" nil "/usr/bin/setxkbmap" "us" "-option" "ctrl:nocaps")))))

  (use-package exwm-modeline
	:if (eq system-type 'gnu/linux)
	:after exwm
	:init
	(add-hook 'exwm-init-hook #'exwm-modeline-mode))

  (use-package counsel
	:if (eq system-type 'gnu/linux)
	:after exwm
	:init
	(exwm-input-set-key (kbd "s-d") #'counsel-linux-app)))

(provide 'init-exwm)
