(with-eval-after-load 'general
  (when (display-graphic-p)
	(defun nto/google-search ()
	  "perform a goole search with region, or prompt for a search term, in the minibuffer."
	  (interactive)
	  (let ((base-url "https://google.com/search?q=%s")
			(param (if (region-active-p)
					   (nto/get-string-from-region)
					 (read-from-minibuffer "Google search: "))))
		(browse-url (nto/build-url base-url param))))

	(nto/leader
	  "sg" '(nto/google-search :wk "google"))))

(provide 'init-browser)
