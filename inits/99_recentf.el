
(require 'recentf)
(require 'recentf-ext)
(setq recentf-save-file "~/.emacs.d/var/recentf")
(setq recentf-exclude '("recentf" "session"))
(setq recentf-max-saved-items 2000)
;;(setq recentf-auto-cleanup 'never)
(setq recentf-auto-cleanup 100)
 (setq recentf-auto-save-timer
        (run-with-idle-timer 300 t 'recentf-save-list))
(defadvice recentf-open-files (after recentf-set-overlay-directory-adv activate)
(set-buffer "*Open Recent*")
(save-excursion
(while (re-search-forward "\\(^ \\[[0-9]\\] \\|^ \\)\\(.*/\\)$" nil t nil)
(overlay-put (make-overlay (match-beginning 2) (match-end 2))
'face `((:foreground ,"#F1266F"))))))

(recentf-mode 1)
