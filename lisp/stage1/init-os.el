;;; init-os.el --- Description -*- lexical-binding: t; -*-

(defmacro with-windows (&rest body)
  (declare (indent 1) (debut t))
  (list 'if `(eq system-type 'windows-nt)
		(cons 'progn body)))

(defmacro with-linux (&rest body)
  (declare (indent 1) (debut t))
  (list 'if `(eq system-type 'gnu/linux)
		(cons 'progn body)))

(defmacro with-mac-os (&rest body)
  (declare (indent 1) (debut t))
  (list 'if `(eq system-type 'darwin)
		(cons 'progn body)))

(defmacro without-windows (&rest body)
  (declare (indent 1) (debut t))
  (list 'if `(nto/neq system-type 'windows-nt)
		(cons 'progn body)))

(with-mac-os
  (setq mac-command-modifier 'super)
  (setq mac-option-modifier 'meta)
  (setq mac-control-modifier 'control))

(with-windows
  (setq default-directory "C:/Users/antof/"))

(provide 'init-os)
;;; init-os-utils.el ends here
