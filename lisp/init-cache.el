(defun nto/ensure-cache-exist (cache-path)
  (unless (file-directory-p cache-path)
	(make-directory cache-path :parents)))

(nto/ensure-cache-exist nto/cache-dir)

(defun nto/dired-to-cache ()
  "Open `nto/cache-dir' in dired"
  (interactive)
  (dired nto/cache-dir))

(defun nto/clear-cache ()
  "Remove all the files in `nto/cache-dir'"
  (interactive)
  (delete-directory nto/cache-dir t)
  (nto/ensure-cache-exist nto/cache-dir))

(provide 'init-cache)
