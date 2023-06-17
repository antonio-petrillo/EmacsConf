;;; init.el --- Personal configuration file -*- lexical-binding: t; no-byte-compile: t; -*-

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(let ((file-name-handler-alist nil)
      (gc-cons-threshold 100000000))
  (require 'init-core)
  (require 'init-keys)
  (require 'init-utils)
  (require 'init-completion)
  (require 'init-ui))
