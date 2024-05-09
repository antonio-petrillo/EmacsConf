(set-charset-priority 'unicode)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(setq locale-coding-system 'utf-8
	  coding-system-for-read 'utf-8
	  coding-system-for-write 'utf-8
	  default-process-coding-system '(utf-8-unix . utf-8-unix))

(defun nto/set-font-all (selected)
  "Set `selected' font to all the faces, this will apply only if the `selected' font is found in the system"
  (when (find-font (font-spec :name selected))
	(set-face-attribute 'default nil :font selected :height my-font-height)
	(set-face-attribute 'fixed-pitch nil :font selected :height my-font-height)
	(set-face-attribute 'variable-pitch nil :font selected :height my-font-height :weight 'regular)))

(nto/set-font-all selected-font)

(provide 'init-font)
