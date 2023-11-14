;;; init-stage3.el --- Description -*- lexical-binding: t; -*-
(add-to-list 'load-path (expand-file-name "lisp/stage3" user-emacs-directory))

(require 'init-data)
(require 'init-programming)
(require 'init-java)
(require 'init-zig)

(provide 'init-stage3)

;;; init-stage3.el ends here
