;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	Elisp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; grep-edit
(require 'grep-edit)

;; Migemo (4,Feb '11 起動しない)
;; (when (and (executable-find "cmigemo")
;;            (require 'migemo nil t))
;;   ;; cmigemoを使う
;;   (setq migemo-command "cmigemo")
;;   ;; Migemoコマンドラインオプション
;;   (setq migemo-options '("-q" "--emacs" "-i" "\a"))
;;   ;; Migemo辞書の場所
;;   (setq migemo-dictionary
;;         "/usr/local/share/migemo/utf-8/migemo-dict")
;;   ;; cmigemoで必須の設定
;;   (setq migemo-user-dictionary nil)
;;   (setq migemo-regex-dictionary nil)
;;   ;; キャッシュの設定
;;   (setq migemo-use-pattern-alist t)
;;   (setq migemo-use-frequent-pattern-alist t)
;;   (setq migemo-pattern-alist-length 1000)
;;   (setq migemo-coding-system 'utf-8-unix)
;;   (load-library "migemo")
;;   ;; Migemoを起動する
;;   (migemo-init))

;; color-moccur & moccur-edit
(when (require 'color-moccur nil t)
  ;; グローバルマップにoccur-by-moccurを割り当て
  (define-key global-map (kbd "M-o") 'occur-by-moccur)
  ;; スペース区切りでAND検索
  (setq moccur-split-word t)
  ;; ディレクトリ検索のとき除外するファイル
  (add-to-list 'dmoccur-exclusion-mask "\\.DS_Store")
  (add-to-list 'dmoccur-exclusion-mask "^#.+#$")

  (require 'moccur-edit nil t)
  ;; Migemoを利用できる環境であればMigemoを使う
  (when (and (executable-find "cmigemo")
             (require 'migemo nil t))
    (setq moccur-use-migemo t)))

;; Moccurで編集の終了と同時にファイル保存をする
(defadvice moccur-edit-change-file
  (after save-after-moccur-edit-buffer activate)
  (save-buffer))

;; Undo History
(when (require 'undohist nil t)
  (undohist-initialize))

;; Undo Tree
; (when 
    (require 'undo-tree; nil t)
;  (global-undo-tree-mode) ; デフォルトでundo-treeを起動
             )

;; Point Undo
(when (require 'point-undo nil t)
  (define-key global-map [f5] 'point-undo)
  (define-key global-map [f6] 'point-redo))

;; wdired
(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

;; auto-complete
;(when (require 'auto-complete-config nil t)
;  (add-to-list 'ac-dictionary-directories
;               "~/.emacs.d/elisp/ac-dict")
;  (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
;  (ac-config-default))

;; smartchr (4,Feb '11 適切な使い道が現れた時使いましょう)
;; (when (require 'smartchr nil t)
;;   (define-key global-map
;;     (kbd "=") (smartchr '("=" " = " " == " " === "))))

;; ElScreen (4,Feb '11 File error: Cannot open load file, alist)
;; (when (require 'elscreen nil t)
;;   (if window-system
;;       (define-key elscreen-map (kbd "C-z")
;;         'iconify-or-deiconify-frame)
;;     (define-key elscreen-map (kbd "C-z")
;;       'suspend-emacs)))

;; tramp (add (11, apr 2011) miitsy)
; (add-to-list 'load-path "~/.emacs.d/tramp/lisp/")
; ~/.emacs.d/trampディレクトリをelisp以下にした
(require 'tramp)

;; sudo-ext (add (11, apr 2011) miitsy)
(require 'sudo-ext)
