;;; init-stage2.el --- Description -*- lexical-binding: t; -*-
(add-to-list 'load-path (expand-file-name "lisp/stage2" user-emacs-directory))


;; notes after projects

(require 'init-utils)
(require 'init-completion)
(require 'init-ui)
(require 'init-app)
(require 'init-searches)
(require 'init-workspaces)
<<<<<<< HEAD
(require 'init-projects)
=======
(require 'init-notes)
>>>>>>> origin/master

(provide 'init-stage2)
;;; init-stage2.el ends here
