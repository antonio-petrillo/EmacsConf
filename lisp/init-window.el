(use-package emacs
  :after general
  :init
  (nto/leader
	"w" '(:ignore t :wk "window")
	"wv" '(evil-window-vsplit :wk "split V")
	"ws" '(evil-window-split :wk "split H")
	"w1" '(delete-other-windows :wk "delete others")
	"w!" '(ace-delete-other-windows :wk "(ACE) delete others")
	"w0" '(delete-windows :wk "delete")
	"wq" '(ace-delete-window :wk "(ACE) delete")
	"wS" '(ace-swap-window :wk "(ACE) swap")
	"wh" '(windmove-left :wk "move left")
	"wj" '(windmove-down :wk "move down")
	"wk" '(windmove-up :wk "move up")
	"wl" '(windmove-right :wk "move right")
	"wH" '(windmove-swap-states-left :wk "swap left")
	"wJ" '(windmove-swap-states-down :wk "swap down")
	"wK" '(windmove-swap-states-up :wk "swap up")
	"wL" '(windmove-swap-states-right :wk "swap right")
	"wc" '(delete-window :wk "delete")
	"w=" '(balance-windows-area :wk "equal")
	"wD" '(kill-buffer-and-window :wk "kill buffer and window")
	"wm" '(delete-other-windows :wk "maximize")
	"wu" '(winner-undo :wk "undo")
	"wU" '(winner-redo :wk "redo")))

(use-package rotate
  :after general
  :init
  (setq rotate-functions '(rotate:even-horizontal
                           rotate:even-vertical
                           rotate:main-horizontal
                           rotate:main-vertical
                           rotate:tiled))
  (nto/leader
	"wr" '(rotate-window :wk "window")
	"wR" '(rotate-layout :wk "layout")
	"rr" '(rotate-window :wk "window")
	"rl" '(rotate-layout :wk "layout")))

(use-package golden-ratio
  :after general
  :config
  (setq golden-ratio-adjust-factor 1.0)
  :init
  (nto/leader
	"tg" '(golden-ratio-mode :wk "golden ratio")))

(use-package ace-window
  :after general
  :config
  (setq aw-scope 'frame)
  :init
  (setq aw-dispatch-always nil)
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  (defvar aw-dispatch-alist
	'((?x aw-delete-window "Delete Window")
	  (?m aw-swap-window "Swap Windows")
	  (?M aw-move-window "Move Window")
	  (?c aw-copy-window "Copy Window")
	  (?j aw-switch-buffer-in-window "Select Buffer")
	  (?n aw-flip-window "Flip window")
	  (?u aw-switch-buffer-other-window "Switch Buffer Other Window")
      (?e aw-execute-command-other-window "Execute Command Other Window")
	  (?c aw-split-window-fair "Split Fair Window")
	  (?v aw-split-window-vert "Split Vert Window")
	  (?b aw-split-window-horz "Split Horz Window")
	  (?o delete-other-windows "Delete Other Windows")
	  (?? aw-show-dispatch-help))
	"List of actions for `aw-dispatch-default'.")
  :general
  (nto/leader
    "ww" '(ace-window :wk "ace window")))

(provide 'init-window)
