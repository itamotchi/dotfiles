;; バッファ中の単語数を計算するLisp関数(日本語ではうまく機能しない)
(defun count-words-buffer ()	; defun 名前と引数で関数を定義
  "Count the number of words in the current buffer;
print a message in the minibuffer with the result."
  (interactive)			; コマンドとして登録
  (let ((count 0))		; ローカル変数"count"に"0"をセット
    (save-excursion		; カーソル位置を記憶しボディが完了したとき元に戻す
      (goto-char (point-min))	; バッファの先頭にポイント(カーソル)が移動
      (while (< (point) (point-max))	; ポイントがバッファ長に達するまで繰り返す
        (forward-word 1)		; (ポイントが)次の単語に移動
        (setq count (1+ count)))	; ループカウンタを１増やす
      (message "buffer contains %d words." count))))	; カウント数を出力
