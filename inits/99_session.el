
(require 'session)
(when (require 'session nil t)
(setq session-initialize '(de-saveplace session keys menus places)
      session-globals-include '((kill-ring 50)
                                (session-file-alist 100 t)
                                (file-name-history 100)))
(setq session-globals-max-string 100000000)
(setq session-save-print-spec '(t nil nil))
(setq session-save-file (expand-file-name "~/.emacs.d/var/session"))
(setq history-length t)
(setq session-undo-check -1))   ;; 前回閉じたときの位置にカーソルを復帰
(add-hook 'after-init-hook 'session-initialize)

