;;; init-helpers-fns.el --- Description -*- lexical-binding: t; -*-

(defun nto/neq (obj1 obj2)
  (not (eq obj1 obj2)))

(defun nto/get-string-from-region ()
  "Return the `text` in highlighed region"
  (buffer-substring-no-properties (region-beginning) (region-end)))

(provide 'init-helpers-fns)
;;; init-helpers-fns.el ends here
