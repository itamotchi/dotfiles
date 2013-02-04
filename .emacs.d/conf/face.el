;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	Face-Set
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Transparent
(set-frame-parameter (selected-frame) 'alpha '(95 75))

;; Frame Set
(setq initial-frame-alist '((top   . 40) (left   . 20)
			    (width . 100) (height . 48)))
(setq default-frame-alist '((width . 100) (height . 48)))

;; スタートアップメッセージを非表示
(setq inhibit-startup-screen t)

;; ターミナル以外
(when window-system
  ; tool-barを非表示
  (tool-bar-mode 0)
  ; scroll-barを非表示
  (scroll-bar-mode 0))

;; メニューバーにファイルパスを表示
(setq frame-title-format
      (format "%%f - Emacs@%s" (system-name)))

;; 行番号を表示する
(global-linum-mode t)

;; フェイスの設定
; (set-face-foreground FACECOLOR)	; 文字色を変更
; (set-face-background FACECOLOR)	; 背景色を変更 (COLOR or nil)
; (set-face-bold-p FACE t)		; 太字にする (t or nil)
; (set-face-italic-p FACE t)		; 斜体にする (t or nil)
; (set-face-underline-p FACE t)		; 下線を表示 (t or nil)

;; paren-mode 対応する括弧を強調表示
; (setq show-paren-delay 0.125)	; 表示までの秒数
; (show-paren-mode t)

;; parenのスタイル: expressionは括弧内も強調表示
; (setq show-paren-style 'expression)

;; parenのフェイスを変更
; (set-face-background 'show-paren-match-face nil)
; (set-face-underline-p 'show-paren-match-face "yellow")

;; Left Margin
; (setq-default left-margin 4)
