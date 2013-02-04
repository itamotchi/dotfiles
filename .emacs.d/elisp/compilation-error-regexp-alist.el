;; コンパイラが生成したエラーメッセージを解析するために
;; compilパッケージが利用する正規表現のリスト
(defvar compilation-error-regexp-alist
  '(
    ;; 注意! 下の grep-regexp-alist も参照せよ．

    ;; 4.3BSD grep, cc, lint pass 1 のパターン:
    ;; /usr/src/foo/foo.c(8): warning: w may be used before set
    ;; もしくは GNU utilities のパターン:
    ;; foo.c:8: error message
    ;; もしくは HP-UX 7.0 fc のパターン:
    ;; foo.f	:16 some horrible error message
    ;; もしくはコラム数付 GNU utilities (GNAT 1.82) のパターン:
    ;; foo.adb:2:1: Unit name does not match file name
    ;; もしくはコラム数とプログラム名が出力されるパターン:
    ;; jade:dbcommon.dsl:133:17:E: missing argument for function call
    ;;
    ;; 数字の後にはコロンか閉じ括弧があることとする．
    ;; さもなくば以下は数字前後が空白であるようなパターン
    ;; すべてにマッチしてしまう．

    ;; ファイル名には数字以外のものも含まれていることとする．
    ;; そうすればファイル名をコマンド名と間違ったり，
    ;; 行番号をファイル名と間違ったりすることを避けられる．
    ("\\([a-zA-Z][-a-zA-Z._0-9]+: ?\\)?\
\\([a-zA-Z]?:?[^:( \t\n]*[^:( \t\n0-9][^:( \t\n]*\\)[:(][ \t]*\\([0-9]+\\)\
\\([) \t]\\|:\\(\\([0-9]+:\\)\\|[0-9]*[^:0-9]\\)\\)" 2 3 6)

;; Mictosoft C/C++ のパターン:
    ;; keyboard.c(537) : warning C4005: 'min' : macro redefinition
    ;; d:\tmp\test.c(23) : error C2143: syntax error : missing ';' before 'if'
    ;; 以下の正規表現は，以前はもっとゆるやかで行番号の前後は
    ;; 括弧以下の文字でも良かった．しかしそうすると GNU 形式の
    ;; エラーメッセージと混乱してしまった．
    ;; また，以前は空白やダッシュを含むファイル名には
    ;; マッチしなかったが，現在はそれらも許す．その代わり，
    ;; それに続くエラーメッセージの部分をより厳密にした．
    ("\\(\\([a-zA-Z]:\\)?[^:(\t\n]+\\)(\\([0-9]+\\)) \
: \\(error\\|warning\\) C[0-9]+:" 1 3)

;; Caml compiler のパターン:
    ;; File "foobar.ml", lines 5-8, characters 20-155: blash blash
    ("^File \"\\([^,\" \n\t]+\\)\", lines? \\([0-9]+\\)[-0-9]*, characters? \
\\([0-9]+\\)" 1 2 3)

;; Cray C compiler error messages のパターン:
    ("\\(cc\\| cft\\)-[0-9]+ c\\(c\\|f77\\): ERROR \\([^,\n]+, \\)* File = \
\\([^,\n]+\\), Line = \\([0-9]+\\)" 4 5)

;; Perl -w のパターン:
    ;; syntax error at automake line 922, near "':'"
    ;; Perl debugging traces
    ;; store::odrecall('File_A', 'x2') called at store.pm line 90
    (".* at \\([^ \n]+\\) line \\([0-9]+\\)[,.\n]" 1 2)

    ;; http://ant.apache.org/faq.html を見よ．
    ;; Ant Java: jikes のパターン:
    ("^\\s-*\\[[^]]*\\]\\s-*\\(.+\\):\\([0-9]+\\):\\([0-9]+\\):[0-9]+:[0-9]\
+:" 1 2 3)

    ;; Ant Java: javac のパターン:
    ("^\\s-*\\[[^]]*\\]\\s-*\\(.+\\):\\([0-9]+\\):" 1 2)
)

;; C++コンパイラ用のエラーメッセージをドイツ語で表示する
;; (setq compilation-error-regexp-alist
;;      (cons '("Fehler auf Zeile \\([0-9]+\\) in \\([^: \t]+\\):" 2 1)
;;            compilation-error-regexp-alist))

; compilation-error-regexp-alist中の各要素について
; (let ((regexp エレメントの中の正規表現)
;      (file-subexp ファイル名に対応する部分正規表現の番号)
;      (line-subexp 行番号に対応する部分正規表現の番号))
;  (if (looking-at regexp)
;      (let ((filename (match-string file-subexp))
;            (linenum (match-string line-subexp)))
;        (find-file-other-window filename)
;        (goto-line linenum))
;    (そうでなければリスト中の次の要素を試す)))

