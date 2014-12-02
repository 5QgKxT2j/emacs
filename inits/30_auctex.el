
(require 'tex-jp)
(require 'tex-site)
(setq Tex-default-mode 'japanese-latex-mode)
(setq japanese-LaTeX-command-default "LatexMk")
(setq japanese-BibTeX-command "pbibtex")
(setq japanese-LaTeX-default-style "jsarticle")

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(setq reftex-insert-label-flags '("s" "sfte")

(add-hook 'LaTeX-mode-hook 'AUCTeX)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

;; viewer をコマンドに追加
(add-to-list 'TeX-command-list
             '("Evince" "evince %s.pdf"
               TeX-run-discard-or-function t t :help "Run Evince"))
(add-to-list 'TeX-command-list
             '("Acroread" "acroread %s.pdf"
               TeX-run-discard-or-function t t :help "Run Adobe Reader"))
;; kinsoku.el
(setq kinsoku-limit 10)

;;auctex-latexmk
(require 'auctex-latexmk)
(auctex-latexmk-setup)

;;RefTeX
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
(setq reftex-bibliography-commands '("bibliography" "nobibliography" "addbibresource"))

