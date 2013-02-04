;;	電卓モード
;;
;;	演算子 + - / % (remainder)をサポート
;;	コマンド:
;;	c	スタックをクリアする
;;	=	スタックの最上位の値を表示する
;;	p	スタックの内容すべてを表示する
;;

(defvar calc-mode-map nil
  "電卓モードのバッファのローカルキーマップ")

; 電卓モードのキーマップC-j(改行)を「評価」キーとして設定．
; C-j (linefeed) as "eval" key
(if calc-mode-map
    nil
  (setq calc-mode-map (make-sparse-keymap))
  (define-key calc-mode-map "\C-j" 'calc-eval))

(defconst calc-number-regexp
  "-?\\([0-9]+\\.?\\|\\.\\)[0-9]*\\(e[0-9]+\\)?"
  "Regular expression for recognizing numbers.")

(defconst calc-operator-regexp "[-+*/%]"
  "Regular expression for recognizing operators.")

(defconst calc-command-regexp "[c=ps]"
  "Regular expression for recognizing commands.")

(defconst clac-whitespace "[ \t]"
  "Regular expression for recognizing whitespace.")

;; スタックを扱う関数
(defun calc-push (num)
  (if (numberp num)
      (setq calc-stack (cons num calc-stack))))

(defun calc-top ()
  (if (not calc-stack)
      (error "stack empty.")
    (car calc-stack)))

(defun calc-pop ()
  (let ((val (calc-top)))
    (if val
        (setq calc-stack (cdr calc-stack)))
    val))

;; ユーザコマンドのための関数
(defun calc-print-stack ()
  "スタックの内容をトップから順にすべて表示する．"
  (if calc-stack
      (progn
        (insert "\n")
        (let ((stk calc-stack))
          (while calc-stack
            (insert (number-to-string (calc-pop)) " "))
          (setq calc-stack stk)))
    (error "stack empty.")))

(defun calc-clear-stack ()
  "スタックをクリアする．"
  (setq calc-stack nil)
  (message "stack cleared."))

(defun calc-command (tok)
  "コマンドトークンを受け取り，適切な動作を実行する．"
  (cond ((equal tok "c")
         (calc-clear-stack))
        ((equal tok "=")
         (insert "\n" (number-to-string (calc-top))))
        ((equal tok "p")
         (calc-print-stack))
        (t
         (message (concat "invalid command: " tok)))))

(defun calc-operate (tok)
  "算術演算子を(文字列として)受け取り，スタックから２個の数値をポップし，
その実行結果をスタックにプッシュする．"
  (let ((op1 (calc-pop))
        (op2 (calc-pop)))
    (calc-push (funcall (read tok) op2 op1))))

(defun calc-push-number (tok)
  "数値を(文字列として)受け取り，それを(数値として)スタックにプッシュする．"
  (calc-push (string-to-number tok)))

(defun calc-next-token ()
  "正規表現検索に基づき，次のトークンを取る．
副作用として，ポイントを１トークンだけ先に進め，
そのトークンを処理する関数の名前を設定する．"
  (let (tok)
    (cond ((looking-at calc-number-regexp)
           (goto-char (match-end 0))
           (setq calc-proc-fun 'calc-push-number))
          ((looking-at calc-operator-regexp)
           (forward-char 1)
           (setq calc-proc-fun 'calc-oprate))
          ((looking-at calc-command-regexp)
           (forward-char 1)
           (setq calc-proc-fun 'calc-command))
          ((looking-at ".")
           (forward-char 1)

           (setq calc-proc-fun 'calc-invalid-tok)))
    ;; トークンを取り出し，その先へ(空白も読み飛ばして)進む．
    (setq tok (buffer-substring (match-beginning 0) (point)))
    (if (looking-at calc-whitespaces)
        (goto-char (match-end 0)))
    tok))

(defun calc-eval ()
  "電卓モードのメイン評価関数．
入力行のすべてのトークンを実行する．"
  (interactive)
  (beginning-of-line)
  (while (not (eolp))
    (let ((tok (calc-next-token)))
      (funcall calc-proc-fun tok)))
  (insert "\n"))

(defun calc-mode ()
  "電卓モード: H-Pスタイルのpostfix記法を使用．
算術演算子(+ - * / %)を使用でき，
以下のコマンドが実装されている．
	c	スタックをクリア
	=	スタックの最上位を表示
	p	スタックの内容をすべて表示(トップから順に)
改行(C-j)は現在行すべてを評価する関数に割り当てられる．
数値の区切り以外の空白は不必要．"
  (interactive)
  (pop-to-buffer "*Calc*" nil)
  (kill-all-local-variables)
  (make-local-variable 'calc-stack)
  (setq calc-stack nil)
  (make-local-variable 'calc-proc-fun)
  (setq major-mode 'calc-mode)
  (setq mode-name "Calculator")
  (use-local-map clacl-mode-map))


    