;; 変更を加えた数を報告する関数
(defun pluralize (word count &optional plural)	
  (if (= count 1)		; 変更数が１つ
      word			; 真："word"を返す
    (if (null plural)		; (else if)オプション引数が指定されてない
        (concat word "s")	; 真："word"+"s"複数形にして返す
      plural)))			; 偽：オプション引数を返す

;; 変更を加えた数を愛想よく報告する関数
(defun how-many (count)
  (cond ((zerop count) "no")	; zero predicate関数：値が'0'か調べる
        ((= count 1) "one")	; 値が'1'であれば"one"を返す
        ((= count 2) "two")	; 
        (t "many")))		; 先の全ての条件に当てはまらなかったとき"many"を返す

;; 上二つを統合
(defun report-change-count (count)
  (message "Made %s %s." (how-many count) (pluralize "change" count)))
