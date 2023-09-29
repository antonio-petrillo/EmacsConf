;;; init-searches.el --- Description -*- lexical-binding: t; -*-

(defmacro nto/build-url (url &rest params)
  `(format ,url ,@params))

(defun nto/google-search ()
  (interactive)
  (let ((base-url "https://google.com/search?q=%s")
		(param (if (region-active-p)
				   (nto/get-string-from-region)
				 (read-from-minibuffer "Google search: "))))
		(browse-url (nto/build-url base-url param))))

(with-window-system
	(nto/leader-keys
	  "s" '(:ignore t :wk "search")
	  "sg" '(nto/google-search :wk "google")))

(provide 'init-searches)
;;; init-ui.el ends here
