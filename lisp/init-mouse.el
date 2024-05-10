(defun nto/dired-home ()
  "open dired at home"
  (interactive)
  (dired "~/"))

(keymap-global-set "C-<down-mouse-1>" 'strokes-do-stroke)
(keymap-global-set "<down-mouse-3>" 'mouse-buffer-menu)

(unless (display-graphic-p)
  (if (eq system-type 'gnu/linux)
	  (gpm-mouse-mode 1)
	(xterm-mouse-mode 1)))

(provide 'init-mouse)
