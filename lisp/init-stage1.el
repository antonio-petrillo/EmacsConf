;;; init-stage1.el --- Description -*- lexical-binding: t; -*-
(add-to-list 'load-path (expand-file-name "lisp/stage1" user-emacs-directory))

;; NOTE: helpers-fns must be loaded before graphical-environment
(require 'init-helpers-fns)
(require 'init-core)
(require 'init-config)
(require 'init-os)
(require 'init-graphical-environment)
(require 'init-keys)

(provide 'init-stage1)

;;; init-stage1.el ends here
