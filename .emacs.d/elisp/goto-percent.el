;; カレントバッファ中の位置を全テキストの比率で指定しそこに移動する関数
(defun goto-percent (pct)
  (interactive "nGoto percent: ")	; 引数pctの整数値の入力を要求
  (let* ((size (point-max))		; サイズを文字単位でのバッファのサイズに初期化
         (charpos (/ (* size pct) 100))); サイズと入力パーセントから文字位置を割り出す
    (goto-char charpos)))		; その位置にポイントを移動
;; 簡易版
;; (defun goto-percent (pct)
;;	(interactive "nPercent: ")
;;	(goto-char (/ (* pct (point-max)) 100)
