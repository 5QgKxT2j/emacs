
(setq pop-up-windows nil)
(require 'popwin)
;(require 'popwin-yatex)
;  (push '("*YaTeX-typesetting*") popwin:special-display-config)
;  (push '("dvi-preview*") popwin:special-display-config)
(when (require 'popwin nil t)
  (setq anything-samewindow nil)
  (setq display-buffer-function 'popwin:display-buffer)
  (push '("^\*helm.+\*$" :regexp t :height 0.5) popwin:special-display-config)
  (push '("*Completions*" :height 0.4) popwin:special-display-config)
  (push '("*compilatoin*" :height 0.4) popwin:special-display-config)
  (push '("^\*Python.+\*$" :regexp t :height 0.3 :noselect t) popwin:special-display-config)
  (push '("*gnuplot*" :regexp t :height 0.3 :noselect t) popwin:special-display-config)
  (push '(" *auto-async-byte-compile*" :height 0.2 :noselect t) popwin:special-display-config)
  (push '("^\*All.+\*$" :regexp t :height 0.4) popwin:special-display-config)
  (push '(dired-mode :position top) popwin:special-display-config)

  )

(define-key global-map (kbd "C-x p") 'popwin:popup-last-buffer)
(define-key global-map (kbd "C-x SPC") 'popwin:select-popup-window)

