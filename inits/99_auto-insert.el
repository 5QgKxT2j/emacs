
(require 'autoinsert)
(setq auto-insert-directory "~/.emacs.d/template/")
(setq auto-insert-alist
      (nconc '( ("\\.py$" . "template.py")
                ("\\.org" . "template.org")
                ) auto-insert-alist))

(add-hook 'find-file-not-found-hooks 'auto-insert)
