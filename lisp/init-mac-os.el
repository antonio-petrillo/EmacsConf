;;; init-mac-os.el --- Description -*- lexical-binding: t; -*-

(when  (eq system-type 'darwin)
  (setq mac-command-modifier 'super)
  (setq mac-option-modifier 'meta)
  (setq mac-control-modifier 'control)
  )

(provide 'init-mac-os)
;;; init-ms-windows.el ends here
