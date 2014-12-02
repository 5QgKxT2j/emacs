
(require 'yasnippet)
(custom-set-variables '(yas-trigger-key "TAB"))

(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"
        ))
;; 既存スニペットを挿入する
;;(define-key yas-minor-mode-map (kbd "C-c i i") 'yas-insert-snippet)
;; 新規スニペットを作成するバッファを用意する
(define-key yas-minor-mode-map (kbd "C-c i n") 'yas-new-snippet)
;; 既存スニペットを閲覧・編集する
(define-key yas-minor-mode-map (kbd "C-c i v") 'yas-visit-snippet-file)

(yas-global-mode 1)
