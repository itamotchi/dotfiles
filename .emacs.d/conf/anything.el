;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	Anything
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Anything
; (auto-install-batch "anything")
(when (require 'anything nil t)
  (setq
   ;; 候補を表示するまでの時間　デフォルトは0.5
   anything-idle-delay 0.3
   ;; タイプして再描画するまでの時間　デフォルトは0.1
   anything-input-idle-delay 0.2
   ;; 候補の最大表示数　デフォルトは50
   anything-candidate-number-limit 100
   ;; 候補が多い時に体感速度を速くする
   anything-quick-update t
   ;; 候補選択ショートカットをアルファベット順に
   anything-enable-shortcuts 'alphabet)

  ;; (when (require 'anything-config nil t) (5,Feb '11 Error)
  ;; root権限でアクションを実行するときのコマンド　デフォルトは"su"
  ;;   (setq anything-su-or-sudo "sudo"))

  (require 'anything-match-plugin nil t)
  (and (equal current-language-environment "Japanese")
       (executable-find "cmigemo")
       (require 'anything-migemo nil t))
  (when (require 'anything-complete nil t)
    ;; M-xによる補完をAnythingで行う
    ;; (anything-read-string-mode 1)
    ;; lispシンボルの補完候補の再検索時間
    (anything-lisp-complete-symbol-set-timer 150))

  (require 'anything-show-completion nil t)

  (when (require 'auto-install nil t)
    (require 'anything-auto-install nil t))

  (when (require 'descbinds-anything nil t)
    ;; describe-bindingsをAnythigに置き換える
    (descbinds-anything-install))

  (require 'anything-grep nil t))

;; manやinfoなどのドキュメントを検索するコマンド (5,Feb '11 Error)
;; (setq anything-for-document-sources
;;       (list
;;        anything-c-source-man-pages
;;        anything-c-source-info-cl
;;        anything-c-source-info-pages
;;        anything-c-source-info-elisp
;;        anything-c-source-apropos-emacs-commands
;;        anything-c-source-apropos-emacs-functions
;;        anything-c-source-apropos-emacs-variables))

;; (defun anything-for-document ()
;;   "Preconfigured `anything' for anything-for-documet."
;;   (interactive)
;;   (anything anything-for-document-sources
;;             (thing-at-point 'symbol) nil nil nil
;;             "*anything for document*"))

;; MoccurのAnythingインターフェース
;; (install-elisp "http://svn.coderepos.org/share/lang/elisp/anything-c-moccur/trunk/anything-c-moccur.el")
(when (require 'anything-c-moccur nil t)
  (setq
   ;; anything-c-moccur用 `anything-idle-delay'
   anything-c-moccur-anything-idle-delay 0.1
   ;; バッファの情報をハイライトする
   anything-c-moccur-higligt-info-line-flag t
   ;; 現在選択中の候補の位置をほかのwindowに表示する
   anything-c-moccur-enable-auto-look-flag t
   ;; 起動時にポイントの位置の単語を初期パターンにする
   anything-c-moccur-enable-initial-pattern t)

  (global-set-key (kbd "C-M-o") 'anything-c-moccur-occur-by-moccur))
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(safe-local-variable-values (quote ((encoding . utf-8) (use-touten-for-comma . t) (use-kuten-for-period . t)))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
