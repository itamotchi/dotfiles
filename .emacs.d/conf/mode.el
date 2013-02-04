;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	Mode-Set
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Default Mode Set
(setq default-major-mode 'text-mode) 
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; 単語略称モード
(setq-default abbrev-mode t)
(read-abbrev-file "~/.emacs.d/abbrev_defs")
(setq save-abbrevs)

;; メジャーモードごとのインデント幅の設定
(setq js-indent-level 2)
;; js2
(setq-default c-basic-offset 2)
(when (load "js2" t)
  (setq js2-cleanup-whitespace nil
        js2-mirror-mode nil
        js2-bounce-indent-flag nil)

  (defun indent-and-back-to-indentation ()
    (interactive)
    (indent-for-tab-command)
    (let ((point-of-indentation
           (save-excursion
             (back-to-indentation)
             (point))))
      (skip-chars-forward "\s " point-of-indentation)))
  (define-key js2-mode-map "\C-i" 'indent-and-back-to-indentation)

  (define-key js2-mode-map "\C-m" nil)

  (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode)))
(autoload 'js2-mode "js2-mode" nil t)

; (setq cperl-indent-level 4)
(defun sql-style-hook()
  (setq tab-width 2))
(add-hook 'sql-mode-hook 'sql-style-hook) 

;; 特定のモードで文字に色を付けるためのFont-Lockモードを有効にする
(global-font-lock-mode t)

;; Lisp言語とC言語のバッファを初期化する際に，Font-Lockモードを有効にする
(add-hook 'emacs-lisp-mode-hook 'turn-on-font-lock)
(add-hook 'c-mode-hook 'turn-on-font-lock)

;; HTML-mode
;; Text-mode
;  自動改行をoff (2011/8/18)
(setq html-mode-hook 'turn-off-auto-fill)
(setq text-mode-hook 'turn-off-auto-fill)

;; PHP-mode
(autoload 'php-mode "php-mode" "PHP editing mode." t)
(setq auto-mode-alist (cons '("\\.php$" . php-mode) auto-mode-alist))

;; nXML-mode
(autoload 'xml-mode "nXML-mode" "XML editing mode." t)
(setq auto-mode-alist (append '(("\\.xsd$" . xml-mode)
                                ("\\.rdf$" . xml-mode)
                                ("\\.atom$" . xml-mode)) auto-mode-alist))

;; nXhtml-mode
(autoload 'django-html-mumamo-mode "~/.emacs.d/elisp/nxhtml/autostart.el")
; (setq auto-mode-alist (append '(("\\.html?$" . django-html-mumamo-mode))
;                              auto-mode-alist))
(setq mumamo-background-colors nil)
; (add-to-list 'auto-mode-alist '("\\.html?$" . django-html-mumamo-mode))

;; js-modeに構文チェッカーを追加(javascript-lint x flymake) Error (6,Feb'11)
;; js-mode用のhookを用意
;; (defun js-mode-hooks ()
;;   ;; キーマップをセット
;;   (setq flymake-jsl-mode-map 'js-mode-map)
;;   ;; flymake-jslを起動するための設定
;;   (when (require 'flymake-jsl nil t)
;;     (setq flymake-check-was-interrupted t)
;;     (flymake-mode t)))
;; ;; js-modeの起動時にhookを追加
;; (add-hook 'js-mode-hook 'js-mode-hooks)


;; "ada"という拡張子には"ada-mode"を使う
; (setq auto-mode-alist (cons '("\\.ada$" . ada-mode) auto-mode-alist)

;; "msg-"で始まるファイル名に"text-mode"を使用
; (setq auto-mode-alist (cons '("^msg-" . text-mode) auto-mode-alist)

;; Gaucheのデフォルトエンコーディングに合わせます。
;; Gaucheのデフォルトエンコーディングがeuc-jpの時はutf-8をeuc-jpに
;; してください。
(setq process-coding-system-alist
      (cons '("gosh" utf-8 . utf-8) process-coding-system-alist))
;; goshインタプリタのパスに合わせます。-iは対話モードを意味します。
(setq gosh-program-name "/usr/local/bin/gosh -i")
;; schemeモードとrun-schemeモードにcmuscheme.elを使用します。
(autoload 'scheme-mode "cmuscheme" "Major mode for Scheme." t)
(autoload 'run-scheme "cmuscheme" "Run an inferior Scheme process." t)
;; ウィンドウを2つに分け、一方でgoshインタプリタを実行するコマンドを定義します。
(defun scheme-other-window ()
  "Run scheme on other window"
  (interactive)
  (switch-to-buffer-other-window
   (get-buffer-create "*scheme*"))
  (run-scheme gosh-program-name))
;; そのコマンドをCtrl-cSで呼び出します。
(define-key global-map
  "\C-cS" 'scheme-other-window)

;; scss (12/12/17)
(autoload 'scss-mode "scss-mode")
(add-to-list 'auto-mode-alist '("\\.scss$" . scss-mode))
(setq css-indent-offset 2)
(setq scss-compile-at-save t)
(setq scss-output-directory "../css")

; コンパイル成功ならバッファを閉じる
(require 'compile)
(defvar yel-compile-auto-close t
  "* If non-nil, a window is automatically closed after (\\[compile]).")
(defadvice compile (after compile-aftercheck activate compile)
  "Adds a funcion of windows auto-close."
  (let ((proc (get-buffer-process "*compilation*")))
    (if (and proc yel-compile-auto-close)
        (set-process-sentinel proc 'yel-compile-teardown))))
(defun yel-compile-teardown (proc status)
  "Closes window automatically, if compile succeed."
  (let ((ps (process-status proc)))
    (if (eq ps 'exit)
        (if (eq 0 (process-exit-status proc))
            (progn
              (delete-other-windows)
              (kill-buffer "*compilation*")
              (message "---- Compile Success ----"))
          (message "Compile Failer")))
    (if (eq ps 'signal)
        (message "Compile Abnormal end"))))

;; 直前/直後の括弧に対応する括弧を光らせます。
(show-paren-mode)

;; 以下はインデントの定義です。
(put 'and-let* 'scheme-indent-function 1)
(put 'begin0 'scheme-indent-function 0)
(put 'call-with-client-socket 'scheme-indent-function 1)
(put 'call-with-input-conversion 'scheme-indent-function 1)
(put 'call-with-input-file 'scheme-indent-function 1)
(put 'call-with-input-process 'scheme-indent-function 1)
(put 'call-with-input-string 'scheme-indent-function 1)
(put 'call-with-iterator 'scheme-indent-function 1)
(put 'call-with-output-conversion 'scheme-indent-function 1)
(put 'call-with-output-file 'scheme-indent-function 1)
(put 'call-with-output-string 'scheme-indent-function 0)
(put 'call-with-temporary-file 'scheme-indent-function 1)
(put 'call-with-values 'scheme-indent-function 1)
(put 'dolist 'scheme-indent-function 1)
(put 'dotimes 'scheme-indent-function 1)
(put 'if-match 'scheme-indent-function 2)
(put 'let*-values 'scheme-indent-function 1)
(put 'let-args 'scheme-indent-function 2)
(put 'let-keywords* 'scheme-indent-function 2)
(put 'let-match 'scheme-indent-function 2)
(put 'let-optionals* 'scheme-indent-function 2)
(put 'let-syntax 'scheme-indent-function 1)
(put 'let-values 'scheme-indent-function 1)
(put 'let/cc 'scheme-indent-function 1)
(put 'let1 'scheme-indent-function 2)
(put 'letrec-syntax 'scheme-indent-function 1)
(put 'make 'scheme-indent-function 1)
(put 'multiple-value-bind 'scheme-indent-function 2)
(put 'match 'scheme-indent-function 1)
(put 'parameterize 'scheme-indent-function 1)
(put 'parse-options 'scheme-indent-function 1)
(put 'receive 'scheme-indent-function 2)
(put 'rxmatch-case 'scheme-indent-function 1)
(put 'rxmatch-cond 'scheme-indent-function 0)
(put 'rxmatch-if  'scheme-indent-function 2)
(put 'rxmatch-let 'scheme-indent-function 2)
(put 'syntax-rules 'scheme-indent-function 1)
(put 'unless 'scheme-indent-function 1)
(put 'until 'scheme-indent-function 1)
(put 'when 'scheme-indent-function 1)
(put 'while 'scheme-indent-function 1)
(put 'with-builder 'scheme-indent-function 1)
(put 'with-error-handler 'scheme-indent-function 0)
(put 'with-error-to-port 'scheme-indent-function 1)
(put 'with-input-conversion 'scheme-indent-function 1)
(put 'with-input-from-port 'scheme-indent-function 1)
(put 'with-input-from-process 'scheme-indent-function 1)
(put 'with-input-from-string 'scheme-indent-function 1)
(put 'with-iterator 'scheme-indent-function 1)
(put 'with-module 'scheme-indent-function 1)
(put 'with-output-conversion 'scheme-indent-function 1)
(put 'with-output-to-port 'scheme-indent-function 1)
(put 'with-output-to-process 'scheme-indent-function 1)
(put 'with-output-to-string 'scheme-indent-function 1)
(put 'with-port-locking 'scheme-indent-function 1)
(put 'with-string-io 'scheme-indent-function 1)
(put 'with-time-counter 'scheme-indent-function 1)
(put 'with-signal-handlers 'scheme-indent-function 1)
(put 'with-locking-mutex 'scheme-indent-function 1)
(put 'guard 'scheme-indent-function 1)

