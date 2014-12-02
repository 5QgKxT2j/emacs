
(require 'text-adjust)
 (defun text-adjust-before-save-if-needed ()
   (when (memq major-mode
               '(org-mode text-mode latex-mode))
     (text-adjust-buffer)))
 (defalias 'spacer 'text-adjust-buffer)
 (add-hook 'before-save-hook 'text-adjust-before-save-if-needed)

