
((digest . "b4ea94ebdf30df2c77ca9e413113aeb1") (undo-list nil (#("; エントリとはリストのペアであり、
; 第１リストが集合であり、２つのリストは同じ長さである

; lookup-in-entry-help
; キー(names)と値(values)を取り、指定されたキー名(name)に対応する値を返す
; キー名が(names)にない場合、(entry-f)に(name)をかける
(define lookup-in-entry-help
  (lambda (name names values entry-f)
    (cond
     ((null? names) (entry-f name))
     ((eq? (car names) name) (car values))
     (else
      (lookup-in-entry-help
       name (cdr names) (cdr values) entry-f)))))

; lookup-in-entry
; エントリ(entry)をキーと値に分割し、(lookup-in-entry-help)に渡す
(define lookup-in-entry
  (lambda (name entry entry-f)
    (lookup-in-entry-help name (first entry) (second entry) entry-f)))

; テーブル(環境)とはエントリのリスト

; lookup-in-table
; テーブルの１つのエントリを取り出し、(lookup-in-entry)にかける
; (entry-f)に残りのエントリを調べるべく再び(lookup-in-table)に再帰してくるように関数を渡す
(define lookup-in-table
  (lambda (name table table-f)
    (cond
     ((null? table) (table-f name))
     (else 
      (lookup-in-entry 
       name (car table) 
       (lambda (name)
         (lookup-in-table name (cdr table) table-f)))))))

; atom-to-action
(define atom-to-action
  (lambda (e)
    (cond
     ((number? e) *const)
     ((eq? e #t) *const)
     ((eq? e #f) *const)
     ((eq? e (quote cons)) *const)
     ((eq? e (quote car)) *const)
     ((eq? e (quote cdr)) *const)
     ((eq? e (quote null?)) *const)
     ((eq? e (quote eq?)) *const)
     ((eq? e (quote atom?)) *const)
     ((eq? e (quote zero?)) *const)
     ((eq? e (quote add1)) *const)
     ((eq? e (quote sub1)) *const)
     ((eq? e (quote number?)) *const)
     (else *identifier))))

; list-to-action
(define list-to-action
  (lambda (e)
    (cond
     ((atom? (car e)) 
      (cond
       ((eq? (car e) (quote quote)) *quote)
       ((eq? (car e) (quote lambda)) *lambda)
       ((eq? (car e) (quote cond)) *cond)
       (else *application)))
     (else *application))))

; expression-to-action
(define expression-to-action
  (lambda (e)
    (cond
     ((atom? e) (atom-to-action e))
     (else (list-to-action e)))))

; meaning
(define meaning
  (lambda (e table)
    ((expression-to-action e) e table)))

; value
(define value
  (lambda (e)
    (meaning e (quote ()))))

; *const
(define *const
  (lambda (e table)
    (cond
     ((number? e) e)
     ((eq? e #t) #t)
     ((eq? e #f) #f)
     (else 
      (build (quote primitive) e)))))

; *quote
(define *quote
  (lambda (e table)
    (test-of e)))

; test-of
(define test-of second)

; *identifier
(define *identifier
  (lambda (e table)
    (lookup-in-table e table initial-table)))

; initial-table
(define initial-table
  (lambda (name)
    (car (quote ()))))

; evcon
(define evcon
  (lambda (lines table)
    (cond
     ((else? (question-of (car lines)))
      (meaning (answer-of (car lines)) table))
     ((meaning (question-of (car lines)) table)
      (meaning (answer-of (car lines))))
     (else (evcon (cdr lines) table)))))

; else?
(define else?
  (lambda (x)
    (cond
     ((atom? x) (eq? x (quote else)))
     (else #f))))

; question-of 
(define question-of first)

; answer-of
(define answer-of second)

; *cond
(define *cond
  (lambda (e table)
    (evcon (cond-lines-of e) table)))

; cond-lines-of
(define cond-lines-of cdr)

; evlis
(define evlis
  (lambda (args table)
    (cond
     ((null? args) (quote ()))
     (else
      (cons (meaning (car args) table)
            (evlis (cdr args) table))))))

; *application
(define *application
  (lambda (e table)
    (apply
     (meaning (function-of e) table)
     (evlis (arguments-of e) table))))

; function-of
(define function-of car)

; arguments-of 
(define arguments-of cdr)

; premitive?
(define primitive?
  (lambda (l)
    (eq? (first l) (quote primitive))))

; non-premitive?
(define non-primitive?
  (lambda (l)
    (eq? (first l) (quote non-primitive))))

; apply
(define apply
  (lambda (fun vals)
    (cond
     ((primitive? fun)
      (apply-primitive (second fun) vals))
     ((non-primitive? fun)
      (apply-closure (second fun) vals)))))" 0 2 (face font-lock-comment-delimiter-face) 2 19 (face font-lock-comment-face) 19 21 (face font-lock-comment-delimiter-face) 21 48 (face font-lock-comment-face) 49 51 (face font-lock-comment-delimiter-face) 51 72 (face font-lock-comment-face) 72 74 (face font-lock-comment-delimiter-face) 74 121 (face font-lock-comment-face) 121 123 (face font-lock-comment-delimiter-face) 123 161 (face font-lock-comment-face) 162 168 (face font-lock-keyword-face) 169 189 (face font-lock-function-name-face) 193 199 (face font-lock-keyword-face) 233 237 (face font-lock-keyword-face) 323 327 (face font-lock-keyword-face) 407 409 (face font-lock-comment-delimiter-face) 409 425 (face font-lock-comment-face) 425 427 (face font-lock-comment-delimiter-face) 427 474 (face font-lock-comment-face) 475 481 (face font-lock-keyword-face) 482 497 (face font-lock-function-name-face) 501 507 (face font-lock-keyword-face) 601 603 (face font-lock-comment-delimiter-face) 603 622 (face font-lock-comment-face) 623 625 (face font-lock-comment-delimiter-face) 625 641 (face font-lock-comment-face) 641 643 (face font-lock-comment-delimiter-face) 643 683 (face font-lock-comment-face) 683 685 (face font-lock-comment-delimiter-face) 685 743 (face font-lock-comment-face) 744 750 (face font-lock-keyword-face) 751 766 (face font-lock-function-name-face) 770 776 (face font-lock-keyword-face) 803 807 (face font-lock-keyword-face) 850 854 (face font-lock-keyword-face) 913 919 (face font-lock-keyword-face) 986 988 (face font-lock-comment-delimiter-face) 988 1003 (face font-lock-comment-face) 1004 1010 (face font-lock-keyword-face) 1011 1025 (face font-lock-function-name-face) 1029 1035 (face font-lock-keyword-face) 1045 1049 (face font-lock-keyword-face) 1485 1489 (face font-lock-keyword-face) 1507 1509 (face font-lock-comment-delimiter-face) 1509 1524 (face font-lock-comment-face) 1525 1531 (face font-lock-keyword-face) 1532 1546 (face font-lock-function-name-face) 1550 1556 (face font-lock-keyword-face) 1566 1570 (face font-lock-keyword-face) 1601 1605 (face font-lock-keyword-face) 1746 1750 (face font-lock-keyword-face) 1773 1777 (face font-lock-keyword-face) 1796 1798 (face font-lock-comment-delimiter-face) 1798 1819 (face font-lock-comment-face) 1820 1826 (face font-lock-keyword-face) 1827 1847 (face font-lock-function-name-face) 1851 1857 (face font-lock-keyword-face) 1867 1871 (face font-lock-keyword-face) 1914 1918 (face font-lock-keyword-face) 1943 1945 (face font-lock-comment-delimiter-face) 1945 1953 (face font-lock-comment-face) 1954 1960 (face font-lock-keyword-face) 1961 1968 (face font-lock-function-name-face) 1972 1978 (face font-lock-keyword-face) 2031 2033 (face font-lock-comment-delimiter-face) 2033 2039 (face font-lock-comment-face) 2040 2046 (face font-lock-keyword-face) 2047 2052 (face font-lock-function-name-face) 2056 2062 (face font-lock-keyword-face) 2097 2099 (face font-lock-comment-delimiter-face) 2099 2106 (face font-lock-comment-face) 2107 2113 (face font-lock-keyword-face) 2114 2120 (face font-lock-function-name-face) 2124 2130 (face font-lock-keyword-face) 2146 2150 (face font-lock-keyword-face) 2220 2224 (face font-lock-keyword-face) 2265 2267 (face font-lock-comment-delimiter-face) 2267 2274 (face font-lock-comment-face) 2275 2281 (face font-lock-keyword-face) 2282 2288 (face font-lock-function-name-face) 2292 2298 (face font-lock-keyword-face) 2328 2330 (face font-lock-comment-delimiter-face) 2330 2338 (face font-lock-comment-face) 2339 2345 (face font-lock-keyword-face) 2346 2353 (face font-lock-function-name-face) 2363 2365 (face font-lock-comment-delimiter-face) 2365 2366 (face font-lock-comment-face) 2366 2377 (face font-lock-comment-face) 2378 2384 (face font-lock-keyword-face) 2385 2386 (face font-lock-function-name-face) 2386 2396 (face font-lock-function-name-face) 2400 2406 (face font-lock-keyword-face) 2464 2466 (face font-lock-comment-delimiter-face) 2466 2480 (face font-lock-comment-face) 2481 2487 (face font-lock-keyword-face) 2488 2501 (face font-lock-function-name-face) 2505 2511 (face font-lock-keyword-face) 2543 2545 (face font-lock-comment-delimiter-face) 2545 2551 (face font-lock-comment-face) 2552 2558 (face font-lock-keyword-face) 2559 2564 (face font-lock-function-name-face) 2568 2574 (face font-lock-keyword-face) 2594 2598 (face font-lock-keyword-face) 2781 2785 (face font-lock-keyword-face) 2817 2819 (face font-lock-comment-delimiter-face) 2819 2825 (face font-lock-comment-face) 2826 2832 (face font-lock-keyword-face) 2833 2838 (face font-lock-function-name-face) 2842 2848 (face font-lock-keyword-face) 2858 2862 (face font-lock-keyword-face) 2907 2911 (face font-lock-keyword-face) 2920 2922 (face font-lock-comment-delimiter-face) 2922 2935 (face font-lock-comment-face) 2936 2942 (face font-lock-keyword-face) 2943 2954 (face font-lock-function-name-face) 2963 2965 (face font-lock-comment-delimiter-face) 2965 2975 (face font-lock-comment-face) 2976 2982 (face font-lock-keyword-face) 2983 2992 (face font-lock-function-name-face) 3002 3004 (face font-lock-comment-delimiter-face) 3004 3010 (face font-lock-comment-face) 3011 3017 (face font-lock-keyword-face) 3018 3023 (face font-lock-function-name-face) 3027 3033 (face font-lock-keyword-face) 3083 3085 (face font-lock-comment-delimiter-face) 3085 3099 (face font-lock-comment-face) 3100 3106 (face font-lock-keyword-face) 3107 3120 (face font-lock-function-name-face) 3127 3129 (face font-lock-comment-delimiter-face) 3129 3135 (face font-lock-comment-face) 3136 3142 (face font-lock-keyword-face) 3143 3148 (face font-lock-function-name-face) 3152 3158 (face font-lock-keyword-face) 3177 3181 (face font-lock-keyword-face) 3219 3223 (face font-lock-keyword-face) 3306 3308 (face font-lock-comment-delimiter-face) 3308 3321 (face font-lock-comment-face) 3322 3328 (face font-lock-keyword-face) 3329 3341 (face font-lock-function-name-face) 3345 3351 (face font-lock-keyword-face) 3450 3452 (face font-lock-comment-delimiter-face) 3452 3464 (face font-lock-comment-face) 3465 3471 (face font-lock-keyword-face) 3472 3483 (face font-lock-function-name-face) 3490 3492 (face font-lock-comment-delimiter-face) 3492 3506 (face font-lock-comment-face) 3506 3507 (fontified t) 3507 3513 (fontified t face font-lock-keyword-face) 3513 3514 (fontified t) 3514 3526 (fontified t face font-lock-function-name-face) 3526 3532 (fontified t) 3532 3533 (fontified t) 3533 3535 (fontified t face font-lock-comment-delimiter-face) 3535 3546 (fontified t face font-lock-comment-face) 3546 3547 (fontified t) 3547 3553 (fontified t face font-lock-keyword-face) 3553 3554 (fontified t) 3554 3564 (fontified t face font-lock-function-name-face) 3564 3565 (fontified t) 3565 3568 (fontified t) 3568 3574 (fontified t face font-lock-keyword-face) 3574 3579 (fontified t) 3579 3619 (fontified t) 3619 3620 (fontified t) 3620 3622 (fontified t face font-lock-comment-delimiter-face) 3622 3637 (fontified t face font-lock-comment-face) 3637 3638 (fontified t) 3638 3644 (fontified t face font-lock-keyword-face) 3644 3645 (fontified t) 3645 3659 (fontified t face font-lock-function-name-face) 3659 3660 (fontified t) 3660 3663 (fontified t) 3663 3669 (fontified t face font-lock-keyword-face) 3669 3674 (fontified t) 3674 3718 (fontified t) 3718 3719 (fontified t) 3719 3721 (fontified t face font-lock-comment-delimiter-face) 3721 3727 (fontified t face font-lock-comment-face) 3727 3728 (fontified t) 3728 3734 (fontified t face font-lock-keyword-face) 3734 3735 (fontified t) 3735 3740 (fontified t face font-lock-function-name-face) 3740 3741 (fontified t) 3741 3744 (fontified t) 3744 3750 (fontified t face font-lock-keyword-face) 3750 3762 (fontified t) 3762 3767 (fontified t) 3767 3771 (fontified t face font-lock-keyword-face) 3771 3772 (fontified t) 3772 3795 (fontified t) 3795 3838 (fontified t) 3838 3865 (fontified t) 3865 3908 (fontified t)) . 23497) ((marker . 23497) . -1003) ((marker) . -1003) ((marker . 23497) . -1524) ((marker) . -1524) ((marker . 23497) . -955) ((marker) . -955) ((marker) . -2226) ((marker) . -2106) ((marker . 23497) . -2386) ((marker) . -2386) ((marker) . -3557) ((marker . 426) . -3506) ((marker*) . 45) ((marker) . -3864) ((marker*) . 64) ((marker) . -3845) nil (23497 . 27405) nil (5113 . 5114) nil (#("r" 0 1 (fontified t)) . -5113) nil (#("; エントリとはリストのペアであり、
; 第１リストが集合であり、２つのリストは同じ長さである

; lookup-in-entry-help
; キー(names)と値(values)を取り、指定されたキー名(name)に対応する値を返す
; キー名が(names)にない場合、(entry-f)に(name)をかける
(define lookup-in-entry-help
  (lambda (name names values entry-f)
    (cond
     ((null? names) (entry-f name))
     ((eq? (car names) name) (car values))
     (else
      (lookup-in-entry-help
       name (cdr names) (cdr values) entry-f)))))

; lookup-in-entry
; エントリ(entry)をキーと値に分割し、(lookup-in-entry-help)に渡す
(define lookup-in-entry
  (lambda (name entry entry-f)
    (lookup-in-entry-help name (first entry) (second entry) entry-f)))

; テーブル(環境)とはエントリのリスト

; lookup-in-table
; テーブルの１つのエントリを取り出し、(lookup-in-entry)にかける
; (entry-f)に残りのエントリを調べるべく再び(lookup-in-table)に再帰してくるように関数を渡す
(define lookup-in-table
  (lambda (name table table-f)
    (cond
     ((null? table) (table-f name))
     (else 
      (lookup-in-entry 
       name (car table) 
       (lambda (name)
         (lookup-in-table name (cdr table) table-f)))))))

; atom-to-action
(define atom-to-action
  (lambda (e)
    (cond
     ((number? e) *const)
     ((eq? e #t) *const)
     ((eq? e #f) *const)
     ((eq? e (quote cons)) *const)
     ((eq? e (quote car)) *const)
     ((eq? e (quote cdr)) *const)
     ((eq? e (quote null?)) *const)
     ((eq? e (quote eq?)) *const)
     ((eq? e (quote atom?)) *const)
     ((eq? e (quote zero?)) *const)
     ((eq? e (quote add1)) *const)
     ((eq? e (quote sub1)) *const)
     ((eq? e (quote number?)) *const)
     (else *identifier))))

; list-to-action
(define list-to-action
  (lambda (e)
    (cond
     ((atom? (car e)) 
      (cond
       ((eq? (car e) (quote quote)) *quote)
       ((eq? (car e) (quote lambda)) *lambda)
       ((eq? (car e) (quote cond)) *cond)
       (else *application)))
     (else *application))))

; expression-to-action
(define expression-to-action
  (lambda (e)
    (cond
     ((atom? e) (atom-to-action e))
     (else (list-to-action e)))))

; meaning
(define meaning
  (lambda (e table)
    ((expression-to-action e) e table)))

; value
(define value
  (lambda (e)
    (meaning e (quote ()))))

; *const
(define *const
  (lambda (e table)
    (cond
     ((number? e) e)
     ((eq? e #t) #t)
     ((eq? e #f) #f)
     (else 
      (build (quote primitive) e)))))

; *quote
(define *quote
  (lambda (e table)
    (test-of e)))

; test-of
(define test-of second)

; *identifier
(define *identifier
  (lambda (e table)
    (lookup-in-table e table initial-table)))

; initial-table
(define initial-table
  (lambda (name)
    (car (quote ()))))

; evcon
(define evcon
  (lambda (lines table)
    (cond
     ((else? (question-of (car lines)))
      (meaning (answer-of (car lines)) table))
     ((meaning (question-of (car lines)) table)
      (meaning (answer-of (car lines))))
     (else (evcon (cdr lines) table)))))

; else?
(define else?
  (lambda (x)
    (cond
     ((atom? x) (eq? x (quote else)))
     (else #f))))

; question-of 
(define question-of first)

; answer-of
(define answer-of second)

; *cond
(define *cond
  (lambda (e table)
    (evcon (cond-lines-of e) table)))

; cond-lines-of
(define cond-lines-of cdr)

; evlis
(define evlis
  (lambda (args table)
    (cond
     ((null? args) (quote ()))
     (else
      (cons (meaning (car args) table)
            (evlis (cdr args) table))))))

; *application
(define *application
  (lambda (e table)
    (apply
     (meaning (function-of e) table)
     (evlis (arguments-of e) table))))

; function-of
(define function-of car)

; arguments-of 
(define arguments-of cdr)

; premitive?
(define primitive?
  (lambda (l)
    (eq? (first l) (quote primitive))))

; non-premitive?
(define non-primitive?
  (lambda (l)
    (eq? (first l) (quote non-primitive))))

; apply
(define apply
  (lambda (fun vals)
    (cond
     ((primitive? fun)
      (apply-primitive (second fun) vals))
     ((non-primitive? fun)
      (apply-closure (second fun) vals)))))" 0 2 (fontified t face font-lock-comment-delimiter-face) 2 19 (fontified t face font-lock-comment-face) 19 21 (fontified t face font-lock-comment-delimiter-face) 21 48 (fontified t face font-lock-comment-face) 48 49 (fontified t) 49 51 (fontified t face font-lock-comment-delimiter-face) 51 72 (fontified t face font-lock-comment-face) 72 74 (fontified t face font-lock-comment-delimiter-face) 74 121 (fontified t face font-lock-comment-face) 121 123 (fontified t face font-lock-comment-delimiter-face) 123 161 (fontified t face font-lock-comment-face) 161 162 (fontified t) 162 168 (fontified t face font-lock-keyword-face) 168 169 (fontified t) 169 189 (fontified t face font-lock-function-name-face) 189 193 (fontified t) 193 199 (fontified t face font-lock-keyword-face) 199 233 (fontified t) 233 237 (fontified t face font-lock-keyword-face) 237 323 (fontified t) 323 327 (fontified t face font-lock-keyword-face) 327 356 (fontified t) 356 407 (fontified t) 407 409 (fontified t face font-lock-comment-delimiter-face) 409 425 (fontified t face font-lock-comment-face) 425 427 (fontified t face font-lock-comment-delimiter-face) 427 474 (fontified t face font-lock-comment-face) 474 475 (fontified t) 475 481 (fontified t face font-lock-keyword-face) 481 482 (fontified t) 482 497 (fontified t face font-lock-function-name-face) 497 501 (fontified t) 501 507 (fontified t face font-lock-keyword-face) 507 601 (fontified t) 601 603 (fontified t face font-lock-comment-delimiter-face) 603 622 (fontified t face font-lock-comment-face) 622 623 (fontified t) 623 625 (fontified t face font-lock-comment-delimiter-face) 625 641 (fontified t face font-lock-comment-face) 641 643 (fontified t face font-lock-comment-delimiter-face) 643 683 (fontified t face font-lock-comment-face) 683 685 (fontified t face font-lock-comment-delimiter-face) 685 743 (fontified t face font-lock-comment-face) 743 744 (fontified t) 744 750 (fontified t face font-lock-keyword-face) 750 751 (fontified t) 751 766 (fontified t face font-lock-function-name-face) 766 770 (fontified t) 770 776 (fontified t face font-lock-keyword-face) 776 803 (fontified t) 803 807 (fontified t face font-lock-keyword-face) 807 850 (fontified t) 850 854 (fontified t face font-lock-keyword-face) 854 856 (fontified t) 856 880 (fontified t) 880 913 (fontified t) 913 919 (fontified t face font-lock-keyword-face) 919 986 (fontified t) 986 988 (fontified t face font-lock-comment-delimiter-face) 988 1003 (fontified t face font-lock-comment-face) 1003 1004 (fontified t) 1004 1010 (fontified t face font-lock-keyword-face) 1010 1011 (fontified t) 1011 1025 (fontified t face font-lock-function-name-face) 1025 1026 (fontified t) 1026 1029 (fontified t) 1029 1035 (fontified t face font-lock-keyword-face) 1035 1040 (fontified t) 1040 1045 (fontified t) 1045 1049 (fontified t face font-lock-keyword-face) 1049 1050 (fontified t) 1050 1076 (fontified t) 1076 1101 (fontified t) 1101 1126 (fontified t) 1126 1161 (fontified t) 1161 1195 (fontified t) 1195 1229 (fontified t) 1229 1265 (fontified t) 1265 1299 (fontified t) 1299 1335 (fontified t) 1335 1371 (fontified t) 1371 1406 (fontified t) 1406 1441 (fontified t) 1441 1479 (fontified t) 1479 1485 (fontified t) 1485 1489 (fontified t face font-lock-keyword-face) 1489 1506 (fontified t) 1506 1507 (fontified t) 1507 1509 (fontified t face font-lock-comment-delimiter-face) 1509 1524 (fontified t face font-lock-comment-face) 1524 1525 (fontified t) 1525 1531 (fontified t face font-lock-keyword-face) 1531 1532 (fontified t) 1532 1546 (fontified t face font-lock-function-name-face) 1546 1547 (fontified t) 1547 1550 (fontified t) 1550 1556 (fontified t face font-lock-keyword-face) 1556 1561 (fontified t) 1561 1566 (fontified t) 1566 1570 (fontified t face font-lock-keyword-face) 1570 1571 (fontified t) 1571 1594 (fontified t) 1594 1601 (fontified t) 1601 1605 (fontified t face font-lock-keyword-face) 1605 1606 (fontified t) 1606 1650 (fontified t) 1650 1696 (fontified t) 1696 1738 (fontified t) 1738 1746 (fontified t) 1746 1750 (fontified t face font-lock-keyword-face) 1750 1767 (fontified t) 1767 1773 (fontified t) 1773 1777 (fontified t face font-lock-keyword-face) 1777 1794 (fontified t) 1794 1795 (fontified t) 1795 1796 (fontified t) 1796 1798 (fontified t face font-lock-comment-delimiter-face) 1798 1819 (fontified t face font-lock-comment-face) 1819 1820 (fontified t) 1820 1826 (fontified t face font-lock-keyword-face) 1826 1827 (fontified t) 1827 1847 (fontified t face font-lock-function-name-face) 1847 1848 (fontified t) 1848 1851 (fontified t) 1851 1857 (fontified t face font-lock-keyword-face) 1857 1862 (fontified t) 1862 1867 (fontified t) 1867 1871 (fontified t face font-lock-keyword-face) 1871 1872 (fontified t) 1872 1908 (fontified t) 1908 1914 (fontified t) 1914 1918 (fontified t face font-lock-keyword-face) 1918 1942 (fontified t) 1942 1943 (fontified t) 1943 1945 (fontified t face font-lock-comment-delimiter-face) 1945 1953 (fontified t face font-lock-comment-face) 1953 1954 (fontified t) 1954 1960 (fontified t face font-lock-keyword-face) 1960 1961 (fontified t) 1961 1968 (fontified t face font-lock-function-name-face) 1968 1969 (fontified t) 1969 1972 (fontified t) 1972 1978 (fontified t face font-lock-keyword-face) 1978 1989 (fontified t) 1989 2029 (fontified t) 2029 2030 (fontified t) 2030 2031 (fontified t) 2031 2033 (fontified t face font-lock-comment-delimiter-face) 2033 2039 (fontified t face font-lock-comment-face) 2039 2040 (fontified t) 2040 2046 (fontified t face font-lock-keyword-face) 2046 2047 (fontified t) 2047 2052 (fontified t face font-lock-function-name-face) 2052 2053 (fontified t) 2053 2056 (fontified t) 2056 2062 (fontified t face font-lock-keyword-face) 2062 2067 (fontified t) 2067 2096 (fontified t) 2096 2097 (fontified t) 2097 2099 (fontified t face font-lock-comment-delimiter-face) 2099 2106 (fontified t face font-lock-comment-face) 2106 2107 (fontified t) 2107 2113 (fontified t face font-lock-keyword-face) 2113 2114 (fontified t) 2114 2120 (fontified t face font-lock-function-name-face) 2120 2121 (fontified t) 2121 2124 (fontified t) 2124 2130 (fontified t face font-lock-keyword-face) 2130 2141 (fontified t) 2141 2146 (fontified t) 2146 2150 (fontified t face font-lock-keyword-face) 2150 2151 (fontified t) 2151 2172 (fontified t) 2172 2193 (fontified t) 2193 2214 (fontified t) 2214 2220 (fontified t) 2220 2224 (fontified t face font-lock-keyword-face) 2224 2226 (fontified t) 2226 2264 (fontified t) 2264 2265 (fontified t) 2265 2267 (fontified t face font-lock-comment-delimiter-face) 2267 2274 (fontified t face font-lock-comment-face) 2274 2275 (fontified t) 2275 2281 (fontified t face font-lock-keyword-face) 2281 2282 (fontified t) 2282 2288 (fontified t face font-lock-function-name-face) 2288 2289 (fontified t) 2289 2292 (fontified t) 2292 2298 (fontified t face font-lock-keyword-face) 2298 2309 (fontified t) 2309 2327 (fontified t) 2327 2328 (fontified t) 2328 2330 (fontified t face font-lock-comment-delimiter-face) 2330 2338 (fontified t face font-lock-comment-face) 2338 2339 (fontified t) 2339 2345 (fontified t face font-lock-keyword-face) 2345 2346 (fontified t) 2346 2353 (fontified t face font-lock-function-name-face) 2353 2362 (fontified t) 2362 2363 (fontified t) 2363 2365 (fontified t face font-lock-comment-delimiter-face) 2365 2366 (fontified t face font-lock-comment-face) 2366 2377 (fontified t face font-lock-comment-face) 2377 2378 (fontified t) 2378 2384 (fontified t face font-lock-keyword-face) 2384 2385 (fontified t) 2385 2386 (fontified t face font-lock-function-name-face) 2386 2396 (fontified t face font-lock-function-name-face) 2396 2397 (fontified t) 2397 2400 (fontified t) 2400 2406 (fontified t face font-lock-keyword-face) 2406 2417 (fontified t) 2417 2463 (fontified t) 2463 2464 (fontified t) 2464 2466 (fontified t face font-lock-comment-delimiter-face) 2466 2480 (fontified t face font-lock-comment-face) 2480 2481 (fontified t) 2481 2487 (fontified t face font-lock-keyword-face) 2487 2488 (fontified t) 2488 2501 (fontified t face font-lock-function-name-face) 2501 2502 (fontified t) 2502 2505 (fontified t) 2505 2511 (fontified t face font-lock-keyword-face) 2511 2519 (fontified t) 2519 2542 (fontified t) 2542 2543 (fontified t) 2543 2545 (fontified t face font-lock-comment-delimiter-face) 2545 2551 (fontified t face font-lock-comment-face) 2551 2552 (fontified t) 2552 2558 (fontified t face font-lock-keyword-face) 2558 2559 (fontified t) 2559 2564 (fontified t face font-lock-function-name-face) 2564 2565 (fontified t) 2565 2568 (fontified t) 2568 2574 (fontified t face font-lock-keyword-face) 2574 2589 (fontified t) 2589 2594 (fontified t) 2594 2598 (fontified t face font-lock-keyword-face) 2598 2599 (fontified t) 2599 2606 (fontified t) 2606 2639 (fontified t) 2639 2686 (fontified t) 2686 2734 (fontified t) 2734 2775 (fontified t) 2775 2781 (fontified t) 2781 2785 (fontified t face font-lock-keyword-face) 2785 2816 (fontified t) 2816 2817 (fontified t) 2817 2819 (fontified t face font-lock-comment-delimiter-face) 2819 2825 (fontified t face font-lock-comment-face) 2825 2826 (fontified t) 2826 2832 (fontified t face font-lock-keyword-face) 2832 2833 (fontified t) 2833 2838 (fontified t face font-lock-function-name-face) 2838 2839 (fontified t) 2839 2842 (fontified t) 2842 2848 (fontified t face font-lock-keyword-face) 2848 2853 (fontified t) 2853 2858 (fontified t) 2858 2862 (fontified t face font-lock-keyword-face) 2862 2863 (fontified t) 2863 2901 (fontified t) 2901 2907 (fontified t) 2907 2911 (fontified t face font-lock-keyword-face) 2911 2919 (fontified t) 2919 2920 (fontified t) 2920 2922 (fontified t face font-lock-comment-delimiter-face) 2922 2935 (fontified t face font-lock-comment-face) 2935 2936 (fontified t) 2936 2942 (fontified t face font-lock-keyword-face) 2942 2943 (fontified t) 2943 2954 (fontified t face font-lock-function-name-face) 2954 2962 (fontified t) 2962 2963 (fontified t) 2963 2965 (fontified t face font-lock-comment-delimiter-face) 2965 2975 (fontified t face font-lock-comment-face) 2975 2976 (fontified t) 2976 2982 (fontified t face font-lock-keyword-face) 2982 2983 (fontified t) 2983 2992 (fontified t face font-lock-function-name-face) 2992 3001 (fontified t) 3001 3002 (fontified t) 3002 3004 (fontified t face font-lock-comment-delimiter-face) 3004 3010 (fontified t face font-lock-comment-face) 3010 3011 (fontified t) 3011 3017 (fontified t face font-lock-keyword-face) 3017 3018 (fontified t) 3018 3023 (fontified t face font-lock-function-name-face) 3023 3024 (fontified t) 3024 3027 (fontified t) 3027 3033 (fontified t face font-lock-keyword-face) 3033 3044 (fontified t) 3044 3056 (fontified t) 3056 3082 (fontified t) 3082 3083 (fontified t) 3083 3085 (fontified t face font-lock-comment-delimiter-face) 3085 3099 (fontified t face font-lock-comment-face) 3099 3100 (fontified t) 3100 3106 (fontified t face font-lock-keyword-face) 3106 3107 (fontified t) 3107 3120 (fontified t face font-lock-function-name-face) 3120 3126 (fontified t) 3126 3127 (fontified t) 3127 3129 (fontified t face font-lock-comment-delimiter-face) 3129 3135 (fontified t face font-lock-comment-face) 3135 3136 (fontified t) 3136 3142 (fontified t face font-lock-keyword-face) 3142 3143 (fontified t) 3143 3148 (fontified t face font-lock-function-name-face) 3148 3149 (fontified t) 3149 3152 (fontified t) 3152 3158 (fontified t face font-lock-keyword-face) 3158 3172 (fontified t) 3172 3177 (fontified t) 3177 3181 (fontified t face font-lock-keyword-face) 3181 3182 (fontified t) 3182 3213 (fontified t) 3213 3219 (fontified t) 3219 3223 (fontified t face font-lock-keyword-face) 3223 3224 (fontified t) 3224 3263 (fontified t) 3263 3305 (fontified t) 3305 3306 (fontified t) 3306 3308 (fontified t face font-lock-comment-delimiter-face) 3308 3321 (fontified t face font-lock-comment-face) 3321 3322 (fontified t) 3322 3328 (fontified t face font-lock-keyword-face) 3328 3329 (fontified t) 3329 3341 (fontified t face font-lock-function-name-face) 3341 3342 (fontified t) 3342 3345 (fontified t) 3345 3351 (fontified t face font-lock-keyword-face) 3351 3362 (fontified t) 3362 3373 (fontified t) 3373 3410 (fontified t) 3410 3449 (fontified t) 3449 3450 (fontified t) 3450 3452 (fontified t face font-lock-comment-delimiter-face) 3452 3464 (fontified t face font-lock-comment-face) 3464 3465 (fontified t) 3465 3471 (fontified t face font-lock-keyword-face) 3471 3472 (fontified t) 3472 3483 (fontified t face font-lock-function-name-face) 3483 3489 (fontified t) 3489 3490 (fontified t) 3490 3492 (fontified t face font-lock-comment-delimiter-face) 3492 3506 (fontified t face font-lock-comment-face) 3506 3507 (fontified t) 3507 3513 (fontified t face font-lock-keyword-face) 3513 3514 (fontified t) 3514 3526 (fontified t face font-lock-function-name-face) 3526 3532 (fontified t) 3532 3533 (fontified t) 3533 3535 (fontified t face font-lock-comment-delimiter-face) 3535 3546 (fontified t face font-lock-comment-face) 3546 3547 (fontified t) 3547 3553 (fontified t face font-lock-keyword-face) 3553 3554 (fontified t) 3554 3564 (fontified t face font-lock-function-name-face) 3564 3565 (fontified t) 3565 3568 (fontified t) 3568 3574 (fontified t face font-lock-keyword-face) 3574 3579 (fontified t) 3579 3619 (fontified t) 3619 3620 (fontified t) 3620 3622 (fontified t face font-lock-comment-delimiter-face) 3622 3637 (fontified t face font-lock-comment-face) 3637 3638 (fontified t) 3638 3644 (fontified t face font-lock-keyword-face) 3644 3645 (fontified t) 3645 3659 (fontified t face font-lock-function-name-face) 3659 3660 (fontified t) 3660 3663 (fontified t) 3663 3669 (fontified t face font-lock-keyword-face) 3669 3674 (fontified t) 3674 3718 (fontified t) 3718 3719 (fontified t) 3719 3721 (fontified t face font-lock-comment-delimiter-face) 3721 3727 (fontified t face font-lock-comment-face) 3727 3728 (fontified t) 3728 3734 (fontified t face font-lock-keyword-face) 3734 3735 (fontified t) 3735 3740 (fontified t face font-lock-function-name-face) 3740 3741 (fontified t) 3741 3744 (fontified t) 3744 3750 (fontified t face font-lock-keyword-face) 3750 3762 (fontified t) 3762 3767 (fontified t) 3767 3771 (fontified t face font-lock-keyword-face) 3771 3772 (fontified t) 3772 3795 (fontified t) 3795 3838 (fontified t) 3838 3865 (fontified t) 3865 3908 (fontified t)) . -23497) ((marker . 2954) . -2263) ((marker . 23497) . -1003) ((marker) . -1003) ((marker) . -1505) ((marker) . -1003) ((marker . 23497) . -1524) ((marker) . -1524) ((marker . 23497) . -955) ((marker) . -955) ((marker) . -2226) ((marker) . -2106) ((marker . 23497) . -2386) ((marker) . -2386) ((marker . 2954) . -2351) ((marker . 426) . -3182) ((marker) . -3557) ((marker*) . 1) ((marker) . -3908) ((marker*) . 181) ((marker) . -3728) nil (27404 . 27405) nil (27403 . 27404) nil (27402 . 27403) nil (27401 . 27402) nil (27395 . 27401) nil (27384 . 27395) nil (#("d" 0 1 (fontified t)) . -27384) nil (27376 . 27385) nil (#("o" 0 1 (fontified t)) . -27376) nil (27368 . 27377) nil (27362 . 27368) nil (27361 . 27362) nil (27348 . 27361) nil (#("e" 0 1 (fontified t)) . -27348) nil (#("m" 0 1 (fontified t)) . -27349) nil (#("i" 0 1 (fontified t)) . -27350) nil (27340 . 27351) nil (27335 . 27340) nil (27334 . 27335) nil (27333 . 27334) nil (27327 . 27333) nil (27310 . 27327) nil (27053 . 27054) nil (#("e" 0 1 (fontified t face font-lock-function-name-face)) . -27053) nil (27148 . 27149) nil (#("e" 0 1 (fontified t face font-lock-function-name-face)) . -27148) nil (27203 . 27204) nil (#("e" 0 1 (fontified t)) . 27203) nil (27307 . 27310) nil (#("e" 0 1 (fontified t)) . -27307) nil (#("m" 0 1 (fontified t)) . -27308) nil (#("i" 0 1 (fontified t)) . -27309) nil (27298 . 27310) nil (27292 . 27298) nil (27291 . 27292) nil (27278 . 27291) nil (#("e" 0 1 (fontified t)) . -27278) nil (27274 . 27279) nil (27269 . 27274) nil (27268 . 27269) nil (27263 . 27268) nil (27259 . 27263) nil (27258 . 27259) nil (27240 . 27258) nil (27238 . 27240) nil (27237 . 27238) nil (27223 . 27237) nil (27215 . 27223) nil (27214 . 27215) nil (27213 . 27214) nil (27212 . 27213) nil (27211 . 27212) nil (27209 . 27211) nil (27189 . 27209) nil (27175 . 27189) nil (27171 . 27175) nil (27170 . 27171) nil (27159 . 27170) nil (27157 . 27159) nil (27156 . 27157) nil (27153 . 27156) nil (27133 . 27153) nil (27116 . 27133) nil (27115 . 27116) nil (27114 . 27115) nil (27113 . 27114) nil (27112 . 27113) nil (27109 . 27112) nil (#("r" 0 1 (fontified t)) . -27109) nil (27094 . 27110) nil (27080 . 27094) nil (27076 . 27080) nil (27075 . 27076) nil (27064 . 27075) nil (27062 . 27064) nil (27061 . 27062) nil (27042 . 27061) nil (27029 . 27042) nil (27028 . 27029) nil (27022 . 27028) nil (27002 . 27022) nil (26986 . 27002) nil (26985 . 26986) nil (26980 . 26985) nil (26960 . 26980) nil (26946 . 26960) nil (26945 . 26946) nil (26944 . 26945) nil (26943 . 26944) nil (26942 . 26943) nil (26935 . 26942) nil (26932 . 26935) nil (26912 . 26932) nil (26907 . 26912) nil (26906 . 26907) nil (26899 . 26906) nil (26895 . 26899) nil (26875 . 26895) nil (26870 . 26875) nil (26869 . 26870) nil (26863 . 26869) nil (26859 . 26863) nil (26858 . 26859) nil (26841 . 26858) nil (26839 . 26841) nil (26838 . 26839) nil (26818 . 26838) nil (26817 . 26818) nil (26802 . 26817) nil (26801 . 26802) nil (26800 . 26801) nil (26799 . 26800) nil (26798 . 26799) nil (26797 . 26798) nil (26796 . 26797) nil (26789 . 26796) nil (26772 . 26789) nil (26760 . 26772) nil (26759 . 26760) nil (26752 . 26759) nil (26747 . 26752) nil (26727 . 26747) nil (26721 . 26727) nil (26720 . 26721) nil (26715 . 26720) nil (26710 . 26715) nil (26709 . 26710) nil (26708 . 26709) nil (26707 . 26708) nil (26697 . 26707) nil (26684 . 26697) nil (26679 . 26684) nil (26678 . 26679) nil (26673 . 26678) nil (26669 . 26673) nil (26668 . 26669) nil (26648 . 26668) nil (26646 . 26648) nil (26645 . 26646) nil (26631 . 26645) nil (26623 . 26631) nil (26622 . 26623) nil (26615 . 26622) nil (26595 . 26615) nil (26579 . 26595) nil (26578 . 26579) nil (26577 . 26578) nil (26576 . 26577) nil (26569 . 26576) nil (26565 . 26569) nil (26545 . 26565) nil (26541 . 26545) nil (26540 . 26541) nil (26523 . 26540) nil (26521 . 26523) nil (26520 . 26521) nil (26506 . 26520) nil (#("?" 0 1 (fontified t face font-lock-comment-face)) . -26506) nil (26498 . 26507) nil (26497 . 26498) nil (26491 . 26497) nil (26471 . 26491) nil (26459 . 26471) nil (26458 . 26459) nil (26454 . 26458) nil (#("s" 0 1 (fontified t)) . -26454) nil (26451 . 26455) nil (26431 . 26451) nil (#("f" 0 1 (fontified t face font-lock-comment-face)) . -26431) nil (#("i" 0 1 (fontified t face font-lock-comment-face)) . -26432) nil (#("r" 0 1 (fontified t face font-lock-comment-face)) . -26433) nil (#("s" 0 1 (fontified t face font-lock-comment-face)) . -26434) nil (#("t" 0 1 (fontified t face font-lock-comment-face)) . -26435) nil (26419 . 26436) nil (#("q" 0 1 (fontified t face font-lock-comment-face)) . -26419) nil (26416 . 26420) nil (26415 . 26416) nil (26414 . 26415) nil (26413 . 26414) nil (26412 . 26413) nil (26403 . 26412) nil (26398 . 26403) nil (26397 . 26398) nil (26396 . 26397) nil (26395 . 26396) nil (26375 . 26395) nil (26365 . 26375) nil (26360 . 26365) nil (26359 . 26360) nil (26354 . 26359) nil (26350 . 26354) nil (26349 . 26350) nil (26338 . 26349) nil (26336 . 26338) nil (26335 . 26336) nil (26321 . 26335) nil (26313 . 26321) nil (26312 . 26313) nil (26311 . 26312) nil (26310 . 26311) nil (26309 . 26310) nil (26308 . 26309) nil (26301 . 26308) nil (26297 . 26301) nil (26277 . 26297) nil (26272 . 26277) nil (26271 . 26272) nil (26270 . 26271) nil (26269 . 26270) nil (26268 . 26269) nil (26253 . 26268) nil (#(" " 0 1 (fontified t)) . -26253) nil (26237 . 26254) nil (26231 . 26237) nil (26230 . 26231) nil (26223 . 26230) nil (26222 . 26223) nil (26208 . 26222) nil (26188 . 26208) nil (26183 . 26188) nil (26182 . 26183) nil (26181 . 26182) nil (26174 . 26181) nil (#(")" 0 1 (fontified t)) . -26174) ((marker*) . 1) ((marker) . -1) nil (#(")" 0 1 (fontified t)) . -26175) ((marker*) . 1) ((marker) . -1) nil (26175 . 26176) nil (26174 . 26175) nil (26173 . 26174) nil (26162 . 26173) nil (26142 . 26162) nil (26136 . 26142) nil (26135 . 26136) nil (26134 . 26135) nil (26133 . 26134) nil (26132 . 26133) nil (26112 . 26132) nil (#("s" 0 1 (fontified t)) . -26112) nil (26101 . 26113) nil (26096 . 26101) nil (26095 . 26096) nil (26090 . 26095) nil (26086 . 26090) nil (26085 . 26086) nil (26084 . 26085) nil (26064 . 26084) nil (26062 . 26064) nil (26061 . 26062) nil (26058 . 26061) nil (#("v" 0 1 (fontified t face font-lock-function-name-face)) . -26058) nil (26047 . 26059) nil (26039 . 26047) nil (26038 . 26039) nil (25882 . 25883) nil (25862 . 25863) nil (26035 . 26036) nil (26034 . 26035) nil (26033 . 26034) nil (26032 . 26033) nil (26029 . 26030) nil (26018 . 26031) nil (26014 . 26018) nil (26013 . 26014) nil (25999 . 26013) nil (25997 . 25999) nil (25996 . 25997) nil (25995 . 25996) nil (25975 . 25995) nil (25974 . 25975) nil (25958 . 25974) nil (25957 . 25958) nil (25956 . 25957) nil (25955 . 25956) nil (25936 . 25955) nil (25916 . 25936) nil (25912 . 25916) nil (25911 . 25912) nil (25902 . 25911) nil (#("8" 0 1 (fontified t)) . -25902) nil (#("e" 0 1 (fontified t)) . -25903) nil (25894 . 25904) nil (25892 . 25894) nil (25891 . 25892) nil (25872 . 25891) nil (25870 . 25872) nil (#("r" 0 1 (fontified t face font-lock-comment-face)) . -25870) nil (25868 . 25871) nil (#("r" 0 1 (fontified t face font-lock-comment-face)) . -25868) nil (25860 . 25869) nil (#("*" 0 1 (fontified t)) . -25860) nil (25859 . 25861) nil (25858 . 25859) nil (25854 . 25858) nil (25834 . 25854) nil (25824 . 25834) nil (25823 . 25824) nil (25822 . 25823) nil (25821 . 25822) nil (25810 . 25821) nil (25806 . 25810) nil (25805 . 25806) nil (25788 . 25805) nil (25786 . 25788) nil (25785 . 25786) nil (25770 . 25785) nil (25761 . 25770) nil (25760 . 25761) nil (25759 . 25760) nil (25758 . 25759) nil (25757 . 25758) nil (25756 . 25757) nil (25753 . 25756) nil (25749 . 25753) nil (25729 . 25749) nil (25723 . 25729) nil (25722 . 25723) nil (#("b" 0 1 (fontified t)) . -25722) nil (25716 . 25723) nil (25711 . 25716) nil (25710 . 25711) nil (25706 . 25710) nil (25695 . 25706) nil (25690 . 25695) nil (25689 . 25690) nil (25686 . 25689) nil (#("$" 0 1 (fontified t)) . -25686) nil (25686 . 25687) nil (#("%" 0 1 (fontified t)) . -25686) nil (25685 . 25687) nil (25674 . 25685) nil (25669 . 25674) nil (25668 . 25669) nil (25665 . 25668) nil (25653 . 25665) nil (25648 . 25653) nil (25647 . 25648) nil (25642 . 25647) nil (25638 . 25642) nil (25637 . 25638) nil (25632 . 25637) nil (#("b" 0 1 (fontified t)) . -25632) nil (25620 . 25633) nil (25618 . 25620) nil (25617 . 25618) nil (25602 . 25617) nil (25596 . 25602) nil (#("c" 0 1 (fontified t face font-lock-comment-face)) . -25596) nil (#("o" 0 1 (fontified t face font-lock-comment-face)) . -25597) nil (#("n" 0 1 (fontified t face font-lock-comment-face)) . -25598) nil (25593 . 25599) nil (25592 . 25593) nil (25525 . 25526) nil (25524 . 25525) nil (25515 . 25524) nil (25510 . 25515) nil (25490 . 25510) nil (25486 . 25490) nil (25485 . 25486) nil (25468 . 25485) nil (25466 . 25468) nil (25465 . 25466) nil (25449 . 25465) nil (25445 . 25449) nil (#("c" 0 1 (fontified t face font-lock-comment-face)) . -25445) nil (25440 . 25446) nil (25440 . 25441) nil (25439 . 25440) nil (25503 . 25504) nil (25502 . 25503) nil (25501 . 25502) nil (25500 . 25501) nil (25480 . 25500) nil (25476 . 25480) nil (25475 . 25476) nil (25464 . 25475) nil (25462 . 25464) nil (25461 . 25462) nil (25447 . 25461) nil (25439 . 25447) nil (25438 . 25439) nil (25290 . 25291) nil (25289 . 25290) nil (25288 . 25289) nil (25280 . 25288) nil (#("l" 0 1 (fontified t)) . -25280) nil (#("i" 0 1 (fontified t)) . -25281) nil (25269 . 25282) nil (25264 . 25269) nil (25263 . 25264) nil (25262 . 25263) nil (25261 . 25262) nil (25242 . 25261) nil (25235 . 25242) nil (25234 . 25235) nil (25227 . 25234) nil (25226 . 25227) nil (25213 . 25226) nil (25200 . 25213) nil (25193 . 25200) nil (25192 . 25193) nil (25186 . 25192) nil (#("m" 0 1 (fontified t)) . -25186) nil (#("a" 0 1 (fontified t)) . -25187) nil (#("b" 0 1 (fontified t)) . -25188) nil (#("d" 0 1 (fontified t)) . -25189) nil (#("a" 0 1 (fontified t)) . -25190) nil (25183 . 25191) nil (25182 . 25183) nil (25167 . 25182) nil (25154 . 25167) nil (25147 . 25154) nil (25146 . 25147) nil (25138 . 25146) nil (25137 . 25138) nil (25123 . 25137) nil (25110 . 25123) nil (25103 . 25110) nil (25102 . 25103) nil (25101 . 25102) nil (#("s" 0 1 (fontified t)) . -25101) nil (25097 . 25102) nil (25091 . 25097) nil (25090 . 25091) nil (25089 . 25090) nil (25088 . 25089) nil (25073 . 25088) nil (25068 . 25073) nil (25067 . 25068) nil (25062 . 25067) nil (25058 . 25062) nil (25057 . 25058) nil (25046 . 25057) nil (25044 . 25046) nil (25043 . 25044) nil (25040 . 25043) nil (25020 . 25040) nil (25003 . 25020) nil (25002 . 25003) nil (25148 . 25149) nil (25147 . 25148) nil (25146 . 25147) nil (25145 . 25146) nil (25136 . 25145) nil (#("c" 0 1 (fontified t)) . -25136) nil (#("a" 0 1 (fontified t)) . -25137) nil (#("t" 0 1 (fontified t)) . -25138) nil (25121 . 25139) nil (25116 . 25121) nil (25115 . 25116) nil (25114 . 25115) nil (25095 . 25114) nil (25085 . 25095) nil (25080 . 25085) nil (25079 . 25080) nil (25078 . 25079) nil (#("s" 0 1 (fontified t)) . -25078) nil (25074 . 25079) nil (25070 . 25074) nil (25069 . 25070) nil (25058 . 25069) nil (25056 . 25058) nil (25055 . 25056) nil (25045 . 25055) nil (#("g" 0 1 (fontified t face font-lock-function-name-face)) . -25045) nil (25026 . 25046) nil (25023 . 25026) nil (25003 . 25023) nil (25002 . 25003) nil (#(")" 0 1 (fontified t)) . -25002) ((marker*) . 1) ((marker) . -1) nil (25002 . 25003) nil (25001 . 25002) nil (25000 . 25001) nil (24999 . 25000) nil (24981 . 24999) nil (24976 . 24981) nil (24975 . 24976) nil (24967 . 24975) nil (24966 . 24967) nil (24963 . 24966) nil (24943 . 24963) nil (24938 . 24943) nil (24937 . 24938) nil (24929 . 24937) nil (24928 . 24929) nil (24908 . 24928) nil (24903 . 24908) nil (24902 . 24903) nil (24894 . 24902) nil (24893 . 24894) nil (24892 . 24893) nil (#("?" 0 1 (fontified t)) . -24892) nil (24873 . 24893) nil (24868 . 24873) nil (24867 . 24868) nil (24859 . 24867) nil (24858 . 24859) nil (24857 . 24858) nil (24837 . 24857) nil (24832 . 24837) nil (24831 . 24832) nil (24823 . 24831) nil (24822 . 24823) nil (24821 . 24822) nil (24801 . 24821) nil (24796 . 24801) nil (24795 . 24796) nil (24787 . 24795) nil (24786 . 24787) nil (24767 . 24786) nil (24762 . 24767) nil (24761 . 24762) nil (24753 . 24761) nil (24752 . 24753) nil (24748 . 24752) nil (#("u" 0 1 (fontified t)) . -24748) nil (24731 . 24749) nil (24726 . 24731) nil (24725 . 24726) nil (24717 . 24725) nil (24716 . 24717) nil (24697 . 24716) nil (24692 . 24697) nil (24691 . 24692) nil (24683 . 24691) nil (24682 . 24683) nil (24663 . 24682) nil (24658 . 24663) nil (24657 . 24658) nil (24649 . 24657) nil (24648 . 24649) nil (24647 . 24648) nil (#("t" 0 1 (fontified t)) . -24647) nil (24633 . 24648) nil (24609 . 24611) nil (24584 . 24586) nil (24624 . 24629) nil (24619 . 24624) nil (24618 . 24619) nil (24610 . 24618) nil (24607 . 24610) nil (#("$" 0 1 (fontified t)) . -24607) nil (24601 . 24608) nil (24596 . 24601) nil (24595 . 24596) nil (24587 . 24595) nil (24585 . 24587) nil (#("g" 0 1 (fontified t)) . -24585) nil (24578 . 24586) nil (24573 . 24578) nil (24572 . 24573) nil (24564 . 24572) nil (24552 . 24564) nil (24547 . 24552) nil (#("     " 0 5 (fontified t)) . 24547) nil (#("((or (number? e)" 0 2 (fontified t) 2 4 (fontified t face font-lock-keyword-face) 4 16 (fontified t)) . 24552) ((marker*) . 1) ((marker) . -16) ((marker*) . 11) ((marker) . -6) nil (#("
" 0 1 (fontified t)) . 24568) nil (#("          " 0 10 (fontified t)) . 24569) nil (24569 . 24579) nil (24568 . 24569) nil (24552 . 24568) nil (24547 . 24552) nil (#("     ((eq? e #t) *const)" 0 24 (fontified t)) . 24547) ((marker) . -24) nil (#("
" 0 1 (fontified t)) . 24547) ((marker) . -1) ((marker) . -1) ((marker) . -1) nil (#("     ((null? e) *const)" 0 23 (fontified t)) . 24547) ((marker) . -23) nil (24587 . 24595) nil (24584 . 24587) nil (#("%" 0 1 (fontified t)) . -24584) nil (24584 . 24585) nil (#("$" 0 1 (fontified t)) . -24584) nil (24576 . 24585) nil (24571 . 24576) nil (24570 . 24571) nil (24562 . 24570) nil (24552 . 24562) nil (24547 . 24552) nil (24546 . 24547) nil (24541 . 24546) nil (24537 . 24541) nil (24536 . 24537) nil (24525 . 24536) nil (24523 . 24525) nil (24522 . 24523) nil (24520 . 24522) nil (24500 . 24520) nil (#("    " 0 4 (fontified t)) . -24500) 24500 ((marker . 2954) . -4) ((marker . 23497) . -4) ((marker) . -4) nil (24499 . 24500) nil (24490 . 24499) nil (#("o" 0 1 (fontified t face font-lock-comment-face)) . -24490) nil (#("t" 0 1 (fontified t face font-lock-comment-face)) . -24491) nil (24486 . 24492) nil (#("c" 0 1 (fontified t face font-lock-comment-face)) . -24486) nil (24483 . 24487) nil (#("
" 0 1 (fontified t)) . 24483) nil (#("     (else 1))))" 0 6 (fontified t) 6 10 (fontified t face font-lock-keyword-face) 10 16 (fontified t)) . 24483) nil (#("
" 0 1 (fontified t)) . 24483) nil (#("     ((null? names) (f name))" 0 29 (fontified t)) . 24483) ((marker*) . 29) ((marker*) . 29) nil (#("
" 0 1 (fontified t)) . 24483) ((marker*) . 1) ((marker*) . 1) nil (#("    (cond" 0 5 (fontified t) 5 9 (fontified t face font-lock-keyword-face)) . 24483) ((marker*) . 9) ((marker*) . 9) nil (#("
" 0 1 (fontified t)) . 24483) ((marker*) . 1) ((marker*) . 1) nil (#("  (lambda (name names f)" 0 3 (fontified t) 3 9 (fontified t face font-lock-keyword-face) 9 24 (fontified t)) . 24483) ((marker*) . 24) ((marker*) . 24) nil (#("
" 0 1 (fontified t)) . 24483) ((marker*) . 1) ((marker*) . 1) nil (#("(define make0?" 0 1 (fontified t) 1 7 (fontified t face font-lock-keyword-face) 7 8 (fontified t) 8 14 (fontified t face font-lock-function-name-face)) . 24483) ((marker*) . 14) ((marker*) . 14) nil (#("
" 0 1 (fontified t)) . 24483) ((marker*) . 1) ((marker*) . 1) nil (#("
" 0 1 (fontified t)) . 24483) ((marker*) . 1) ((marker*) . 1) nil (#("    0))" 0 7 (fontified t)) . 24483) ((marker*) . 7) ((marker*) . 1) ((marker) . -7) nil (#("
" 0 1 (fontified t)) . 24483) ((marker*) . 1) nil (#("  (lambda (name)" 0 3 (fontified t) 3 9 (fontified t face font-lock-keyword-face) 9 16 (fontified t)) . 24483) ((marker*) . 16) nil (#("
" 0 1 (fontified t)) . 24483) ((marker*) . 1) nil (#("(define make0" 0 1 (fontified t) 1 7 (fontified t face font-lock-keyword-face) 7 8 (fontified t) 8 13 (fontified t face font-lock-function-name-face)) . 24483) ((marker*) . 13) ((marker) . -1) nil (#("
" 0 1 (fontified t)) . 24483) (t 20212 . 41731) nil (#("お" 0 1 (fontified t)) . -24625) (24625 . 24626) nil (23982 . 23983) nil (#("g" 0 1 (face font-lock-function-name-face fontified t)) . -23982) nil (23901 . 23902) nil (23853 . 23860) (#("      " 0 6 (fontified t)) . -23853) 23853 nil (23825 . 23831) (#("     " 0 5 (fontified t)) . -23825) 23825 nil (23814 . 23819) (#("    " 0 4 (fontified t)) . -23814) 23814 nil (23771 . 23776) (#("    " 0 4 (fontified t)) . -23771) 23771 nil (23735 . 23740) (#("    " 0 4 (fontified t)) . -23735) 23735 nil (23729 . 23734) nil (23725 . 23729) nil (23724 . 23725) (t 20212 . 40892) nil (24575 . 24576) nil (24539 . 24545) nil (24572 . 24573) nil (#("make0" 0 5 (fontified t)) . 24572) nil (24538 . 24540) nil (24569 . 24581) nil (#("0" 0 1 (fontified t)) . -24569) nil (24587 . 24588) nil (24586 . 24587) nil (24585 . 24586) nil (24582 . 24585) nil (#("w" 0 1 (fontified t)) . -24582) nil (24581 . 24583) nil (24577 . 24578) nil (24577 . 24580) nil (24572 . 24577) nil (24571 . 24572) nil (#(")" 0 1 (fontified t)) . -24571) nil (24573 . 24577) nil (#(")" 0 1 (fontified t)) . -24572) nil (#(")" 0 1 (fontified t)) . -24573) nil (24574 . 24575) nil (24573 . 24574) nil (24572 . 24573) nil (24571 . 24572) nil (24569 . 24571) nil (#("make" 0 4 (fontified t)) . 24569) nil (24568 . 24573) nil (24555 . 24568) nil (24550 . 24555) nil (24549 . 24550) nil (24544 . 24549) nil (24540 . 24544) nil (24539 . 24540) nil (24525 . 24539) nil (24523 . 24525) nil (24522 . 24523) nil (24516 . 24522) nil (#("m" 0 1 (face font-lock-function-name-face fontified t)) . -24516) nil (#("a" 0 1 (face font-lock-function-name-face fontified t)) . -24517) nil (24507 . 24518) nil (24506 . 24507) nil (#(")" 0 1 (fontified t)) . -24506) nil (24506 . 24507) nil (24505 . 24506) nil (24503 . 24505) nil (24499 . 24503) nil (24498 . 24499) nil (24484 . 24498) nil (24482 . 24484) nil (24481 . 24482) nil (24468 . 24481) nil (#("(" 0 1 (fontified t)) . 24408) nil (24408 . 24409) nil (#("お" 0 1 (fontified t)) . -24466) (24466 . 24467) nil (24221 . 24223) (#("渡す" 0 2 (face font-lock-comment-face fontified t)) . -24221) (24221 . 24223) (#("わたす" 0 3 (face font-lock-comment-face fontified t)) . -24221) (24221 . 24224) (#("わたs" 0 3 (face font-lock-comment-face fontified t)) . -24221) (24221 . 24224) (#("わた" 0 2 (face font-lock-comment-face fontified t)) . -24221) (24221 . 24223) (#("わt" 0 2 (face font-lock-comment-face fontified t)) . -24221) (24221 . 24223) (#("わ" 0 1 (face font-lock-comment-face fontified t)) . -24221) (24221 . 24222) (#("w" 0 1 (face font-lock-comment-face fontified t)) . -24221) (24218 . 24222) (#("関数を" 0 3 (face font-lock-comment-face fontified t)) . -24218) (24218 . 24221) (#("かんすうを" 0 5 (face font-lock-comment-face fontified t)) . -24218) (24218 . 24223) (#("かんすうw" 0 5 (face font-lock-comment-face fontified t)) . -24218) (24218 . 24223) (#("かんすう" 0 4 (face font-lock-comment-face fontified t)) . -24218) (24218 . 24222) (#("かんす" 0 3 (face font-lock-comment-face fontified t)) . -24218) (24218 . 24221) (#("かんs" 0 3 (face font-lock-comment-face fontified t)) . -24218) (24218 . 24221) (#("かん" 0 2 (face font-lock-comment-face fontified t)) . -24218) (24218 . 24220) (#("かn" 0 2 (face font-lock-comment-face fontified t)) . -24218) (24218 . 24220) (#("か" 0 1 (face font-lock-comment-face fontified t)) . -24218) (24218 . 24219) (#("k" 0 1 (face font-lock-comment-face fontified t)) . -24218) (24211 . 24219) (#("してくるように" 0 7 (face font-lock-comment-face fontified t)) . -24211) (24211 . 24218) (#("してくるようn" 0 7 (face font-lock-comment-face fontified t)) . -24211) (24211 . 24218) (#("してくるよう" 0 6 (face font-lock-comment-face fontified t)) . -24211) (24211 . 24217) (#("してくるよ" 0 5 (face font-lock-comment-face fontified t)) . -24211) (24211 . 24216) (#("してくるy" 0 5 (face font-lock-comment-face fontified t)) . -24211) (24211 . 24216) (#("してくる" 0 4 (face font-lock-comment-face fontified t)) . -24211) (24211 . 24215) (#("してくr" 0 4 (face font-lock-comment-face fontified t)) . -24211) (24211 . 24215) (#("してく" 0 3 (face font-lock-comment-face fontified t)) . -24211) (24211 . 24214) (#("してk" 0 3 (face font-lock-comment-face fontified t)) . -24211) (24211 . 24214) (#("して" 0 2 (face font-lock-comment-face fontified t)) . -24211) (24211 . 24213) (#("しt" 0 2 (face font-lock-comment-face fontified t)) . -24211) (24211 . 24213) (#("し" 0 1 (face font-lock-comment-face fontified t)) . -24211) (24211 . 24212) (#("s" 0 1 (face font-lock-comment-face fontified t)) . -24211) (24209 . 24212) (#("再帰" 0 2 (face font-lock-comment-face fontified t)) . -24209) (24209 . 24211) (#("さいき" 0 3 (face font-lock-comment-face fontified t)) . -24209) (24209 . 24212) (#("さいk" 0 3 (face font-lock-comment-face fontified t)) . -24209) (24209 . 24212) (#("さい" 0 2 (face font-lock-comment-face fontified t)) . -24209) (24209 . 24211) (#("さ" 0 1 (face font-lock-comment-face fontified t)) . -24209) (24209 . 24210) (#("s" 0 1 (face font-lock-comment-face fontified t)) . -24209) (24209 . 24210) (#("も" 0 1 (face font-lock-comment-face fontified t)) . -24209) (24209 . 24210) (#("もど" 0 2 (face font-lock-comment-face fontified t)) . -24209) (24209 . 24211) (#("もどっ" 0 3 (face font-lock-comment-face fontified t)) . -24209) (24209 . 24212) (#("もどって" 0 4 (face font-lock-comment-face fontified t)) . -24209) (24209 . 24213) (#("もどっt" 0 4 (face font-lock-comment-face fontified t)) . -24209) (24209 . 24213) (#("もどt" 0 3 (face font-lock-comment-face fontified t)) . -24209) (24209 . 24212) (#("もど" 0 2 (face font-lock-comment-face fontified t)) . -24209) (24209 . 24211) (#("もd" 0 2 (face font-lock-comment-face fontified t)) . -24209) (24209 . 24211) (#("も" 0 1 (face font-lock-comment-face fontified t)) . -24209) (24209 . 24210) (#("m" 0 1 (face font-lock-comment-face fontified t)) . -24209) (24208 . 24210) nil (#("に" 0 1 (face font-lock-comment-face fontified t)) . -24208) (24208 . 24209) (#("n" 0 1 (face font-lock-comment-face fontified t)) . -24208) (24201 . 24209) nil (#("t" 0 1 (face font-lock-comment-face fontified t)) . -24201) nil (#("a" 0 1 (face font-lock-comment-face fontified t)) . -24202) nil (24189 . 24203) nil (#("再び" 0 2 (face font-lock-comment-face fontified t)) . -24189) (24189 . 24191) (#("ふたたび" 0 4 (face font-lock-comment-face fontified t)) . -24189) (24189 . 24193) (#("ふたたb" 0 4 (face font-lock-comment-face fontified t)) . -24189) (24189 . 24193) (#("ふたたb" 0 4 (fontified nil)) . -24189) (24189 . 24193) (#("ふたt" 0 3 (face font-lock-comment-face fontified t)) . -24189) (24189 . 24192) (#("ふた" 0 2 (face font-lock-comment-face fontified t)) . -24189) (24189 . 24191) (#("ふt" 0 2 (face font-lock-comment-face fontified t)) . -24189) (24189 . 24191) (#("ふ" 0 1 (face font-lock-comment-face fontified t)) . -24189) (24189 . 24190) (#("f" 0 1 (face font-lock-comment-face fontified t)) . -24189) (24189 . 24190) (#("再" 0 1 (face font-lock-comment-face fontified t)) . -24189) nil (#("帰" 0 1 (face font-lock-comment-face fontified t)) . -24190) nil (#("さ" 0 1 (face font-lock-comment-face fontified t)) . -24191) nil (#("せ" 0 1 (face font-lock-comment-face fontified t)) . -24192) nil (#("る" 0 1 (face font-lock-comment-face fontified t)) . -24193) nil (24191 . 24194) (#("させる" 0 3 (face font-lock-comment-face fontified t)) . -24191) (24191 . 24194) (#("させr" 0 3 (face font-lock-comment-face fontified t)) . -24191) (24191 . 24194) (#("させ" 0 2 (face font-lock-comment-face fontified t)) . -24191) (24191 . 24193) (#("さs" 0 2 (face font-lock-comment-face fontified t)) . -24191) (24191 . 24193) (#("さ" 0 1 (face font-lock-comment-face fontified t)) . -24191) (24191 . 24192) (#("s" 0 1 (face font-lock-comment-face fontified t)) . -24191) (24189 . 24192) (#("再帰" 0 2 (face font-lock-comment-face fontified t)) . -24189) (24189 . 24191) (#("さいき" 0 3 (face font-lock-comment-face fontified t)) . -24189) (24189 . 24192) (#("さいk" 0 3 (face font-lock-comment-face fontified t)) . -24189) (24189 . 24192) (#("さい" 0 2 (face font-lock-comment-face fontified t)) . -24189) (24189 . 24191) (#("さ" 0 1 (face font-lock-comment-face fontified t)) . -24189) (24189 . 24190) (#("s" 0 1 (face font-lock-comment-face fontified t)) . -24189) (24187 . 24190) nil (#("べく" 0 2 (face font-lock-comment-face fontified t)) . -24187) (24187 . 24189) (#("べk" 0 2 (face font-lock-comment-face fontified t)) . -24187) (24187 . 24189) (#("べ" 0 1 (face font-lock-comment-face fontified t)) . -24187) (24187 . 24188) (#("b" 0 1 (face font-lock-comment-face fontified t)) . -24187) (24187 . 24188) (#("よ" 0 1 (face font-lock-comment-face fontified t)) . -24187) nil (#("う" 0 1 (face font-lock-comment-face fontified t)) . -24188) nil (#("さ" 0 1 (face font-lock-comment-face fontified t)) . -24189) (24189 . 24190) (#("s" 0 1 (face font-lock-comment-face fontified t)) . -24189) (24187 . 24190) (#("よう" 0 2 (face font-lock-comment-face fontified t)) . -24187) (24187 . 24189) (#("よ" 0 1 (face font-lock-comment-face fontified t)) . -24187) (24187 . 24188) (#("y" 0 1 (face font-lock-comment-face fontified t)) . -24187) (24184 . 24188) (#("調べる" 0 3 (face font-lock-comment-face fontified t)) . -24184) (24184 . 24187) (#("しらべる" 0 4 (face font-lock-comment-face fontified t)) . -24184) (24184 . 24188) (#("しらべr" 0 4 (face font-lock-comment-face fontified t)) . -24184) (24184 . 24188) (#("しらべ" 0 3 (face font-lock-comment-face fontified t)) . -24184) (24184 . 24187) (#("しらb" 0 3 (face font-lock-comment-face fontified t)) . -24184) (24184 . 24187) (#("しら" 0 2 (face font-lock-comment-face fontified t)) . -24184) (24184 . 24186) (#("しr" 0 2 (face font-lock-comment-face fontified t)) . -24184) (24184 . 24186) (#("し" 0 1 (face font-lock-comment-face fontified t)) . -24184) (24184 . 24185) (#("s" 0 1 (face font-lock-comment-face fontified t)) . -24184) (24183 . 24185) (#("を" 0 1 (face font-lock-comment-face fontified t)) . -24183) (24183 . 24184) (#("w" 0 1 (face font-lock-comment-face fontified t)) . -24183) (24179 . 24184) (#("エントリ" 0 4 (face font-lock-comment-face fontified t)) . -24179) (24179 . 24183) (#("えんとり" 0 4 (face font-lock-comment-face fontified t)) . -24179) (24179 . 24183) (#("えんとr" 0 4 (face font-lock-comment-face fontified t)) . -24179) (24179 . 24183) (#("えんと" 0 3 (face font-lock-comment-face fontified t)) . -24179) (24179 . 24182) (#("えんt" 0 3 (face font-lock-comment-face fontified t)) . -24179) (24179 . 24182) (#("えん" 0 2 (face font-lock-comment-face fontified t)) . -24179) (24179 . 24181) (#("えn" 0 2 (face font-lock-comment-face fontified t)) . -24179) (24179 . 24181) (#("え" 0 1 (face font-lock-comment-face fontified t)) . -24179) (24178 . 24180) (#("の" 0 1 (face font-lock-comment-face fontified t)) . -24178) (24178 . 24179) (#("n" 0 1 (face font-lock-comment-face fontified t)) . -24178) (24176 . 24179) (#("残り" 0 2 (face font-lock-comment-face fontified t)) . -24176) (24176 . 24178) (#("のこり" 0 3 (face font-lock-comment-face fontified t)) . -24176) (24176 . 24179) (#("のこr" 0 3 (face font-lock-comment-face fontified t)) . -24176) (24176 . 24179) (#("のこ" 0 2 (face font-lock-comment-face fontified t)) . -24176) (24176 . 24178) (#("のk" 0 2 (face font-lock-comment-face fontified t)) . -24176) (24176 . 24178) (#("の" 0 1 (face font-lock-comment-face fontified t)) . -24176) (24176 . 24177) (#("n" 0 1 (face font-lock-comment-face fontified t)) . -24176) (24175 . 24177) nil (#("に" 0 1 (face font-lock-comment-face fontified t)) . -24175) (24175 . 24176) (#("n" 0 1 (face font-lock-comment-face fontified t)) . -24175) (24166 . 24176) nil (#("8" 0 1 (face font-lock-comment-face fontified t)) . -24166) nil (24166 . 24167) nil (#("(" 0 1 (face font-lock-comment-face fontified t)) . -24166) nil (#("l" 0 1 (face font-lock-comment-face fontified t)) . -24167) nil (#("o" 0 1 (face font-lock-comment-face fontified t)) . -24168) nil (#("o" 0 1 (face font-lock-comment-face fontified t)) . -24169) nil (24166 . 24170) nil (#("l" 0 1 (face font-lock-comment-face fontified t)) . -24166) nil (#("o" 0 1 (face font-lock-comment-face fontified t)) . -24167) nil (24163 . 24168) nil (24160 . 24163) (#("かける" 0 3 (face font-lock-comment-face fontified t)) . -24160) (24160 . 24163) (#("×" 0 1 (face font-lock-comment-face fontified t)) . -24160) (24160 . 24161) (#("蚊ける" 0 3 (face font-lock-comment-face fontified t)) . -24160) (24160 . 24163) (#("×" 0 1 (face font-lock-comment-face fontified t)) . -24160) (24160 . 24161) (#("かける" 0 3 (face font-lock-comment-face fontified t)) . -24160) (24160 . 24163) (#("かけr" 0 3 (face font-lock-comment-face fontified t)) . -24160) (24160 . 24163) (#("かけ" 0 2 (face font-lock-comment-face fontified t)) . -24160) (24160 . 24162) (#("かk" 0 2 (face font-lock-comment-face fontified t)) . -24160) (24160 . 24162) (#("か" 0 1 (face font-lock-comment-face fontified t)) . -24160) (24160 . 24161) (#("k" 0 1 (face font-lock-comment-face fontified t)) . -24160) (24159 . 24161) nil (#("に" 0 1 (face font-lock-comment-face fontified t)) . -24159) (24159 . 24160) (#("n" 0 1 (face font-lock-comment-face fontified t)) . -24159) (24141 . 24160) nil (#("、" 0 1 (face font-lock-comment-face fontified t)) . -24141) (24141 . 24142) (#("、" 0 1 (face font-lock-comment-face fontified t)) . -24141) (24137 . 24142) (#("取り出し" 0 4 (face font-lock-comment-face fontified t)) . -24137) (24137 . 24141) (#("とりだし" 0 4 (face font-lock-comment-face fontified t)) . -24137) (24137 . 24141) (#("とりだs" 0 4 (face font-lock-comment-face fontified t)) . -24137) (24137 . 24141) (#("とりだ" 0 3 (face font-lock-comment-face fontified t)) . -24137) (24137 . 24140) (#("とりd" 0 3 (face font-lock-comment-face fontified t)) . -24137) (24137 . 24140) (#("とり" 0 2 (face font-lock-comment-face fontified t)) . -24137) (24137 . 24139) (#("とr" 0 2 (face font-lock-comment-face fontified t)) . -24137) (24137 . 24139) (#("と" 0 1 (face font-lock-comment-face fontified t)) . -24137) (24137 . 24138) (#("t" 0 1 (face font-lock-comment-face fontified t)) . -24137) (24136 . 24138) (#("を" 0 1 (face font-lock-comment-face fontified t)) . -24136) (24136 . 24137) (#("w" 0 1 (face font-lock-comment-face fontified t)) . -24136) (24132 . 24137) (#("エントリ" 0 4 (face font-lock-comment-face fontified t)) . -24132) (24132 . 24136) (#("えんとり" 0 4 (face font-lock-comment-face fontified t)) . -24132) (24132 . 24136) (#("えんとr" 0 4 (face font-lock-comment-face fontified t)) . -24132) (24132 . 24136) (#("えんと" 0 3 (face font-lock-comment-face fontified t)) . -24132) (24132 . 24135) (#("えんt" 0 3 (face font-lock-comment-face fontified t)) . -24132) (24132 . 24135) (#("えん" 0 2 (face font-lock-comment-face fontified t)) . -24132) (24132 . 24134) (#("えn" 0 2 (face font-lock-comment-face fontified t)) . -24132) (24132 . 24134) (#("え" 0 1 (face font-lock-comment-face fontified t)) . -24132) (24129 . 24133) (#("１つの" 0 3 (face font-lock-comment-face fontified t)) . -24129) (24129 . 24132) (#("１つn" 0 3 (face font-lock-comment-face fontified t)) . -24129) (24129 . 24132) (#("１つ" 0 2 (face font-lock-comment-face fontified t)) . -24129) (24129 . 24131) (#("１t" 0 2 (face font-lock-comment-face fontified t)) . -24129) (24129 . 24131) (#("１" 0 1 (face font-lock-comment-face fontified t)) . -24129) (24128 . 24130) (#("の" 0 1 (face font-lock-comment-face fontified t)) . -24128) (24128 . 24129) (#("n" 0 1 (face font-lock-comment-face fontified t)) . -24128) (24124 . 24129) (#("テーブル" 0 4 (face font-lock-comment-face fontified t)) . -24124) (24124 . 24128) (#("てーぶる" 0 4 (face font-lock-comment-face fontified t)) . -24124) (24124 . 24128) (#("てーぶr" 0 4 (face font-lock-comment-face fontified t)) . -24124) (24124 . 24128) (#("てーぶ" 0 3 (face font-lock-comment-face fontified t)) . -24124) (24124 . 24127) (#("てーb" 0 3 (face font-lock-comment-face fontified t)) . -24124) (24124 . 24127) (#("てー" 0 2 (face font-lock-comment-face fontified t)) . -24124) (24124 . 24126) (#("て" 0 1 (face font-lock-comment-face fontified t)) . -24124) (24124 . 24125) (#("t" 0 1 (face font-lock-comment-face fontified t)) . -24124) (24121 . 24125) nil (24362 . 24363) nil (24361 . 24362) nil (24360 . 24361) nil (24359 . 24360) nil (24358 . 24359) nil (24357 . 24358) nil (24348 . 24357) nil (24335 . 24348) nil (24315 . 24335) nil (24306 . 24315) nil (24305 . 24306) nil (24298 . 24305) nil (24284 . 24291) nil (24283 . 24284) nil (24258 . 24259) (24257 . 24265) (#(" " 0 1 (fontified t)) . 24257) nil (#("
" 0 1 (fontified t)) . 24275) nil (#("                       " 0 23 (fontified t)) . 24276) nil (24276 . 24299) nil (24275 . 24276) nil (24257 . 24258) (#("        " 0 1 (fontified nil) 1 8 (fontified nil)) . 24257) (#("
" 0 1 (fontified t)) . -24258) 24285 nil (24282 . 24290) nil (24279 . 24282) nil (#("e" 0 1 (fontified t)) . -24279) nil (#("l" 0 1 (fontified t)) . -24280) nil (24272 . 24281) nil (#("v" 0 1 (fontified t)) . -24272) nil (#("a" 0 1 (fontified t)) . -24273) nil (24266 . 24274) nil (#("(" 0 1 (fontified t)) . -24266) nil (#("n" 0 1 (fontified t)) . -24267) nil (#("a" 0 1 (fontified t)) . -24268) nil (#("m" 0 1 (fontified t)) . -24269) nil (#("e" 0 1 (fontified t)) . -24270) nil (24266 . 24271) nil (24259 . 24266) nil (24258 . 24259) nil (#("n" 0 1 (fontified t)) . -24258) nil (#("a" 0 1 (fontified t)) . -24259) nil (#("m" 0 1 (fontified t)) . -24260) nil (#("e" 0 1 (fontified t)) . -24261) nil (24255 . 24262) nil (#("y" 0 1 (fontified t)) . -24255) nil (24241 . 24256) nil (24235 . 24241) nil (24234 . 24235) nil (24228 . 24234) nil (24223 . 24228) nil (24222 . 24223) nil (24221 . 24222) nil (24206 . 24221) nil (24192 . 24206) nil (24187 . 24192) nil (24186 . 24187) nil (24181 . 24186) nil (24177 . 24181) (#("          " 0 10 (fontified t)) . -24177) 24183 nil (24150 . 24152) nil (#("m" 0 1 (fontified t)) . -24150) nil (#("a" 0 1 (fontified t)) . -24151) nil (24189 . 24190) nil (24188 . 24189) nil (24187 . 24188) nil (24177 . 24187) (#("     " 0 5 (fontified t)) . -24177) nil (#(" " 0 1 (fontified t)) . -24182) nil (#(" " 0 1 (fontified t)) . -24183) nil (#(" " 0 1 (fontified t)) . -24184) nil (#(" " 0 1 (fontified t)) . -24185) nil (#(" " 0 1 (fontified t)) . -24186) nil (24177 . 24187) nil (24176 . 24177) nil (24168 . 24176) nil (24148 . 24168) nil (24146 . 24148) nil (24145 . 24146) nil (24133 . 24145) nil (#("g" 0 1 (face font-lock-function-name-face fontified t)) . -24133) nil (24121 . 24134) nil (24103 . 24121) nil (24102 . 24103) nil (24099 . 24102) (#("リスト" 0 3 (face font-lock-comment-face fontified t)) . -24099) (24099 . 24102) (#("りすと" 0 3 (face font-lock-comment-face fontified t)) . -24099) (24099 . 24102) (#("りすt" 0 3 (face font-lock-comment-face fontified t)) . -24099) (24099 . 24102) (#("りす" 0 2 (face font-lock-comment-face fontified t)) . -24099) (24099 . 24101) (#("りs" 0 2 (face font-lock-comment-face fontified t)) . -24099) (24099 . 24101) (#("り" 0 1 (face font-lock-comment-face fontified t)) . -24099) (24099 . 24100) (#("r" 0 1 (face font-lock-comment-face fontified t)) . -24099) (24094 . 24100) nil (#("エントリの" 0 5 (face font-lock-comment-face fontified t)) . -24094) (24094 . 24099) (#("えんとりの" 0 5 (face font-lock-comment-face fontified t)) . -24094) (24094 . 24099) (#("えんとりn" 0 5 (face font-lock-comment-face fontified t)) . -24094) (24094 . 24099) (#("えんとり" 0 4 (face font-lock-comment-face fontified t)) . -24094) (24094 . 24098) (#("えんとr" 0 4 (face font-lock-comment-face fontified t)) . -24094) (24094 . 24098) (#("えんと" 0 3 (face font-lock-comment-face fontified t)) . -24094) (24094 . 24097) (#("えんt" 0 3 (face font-lock-comment-face fontified t)) . -24094) (24094 . 24097) (#("えん" 0 2 (face font-lock-comment-face fontified t)) . -24094) (24094 . 24096) (#("えn" 0 2 (face font-lock-comment-face fontified t)) . -24094) (24094 . 24096) (#("え" 0 1 (face font-lock-comment-face fontified t)) . -24094) (24094 . 24095) nil (24092 . 24094) nil (#("とは" 0 2 (face font-lock-comment-face fontified t)) . -24092) (24092 . 24094) (#("とh" 0 2 (face font-lock-comment-face fontified t)) . -24092) (24092 . 24094) (#("と" 0 1 (face font-lock-comment-face fontified t)) . -24092) (24092 . 24093) (#("t" 0 1 (face font-lock-comment-face fontified t)) . -24092) (24089 . 24093) (#("環境" 0 2 (face font-lock-comment-face fontified t)) . -24089) (24089 . 24091) (#("かんきょう" 0 5 (face font-lock-comment-face fontified t)) . -24089) (24089 . 24094) (#("かんきょ" 0 4 (face font-lock-comment-face fontified t)) . -24089) (24089 . 24093) (#("かんky" 0 4 (face font-lock-comment-face fontified t)) . -24089) (24089 . 24093) (#("かんk" 0 3 (face font-lock-comment-face fontified t)) . -24089) (24089 . 24092) (#("かん" 0 2 (face font-lock-comment-face fontified t)) . -24089) (24089 . 24091) (#("かn" 0 2 (face font-lock-comment-face fontified t)) . -24089) (24089 . 24091) (#("か" 0 1 (face font-lock-comment-face fontified t)) . -24089) (24089 . 24090) (#("k" 0 1 (face font-lock-comment-face fontified t)) . -24089) (24084 . 24090) (#("テーブル" 0 4 (face font-lock-comment-face fontified t)) . -24084) (24084 . 24088) (#("てーぶる" 0 4 (face font-lock-comment-face fontified t)) . -24084) (24084 . 24088) (#("てーぶr" 0 4 (face font-lock-comment-face fontified t)) . -24084) (24084 . 24088) (#("てーぶ" 0 3 (face font-lock-comment-face fontified t)) . -24084) (24084 . 24087) (#("てーぶづ" 0 4 (face font-lock-comment-face fontified t)) . -24084) (24084 . 24088) (#("てーぶd" 0 4 (face font-lock-comment-face fontified t)) . -24084) (24084 . 24088) (#("てーぶ" 0 3 (face font-lock-comment-face fontified t)) . -24084) (24084 . 24087) (#("てーb" 0 3 (face font-lock-comment-face fontified t)) . -24084) (24084 . 24087) (#("てー" 0 2 (face font-lock-comment-face fontified t)) . -24084) (24084 . 24086) (#("て" 0 1 (face font-lock-comment-face fontified t)) . -24084) (24084 . 24085) (#("t" 0 1 (face font-lock-comment-face fontified t)) . -24084) (24081 . 24085) nil (24080 . 24081) nil (#("o" 0 1 (fontified t)) . -23658) nil (23658 . 23659) nil (#("お" 0 1 (fontified t)) . -24080) (24080 . 24081) nil (23952 . 23954) (#("渡す" 0 2 (face font-lock-comment-face fontified t)) . -23952) (23952 . 23954) (#("わたす" 0 3 (face font-lock-comment-face fontified t)) . -23952) (23952 . 23955) (#("わたs" 0 3 (face font-lock-comment-face fontified t)) . -23952) (23952 . 23955) (#("わた" 0 2 (face font-lock-comment-face fontified t)) . -23952) (23952 . 23954) (#("わt" 0 2 (face font-lock-comment-face fontified t)) . -23952) (23952 . 23954) (#("わ" 0 1 (face font-lock-comment-face fontified t)) . -23952) (23952 . 23953) (#("w" 0 1 (face font-lock-comment-face fontified t)) . -23952) (23951 . 23953) nil (#("に" 0 1 (face font-lock-comment-face fontified t)) . -23951) (23951 . 23952) (#("n" 0 1 (face font-lock-comment-face fontified t)) . -23951) (23939 . 23952) nil (23927 . 23939) (#("し、" 0 2 (face font-lock-comment-face fontified t)) . -23927) (23927 . 23929) (#("し" 0 1 (face font-lock-comment-face fontified t)) . -23927) (23927 . 23928) (#("し" 0 1 (fontified nil)) . -23927) (23925 . 23928) (#("分割" 0 2 (face font-lock-comment-face fontified t)) . -23925) (23925 . 23927) (#("ぶんかつ" 0 4 (face font-lock-comment-face fontified t)) . -23925) (23925 . 23929) (#("ぶんかt" 0 4 (face font-lock-comment-face fontified t)) . -23925) (23925 . 23929) (#("ぶんか" 0 3 (face font-lock-comment-face fontified t)) . -23925) (23925 . 23928) (#("ぶんk" 0 3 (face font-lock-comment-face fontified t)) . -23925) (23925 . 23928) (#("ぶん" 0 2 (face font-lock-comment-face fontified t)) . -23925) (23925 . 23927) (#("ぶn" 0 2 (face font-lock-comment-face fontified t)) . -23925) (23925 . 23927) (#("ぶ" 0 1 (face font-lock-comment-face fontified t)) . -23925) (23925 . 23926) (#("b" 0 1 (face font-lock-comment-face fontified t)) . -23925) (23924 . 23926) (#("に" 0 1 (face font-lock-comment-face fontified t)) . -23924) (23924 . 23925) (#("n" 0 1 (face font-lock-comment-face fontified t)) . -23924) (23924 . 23925) (#("n" 0 1 (face font-lock-comment-face fontified t)) . -23924) (23923 . 23925) (#("値" 0 1 (face font-lock-comment-face fontified t)) . -23923) (23923 . 23924) (#("あたい" 0 3 (face font-lock-comment-face fontified t)) . -23923) (23923 . 23926) (#("あた" 0 2 (face font-lock-comment-face fontified t)) . -23923) (23923 . 23925) (#("あt" 0 2 (face font-lock-comment-face fontified t)) . -23923) (23923 . 23925) (#("あ" 0 1 (face font-lock-comment-face fontified t)) . -23923) (23922 . 23924) (#("と" 0 1 (face font-lock-comment-face fontified t)) . -23922) (23922 . 23923) (#("t" 0 1 (face font-lock-comment-face fontified t)) . -23922) (23920 . 23923) (#("キー" 0 2 (face font-lock-comment-face fontified t)) . -23920) (23920 . 23922) (#("きー" 0 2 (face font-lock-comment-face fontified t)) . -23920) (23920 . 23922) (#("き" 0 1 (face font-lock-comment-face fontified t)) . -23920) (23920 . 23921) (#("k" 0 1 (face font-lock-comment-face fontified t)) . -23920) (23919 . 23921) nil (#("を" 0 1 (face font-lock-comment-face fontified t)) . -23919) (23919 . 23920) (#("w" 0 1 (face font-lock-comment-face fontified t)) . -23919) (23913 . 23920) nil (#("t" 0 1 (face font-lock-comment-face fontified t)) . -23913) nil (23908 . 23914) (#("エントリ" 0 4 (face font-lock-comment-face fontified t)) . -23908) (23908 . 23912) (#("えんとり" 0 4 (face font-lock-comment-face fontified t)) . -23908) (23908 . 23912) (#("えんとr" 0 4 (face font-lock-comment-face fontified t)) . -23908) (23908 . 23912) (#("えんと" 0 3 (face font-lock-comment-face fontified t)) . -23908) (23908 . 23911) (#("えんt" 0 3 (face font-lock-comment-face fontified t)) . -23908) (23908 . 23911) (#("えん" 0 2 (face font-lock-comment-face fontified t)) . -23908) (23908 . 23910) (#("えn" 0 2 (face font-lock-comment-face fontified t)) . -23908) (23908 . 23910) (#("え" 0 1 (face font-lock-comment-face fontified t)) . -23908) (23905 . 23909) nil (23654 . 23657) (#("かける" 0 3 (face font-lock-comment-face fontified t)) . -23654) (23654 . 23657) (#("かけr" 0 3 (face font-lock-comment-face fontified t)) . -23654) (23654 . 23657) (#("かけ" 0 2 (face font-lock-comment-face fontified t)) . -23654) (23654 . 23656) (#("かk" 0 2 (face font-lock-comment-face fontified t)) . -23654) (23654 . 23656) (#("か" 0 1 (face font-lock-comment-face fontified t)) . -23654) (23654 . 23655) (#("k" 0 1 (face font-lock-comment-face fontified t)) . -23654) (23653 . 23655) nil (#("を" 0 1 (face font-lock-comment-face fontified t)) . -23653) (23653 . 23654) (#("w" 0 1 (face font-lock-comment-face fontified t)) . -23653) (23646 . 23654)))
