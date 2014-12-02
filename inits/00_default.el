
;; site-lisp に load-path を通す
(let ((default-directory (expand-file-name "~/.emacs.d/site-lisp")))
 (add-to-list 'load-path default-directory)
  (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
      (normal-top-level-add-subdirs-to-load-path)))

;; server start
(require 'server)
(server-start)

;;バッファ自動再読み込み
(global-auto-revert-mode 1)

;;; *.~ のバックアップファイルを作らない
(setq make-backup-files nil)

;; auto-save
(require 'auto-save-buffers-enhanced)
(setq auto-save-buffers-enhanced-interval 20)
(auto-save-buffers-enhanced t)

;; 起動画面を表示しない
(setq inhibit-splash-screen t)

;; ツールバーを非表示
(tool-bar-mode -1)

;; メニューバーを非表示
(menu-bar-mode -1)

;; スクロールバー非表示
(set-scroll-bar-mode nil)

;; 矩形選択
(cua-mode t)
(setq cua-enable-cua-keys nil)

; 言語を日本語にする
(set-language-environment 'Japanese)

; できるだけ UTF-8 にする
(prefer-coding-system 'utf-8-unix)
;;(set-keyboard-coding-system 'utf-8)

;; ソースに色付け
(global-font-lock-mode t)

;;選択範囲のハイライト
(setq-default transient-mark-mode t)

;; 行末の white space 強調表示
(setq-default show-trailing-whitespace t)

;;yank した文字列をハイライト表示する
(when (or window-system (eq emacs-major-version '21))
  (defadvice yank (after ys:highlight-string activate)
    (let ((ol (make-overlay (mark t) (point))))
      (overlay-put ol 'face 'highlight)
      (sit-for 0.5)
     (delete-overlay ol)))
  (defadvice yank-pop (after ys:highlight-string activate)
    (when (eq last-command 'yank)
      (let ((ol (make-overlay (mark t) (point))))
	(overlay-put ol 'face 'highlight)
	(sit-for 0.5)
	(delete-overlay ol)))))

;; 自動で改行しない
(setq next-line-add-newlines nil)

;; indent 幅 4
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; turn off sound
(setq visible-bell t)
(setq ring-bell-function 'ignore)

;; find file の補完で大文字小文字を区別しない
(setq completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)

;; 圧縮されたファイルも編集できるようにする
(auto-compression-mode t)

;; 同名ファイルがあれば，その一階層上まで表示する
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; 行番号表示
(global-linum-mode t)
(set-face-attribute 'linum nil
                    :foreground "#CCC"
                    :height 0.9)

;; 行番号フォーマット
;;(setq linum-format "%3d")

;; 対応する括弧に色をつける
(show-paren-mode 1)

;; X-window のクリップボードと emacs のクリップボードの同期をとる
(setq x-select-enable-clipboard t)

;; Changes all yes/no questions to y/n type
(fset 'yes-or-no-p 'y-or-n-p)

;; backspace を C-h にバインドする
(global-set-key "\C-h" 'delete-backward-char)

;; isearch 時に C-h で backspace
(define-key isearch-mode-map (kbd "C-h") 'isearch-delete-char)

;;C-h (BackSpace) でリージョンを一括削除
(delete-selection-mode 1)

;;60 文字で自動改行
(setq fill-column 60)
(setq text-mode-hook 'turn-on-auto-fill)
(setq major-mode 'text-mode)

;; refill mode を C-c q にバインド
(global-set-key (kbd "C-c q") 'refill-mode)

;; emacs 高速化
(modify-frame-parameters nil '((wait-for-wm . nil)))

;; *scratch* で最初に書かれる message を消す
(setq initial-scratch-message "")

;; load environment value
(load-file (expand-file-name "~/.emacs.d/var/shellenv.el"))
(dolist (path (reverse (split-string (getenv "PATH") ":")))
  (add-to-list 'exec-path path))

;; auto-sudo
(defun file-root-p (filename)
  "Return t if file FILENAME created by root."
  (eq 0 (nth 2 (file-attributes filename))))

(defun th-rename-tramp-buffer ()
  (when (file-remote-p (buffer-file-name))
    (rename-buffer
     (format "%s:%s"
             (file-remote-p (buffer-file-name) 'method)
             (buffer-name)))))

(add-hook 'find-file-hook
          'th-rename-tramp-buffer)

(defadvice find-file (around th-find-file activate)
  "Open FILENAME using tramp's sudo method if it's read-only."
  (if (and (file-root-p (ad-get-arg 0))
           (not (file-writable-p (ad-get-arg 0)))
           (y-or-n-p (concat "File "
                             (ad-get-arg 0)
                             " is read-only.  Open it as root? ")))
      (th-find-file-sudo (ad-get-arg 0))
    ad-do-it))

(defun th-find-file-sudo (file)
  "Opens FILE with root privileges."
  (interactive "F")
  (set-buffer (find-file (concat "/sudo::" file))))

(require 'zlc)
(zlc-mode t)

;; "Lisp nesting exceeds max-lisp-eval-depth"への対処
(setq max-lisp-eval-depth 1000)

;; "Variable binding depth exceeds max-specpdl-size"への対処
(setq max-specpdl-size 1867)
