(setq nto/conf-dir-name ".ntomacs.d/")
(setq nto/conf-name "config.el")

(defun nto/create-default-config (conf-path)
  "Create the config file, with template"
  (with-temp-buffer
	(insert "(setq user-full-name \"Antonio Petrillo\")\n")
	(insert "(setq user-mail-address \"antonio.petrillo4@studenti.unina.it\")\n")
	(insert "\n")

	(insert "(setq default-theme 'modus-vivendi)\n")
	(insert "(setq selected-theme 'tron-legacy)\n")

	(insert "\n")
	(insert "(setq selected-font \"Source Code Pro\")\n")

	(insert "\n")
	(insert "(setq org-directory \"~/Documents/Org\")\n")

	(insert "\n")
	(insert "(setq nto/cache-dir \"~/.cache/\")\n")

	(insert "\n")
	(insert "(provide 'config)")
	(write-file conf-path)))

(defun nto/load-or-create-config-file()
  "If `nto/conf-dir-name' directory don't exist create it.
If `nto/conf-name' file don't exist create it.
Finally add the file to the load path and `require' it"
  (let* ((parent-user-emacs-directory (file-name-directory
									   (directory-file-name user-emacs-directory)))
		 (conf-dir (concat parent-user-emacs-directory nto/conf-dir-name))
		 (conf-path (concat conf-dir nto/conf-name)))
	(unless (file-directory-p conf-dir)
	  (make-directory conf-dir :parents)) ;; create conf dir if not exist
	(unless (file-exists-p conf-path)
	  (nto/create-default-config conf-path)) ;; create conf file if not exist
	(add-to-list 'load-path conf-dir) ;; add to load path
	(require 'config))) ;; load persona config

(nto/load-or-create-config-file)

(provide 'init-config)
