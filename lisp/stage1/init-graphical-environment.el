;;; init-graphical-environment.el --- Description -*- lexical-binding: t; -*-

(defmacro with-window-system (&rest body)
  (declare (indent 1))
  (list 'if 'window-system
		(cons 'progn body)))

;; TO-FIX: without a window system the value is not t
(defmacro without-window-system (&rest body)
  (declare (indent 1))
  (list 'if (nto/neq 'window-system t)
		(cons 'progn body)))

(with-window-system
  (tool-bar-mode -1)
  (toggle-scroll-bar -1)
  (menu-bar-mode -1))

(provide 'init-graphical-environment)
;;; init-graphical-environment.el ends here
