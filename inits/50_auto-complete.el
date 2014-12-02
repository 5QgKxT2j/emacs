
(require 'auto-complete)
(require 'auto-complete-config)
(require 'ac-math)
;;(require 'org-ac)
;;(org-ac/config-default)

(add-to-list 'ac-dictionary-directories "~/.emacs.d/dict")
(ac-flyspell-workaround)

;; すべてのmodeでauto-completeを有効化
(defun auto-complete-mode-maybe ()
  (unless (minibufferp (current-buffer))
    (auto-complete-mode t)))
(global-auto-complete-mode t)

;; 補完メニュー表示時のみC-n/C-pで補完候補を選択する
(setq ac-use-menu-map t)
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)

;; 大文字・小文字を区別しない
(setq ac-ignore-case t)

;; 標準情報源再定義
(setq-default ac-sources
              '(ac-source-filename
                ac-source-yasnippet
                ac-source-words-in-same-mode-buffers
                ac-source-abbrev
                ac-source-dictionary))

;; delay指定
(setq ac-auto-show-menu 0.3)                   ; 0.3秒でメニュー表示
(setq ac-use-comphist t)                       ; 補完候補をソート
(setq ac-candidate-limit nil)                  ; 補完候補表示を無制限に

(set-face-font 'ac-candidate-face "ricty 14")
(set-face-font 'ac-selection-face "ricty 14")

