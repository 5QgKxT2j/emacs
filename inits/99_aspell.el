
(setq-default ispell-program-name "aspell")

(eval-after-load "ispell"
 '(add-to-list 'ispell-skip-region-alist '("[^\000-\377]+")))

;; Flyspell
;; FlySpellの逐次スペルチェックを使用するモードの指定
(defun my-flyspell-mode-enable ()
  (flyspell-mode 1))
(mapc
 (lambda (hook)
   (add-hook hook 'my-flyspell-mode-enable))
 '(
   org-mode-hook
   text-mode-hook
   latex-mode-hook
   )
 )
