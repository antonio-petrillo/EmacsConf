(use-package google-translate
  :after general
  :config
  (push "\\*Google Translate\\*"  popper-reference-buffers)
  :init
  (setq google-translate-translation-directions-alist
        '(("it" . "en") ("en" . "it")))
  (setq google-translate-default-source-language "it")
  (setq google-translate-default-target-language "en")
  (nto/leader
	"lp" '(google-translate-at-point :wk "translate (it -> en)")
	"lP" '(google-translate-at-point-reverse :wk "translate (en -> it)")))

(use-package powerthesaurus
  :after general
  :defer t
  :init
  (nto/local-leader
	:keymaps 'org-mode-map
    "T" '(:ignore t :wk "powerthesaurus")
	"Tt" '(powerthesaurus-lookup-dwim :wk "become")
	"Ts" '(powerthesaurus-lookup-synonyms-dwim :wk "synonyms")
	"Ta" '(powerthesaurus-lookup-antonyms-dwim :wk "antonyms")
	"Tr" '(powerthesaurus-lookup-related-dwim :wk "related")
	"Td" '(powerthesaurus-lookup-definitions-dwim :wk "definitions")
	"TS" '(powerthesaurus-lookup-Sentence-dwim :wk "sentence")))

(provide 'init-writing)
