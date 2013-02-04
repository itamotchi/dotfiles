;; 行頭の一個以上のアスタリスクを全て取り除く関数
(defun remove-outline-marks ()
  "Rrmove section header marks created in outline-mode."
  (interactive)
  (replace-regexp "^\\*+" ""))
