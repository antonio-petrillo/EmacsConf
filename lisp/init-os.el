(when (eq system-type 'windows-nt)
    (setq default-directory "C:/Users/Antonio Petrillo/"))

(when (eq system-type 'darwin)
  (setenv "PATH"
		  (concat "/Library/TeX/texbin" ":"
				  (getenv "PATH"))))

(provide 'init-os)
