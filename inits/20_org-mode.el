
(require 'ox-latex)
(require 'ox-beamer)
;;(require 'org-beamer)
;;(require 'org-latex)
(require 'org-bibtex)

(setq org-startup-folded t)
(setq org-startup-truncated nil)
(add-hook 'org-mode-hook 'turn-on-font-lock)
(setq org-src-fontify-natively t)
(setq browse-url-browser-function 'browse-url-firefox)
(setq org-latex-pdf-process '("latexmk -e '$latex=q/uplatex %S/' -e '$bibtex=q/upbibtex %B/' -e '$makeindex=q/mendex -o %D %S/' -e '$dvipdf=q/dvipdfmx -o %D %S/' -norc -gg -pdfdvi %f"))

(add-hook 'org-mode-hook
      '(lambda ()
         (delete '("\\.pdf\\'" . default) org-file-apps)
         (add-to-list 'org-file-apps '("\\.pdf\\'" . "evince %s"))))

(add-to-list 'org-latex-classes
             '("jsarticle"
"\\documentclass{jsarticle}
 \\usepackage[dvipdfmx]{graphicx}
 \\usepackage{color}
 \\usepackage{atbegshi}
 \\usepackage[dvipdfmx,bookmarks=true,linkcolor=blue]{hyperref}
 \\usepackage{pxjahyper}
 \\usepackage{bookmark}
 \\usepackage{url}
[NO-DEFAULT-PACKAGES]
[PACKAGES]
[EXTRA]"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
(setq org-latex-default-class "jsarticle")

(add-to-list 'org-latex-classes
             '("beamer"
               "\\documentclass[dvipdfmx]{beamer}
\\usepackage{url}
\\usepackage{pxjahyper}
\\usetheme{Berlin}
\\setbeamertemplate{headline}{}
\\setbeamertemplate{footline}[page number]
\\setbeamertemplate{navigation symbols}{}
\\beamertemplatetextbibitems


[NO-DEFAULT-PACKAGES]
[PACKAGES]
[EXTRA]
"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\frame{%s}" . "\\frame*{%s}")
               ("\\block{%s}" . "\\block*{%s}")
))

