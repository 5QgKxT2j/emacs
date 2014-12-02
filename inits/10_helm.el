
(require 'helm-config)
(require 'helm-command)
(require 'ac-helm)
(require 'helm-c-yasnippet)
;;(require 'helm-migemo)

(setq helm-idle-delay             0.1
      helm-input-idle-delay       0.1
      helm-candidate-number-limit 300)

;(eval-after-load 'helm
;  '(progn
;     (define-key helm-map (kbd "C-h") 'delete-backward-char)
;     ))

(define-key helm-map (kbd "C-h") 'delete-backward-char)
(define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)

;;(define-key global-map (kbd "C-x C-f") 'helm-find-files)
(define-key global-map (kbd "C-x C-b") 'helm-buffers-list)
(define-key global-map (kbd "C-x C-r")   'helm-for-files)
(define-key global-map (kbd "M-x") 'helm-M-x)
(define-key global-map (kbd "M-y") 'helm-show-kill-ring)
(define-key global-map (kbd "C-c i i") 'helm-c-yas-complete)
(define-key global-map (kbd "C-M-o") 'helm-occur)

;;(setq helm-use-migemo t)

;; ミニバッファで C-k 入力時にカーソル以降を削除する（C-u C-k でも同様の動きをする）
(setq helm-delete-minibuffer-contents-from-point t)

(defadvice helm-ff-kill-or-find-buffer-fname (around execute-only-if-exist activate)
  "Execute command only if CANDIDATE exists"
  (when (file-exists-p candidate)
    ad-do-it))


;; all
(require 'all-ext)
(define-key helm-map (kbd "C-c C-a") 'all-from-helm-occur)

;; helm-auto-complete
(global-set-key (kbd "C-:") 'ac-complete-with-helm)
(define-key ac-complete-mode-map (kbd "C-:") 'ac-complete-with-helm)


;; 自動補完を無効
;;(custom-set-variables '(helm-ff-auto-update-initial-value nil))
;; TABで任意補完。選択肢が出てきたらC-nやC-pで上下移動してから決定することも可能
;;(define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
;;(define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)

