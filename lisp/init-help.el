(use-package helpful
  :init (setq evil-lookup-func #'helpful-at-point)
  :bind
  ([remap describe-function] . helpful-callable)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . helpful-variable)
  ([remap describe-key] . helpful-key))

(use-package which-key
  :init
  (setq which-key-separator " ")
  (setq which-key-prefix-prefix "+")
  (setq which-key-show-early-on-C-h t)
  (setq which-key-idle-delay 0.5)
  (setq which-key-idle-secondary-delay 0.5)
  (which-key-mode +1)
  (which-key-setup-minibuffer))

(use-package emacs
  :after general
  :init
  (nto/leader
   "h" '(:ignore t :which-key "help")
   "he" '(view-echo-area-messages :wk "messages buffer")
   "hf" '(describe-function :wk "function")
   "hF" '(describe-face :wk "face")
   "hl" '(view-lossage :wk "lossage")
   "hL" '(find-library :wk "library")
   "hm" '(describe-mode :wk "mode")
   "hk" '(describe-key :wk "keybind")
   "hK" '(describe-keymap :wk "keymap")
   "hp" '(describe-package :wk "package")
   "ht" '(consult-theme :wk "load theme")
   "hv" '(describe-variable :wk "variable")))

(provide 'init-help)
