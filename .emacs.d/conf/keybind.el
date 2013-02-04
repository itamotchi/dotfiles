;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	Key-Bind Set
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (C-m) newline-and-indent を割り当てる．初期値は newline
; (define-key global-map (kbd "C-m") 'newline-and-indent)

;; (M-k) カレントバッファを閉じる．初期値は kill-sentence
(define-key global-map (kbd "M-k") 'kill-this-buffer)

;; (C-t) ウィンドウを切り替える．初期値は transpose-chars
;(define-key global-map (kbd "C-t") 'other-window)

;; (M-up/down) ウインドウの切り替え
(global-set-key [M-down] 'next-buffer)
(global-set-key [M-up] 'previous-buffer)

;; コンパイルエラー行にジャンプするためのキーバインド定義(C-x l)
(define-key global-map "\C-xl" 'goto-line)
;; or (define-key ctl-x-map "l" 'goto-line)

;; (C-x ?)をhelp-commandに割り当てる
(global-set-key "\C-x?" 'help-command)
; または (define-key ctl-x-map "?" 'help-command)

;; (C-h)をbackward-charに割当
; (global-set-key "\C-h" 'backward-char)
; または (define-key global-map "\C-h" 'backward-char)

;; goto-lineコマンドをF5キーに割当
(global-set-key [f5] 'goto-line)
;; Ctrl-Alt-F5に割り当てるには
; (global-set-key [C-A-f5] 'goto-line)

;; goto-lineコマンドに割り当てた(C-x l)と(F5)の操作を解除

(global-unset-key [f5])                 
(define-key ctl-x-map "l" nil)

