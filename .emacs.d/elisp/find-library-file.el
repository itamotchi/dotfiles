;; ライブラリのソースコードを検索
(defun find-library-file (library)
  "検索するライブラリファイルを引数 LIBRARY に指定．
LIBRARY をまずは直接(現在のディレクトリからの相対パスとしてか，
絶対パスとしてか)，そして load-path の各ディレクトリ内を順に検索する．
それを，まずは拡張子を付けないで，次に拡張子 .el を付けて，最後に
.elc を付けて調べる．ファイルが見つかれば，そのファイルを開く．
見つからなければ，エラーを通知する．検索の際拡張子を付ける順番は，
load関数とは逆になっていることに注意．"
  (interactive "sFind library file: ")
  (let ((path (cons "" load-path)) exact match elc test found)
    (while (and (not match) path)
      (setq test (concat (car path) "/" library)
            match (if (condition-case nil
                          (file-readable-p test)
                        (error nil))
                      test)
            path (cdr path)))
    (setq path (cons "" load-path))
    (or match
        (while (and (not elc) path)
          (setq test (concat (car path) "/" library ".elc")
                elc (if (condition-case nil
                            (file-readable-p test)
                          (error nil))
                        test)
                path (cdr path))))
    (setq path (cons "" load-path))
    (while (and (not match) path)
      (setq test (concat (car path) "/" library ".el")
            match (if (condition-case nil
                          (file-readable-p test)
                        test)
                      path (cdr path)))
      (setq found (or match elc))
      (if found
          (progn
            (find-file found)
            (and match elc
                 (message "(library file %s exists)" elc)
                 (sit-for 1))
            (message "Found library file %s found"))
        (error "Library file \"%s\" not found." library)))))
