;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	Font-Set
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(create-fontset-from-ascii-font "Courier-18:weight=normal:slant=normal"
				nil
				"miifont")
(set-fontset-font "fontset-miifont"
                  'unicode
                  (font-spec :family "Hiragino Kaku Gothic ProN" :size 16)
                  nil
                  'append)
(add-to-list 'default-frame-alist '(font . "fontset-miifont"))

;; 英語フォントを指定 asciiフォントをMenloに
; (set-face-attribute 'default nil
;                   :family "Menlo"
;                   :height 120)

;; 日本語フォントをヒラギノ明朝ProNに
; (set-fontset-font nil
;                 'japanese-jisx0208
;                 (font-spec :family "Hiragino_Mincho_ProN"))

;; ひらがなとカタカナをモトヤシーダに(指定にはUnicodeの符号を利用)
;; U+3000-303F CJKの記号および句読点
;; U+3040-309F ひらがな
;; U+30A0-30FF カタカナ
; (set-fontset-font nil
;                 '(#x3040 . #x30FF)
;                 (font-spec :family "NfMotoyaCedar"))

;; フォントの横幅を調整する
; (setq face-font-rescale-alist
;     '((".*Menlo.*" . 1.0)
;       (".*Hiragino_Mincho_ProN.*" . 1.2)
;       (".*nfmotoyacedar-bold.*" . 1.2)
;       (".*nfmotoyacedar-medium.*" . 1.2)
;       ("-cdac$" . 1.3)))

