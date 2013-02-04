;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	Encode-Set
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)

;; Macのファイルシステム用
(when (eq system-type 'darwin)
  ; Emacsでファイル名を正しく扱う
  (require 'ucs-normalize)
  (setq file-name-coding-system 'utf-8-hfs)
  (setq local-coding-system 'utf-8-hfs))

