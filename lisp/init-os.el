(when (eq system-type 'windows-nt)
    (setq default-directory windows-default-directory))

(when (eq system-type 'darwin)
  (setenv "PATH"
		  (concat "/Library/TeX/texbin" ":"
				  (getenv "PATH"))))

(provide 'init-os)
