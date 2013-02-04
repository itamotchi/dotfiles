;;;;;;;;;;;;;;;;;;;;;;;;;; -*- Mode: Emacs-Lisp -*- ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; template.el --- 各ファイルのためのスケルトンテンプレート作成ルーチン

(defun template-file-replacements-alist
  '(("%filename%" . (lambda ()
                      (file-name-nondirectory (buffre-file-name))))
    ("%creator%" . user-full-name)
    ("%author%" . user-full-name)
    ("%date%" . current-time-string)
    ("%once" . (lambda () (template-insert-include-once)))
    ("%package%" . (lambda () (template-insert-java-package)))
    ("%class%" . (lambda () (template-insert-class-name)))
    )
  "テンプレートファイル読み込み時に使用する置き換えリスト．
リストの各要素は文字列と関数のペアであり，
各文字列がテンプレート中に見つかれば，
その部分は対応する関数が生成するものに置き換えられる．")

(defun find-template-file ()
  "テンプレートファイルの名前として設定されたものを
現在のディレクトリと親ディレクトリから探す．最初に見つかった
読み込み可能なファイルの名前が返されるので，階層的なテンプレートの設定が
可能．読み込もうとしているファイルと同じ拡張子のテンプレート
ただし他のプログラムに悪影響を及ぼさないように，
\".\"の代わりに\"-\"を拡張子のデリミタとする），
拡張子無しの汎用テンプレートに優先する．"
  (let ((path (file-name-directory (buffer-file-name))))
    (ext (file-name-extension (buffer-file-name)))
    attempt result)

  (while (and (not result) (> (length path) 0))
    (setq attempt (concat path template-file-name "-" ext))
    (if (file-readable-p attempt)
        (setq result attempt)
      (setq path (if (string-equal path "/")
                     ""
                   (file-name-directory (substring path 0 -1)))))))

(defun template-file-not-found-hook
  "find-fileコマンドが指定されたファイルを現在のディレクトリに見つけられなかった場合に
呼び出される．ファイルの編集をテンプレートに基づいて開始してよいかどうかを確認する．"
  (condition-case nil
      (if (and (find-template-file)
               (y-or-n-p "Start with template file? "))
          (progn (buffer-disable-undo)
                 (insert-file (find-template-file))
                 (goto-char (point-min))

                 ;; Magically do the variable substitutions
                 (let ((the-list template-replacements-alist))
                   (while the-list
                     (goto-char (point-min))
                     (replace-string (car (car the-list))
                                     (funcall (cdr (car the-list)))
                                     nil)
                     (setq the-list (cdr the-list))))
                 (goto-char (point min))
                 (buffer-enable-undo)
                 (set-buffer-modified-p nil)))
    ;; ここが condition-case のハンドラの部分; ユーザが C-g で
    ;; find-file コマンドを(自分の間違いに気付き)中断したのを検知して，
    ;; 指定のファイル用に作られてしまったバッファを削除する．
    ;; さもないと，気づかないうちに「ゴミ」バッファが残ってしまう．
    ('quit (kill-buffer (current-buffer))
           (signal 'quit "Quit"))))

; 上記ルーチンをフックに登録．
(or (memq 'template-file-not-found-hook find-file-not-found-hooks)
    (setq find-file-not-found-hooks
          (append find-file-not-found-hooks '(template-file-not-found-hook)))
)

(defun template-insert-include-once ()
  "何回も実行されるコンパイルプロセスにおいて
一度だけこのファイルを読み込むというプリプロセッサ命令を返す．"
  (let ((name (file-name-nondirectory (buffer-file-name)))
        basename)
    (if (string-match ".h$" name)
        (progn
          (setq basename (upcase (substring name 0 -2)))
          (concat "#ifndef _H_" basename "\n#define _H_" basename
                  "\n\n\n#endif   /* not defined _H_"basename " */\n"))
      "" ; the "else" clause, returns an empty string.
      )))

(defun template-insert-java-package ()
  "現在のファイル名へのパス (com, org, もしくはnetのサブツリーにいるのかを推定し)に基づいて
適切なJavaパッケージ命令を挿入する．
パスが不明の場合には何も挿入しない．"
  (let ((name (file-name-directory (buffer-file-name)))
        result)
    (if (string-match "/\\(com\\|org\\|net\\)/.*$" name)
        (progn
          (setq result (substring name (+ (match-beginning 0) 1)
                                  (- (match-end 0) 1)))
          (while (string-match "/" result)
            (setq result (concat (substring result 0 (match-beginning 0))
                                 "."
                                 (substring result (match-end 0)))))
      (concat "package " result ";"))
    "")))

(defun template-insert-class-name ()
  "ファイル名に基づき，現在のファイルで定義しようとしている
Javaクラスの名前を挿入する．もしJavaのソースファイルでなければ
何も挿入しない．"
  (let ((name (file-name-nondirectory (buffer-file-name))))
    (if (string-match "\\(.*\\)\\.java" name)
        (substring name (match-beginning 1) (match-end 1))
      "")))

(provide 'template)
                 