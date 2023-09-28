;;; init-data.el --- Description -*- lexical-binding: t; -*-

;; xml mode preinstalled

(use-package csv-mode
  :init
  (add-hook 'csv-mode-hook 'csv-guess-set-separator))

(use-package json-mode)

(use-package toml-mode)

(use-package yaml-mode)

(use-package parseedn)

(provide 'init-data)
;;; init-data.el ends here
