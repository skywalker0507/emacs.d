;;隐藏工具栏
(tool-bar-mode -1)


;; UTF-8 settings
(set-language-environment "UTF-8")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(modify-coding-system-alist 'process "*" 'utf-8)


	

;可以设置开启的时候不显示欢迎界面：
(setq inhibit-startup-message t)

;;关闭警告声音
 (setq ring-bell-function 'ignore)
 
 ;;在mode line显示行号和列
(require 'linum)
(global-linum-mode t) 

(setq-default cursor-type 'bar) ; 设置光标为竖线 
;;(setq-default cursor-type 'box) ; 设置光标为方块 


;; 显示时间，格式如下  
(display-time-mode 1)  
(setq display-time-24hr-format t)  
(setq display-time-day-and-date t)  
  
 ;;选择区域时高亮
(transient-mark-mode t)  


(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil t)
  (url-retrieve
   "https://github.com/dimitri/el-get/raw/master/el-get-install.el"
   (lambda (s)
     (end-of-buffer)
     (eval-print-last-sexp))))

;; now set our own packages
(setq
 my:el-get-packages
 '(
el-get
yasnippet
color-theme
color-theme-solarized
neotree
yasnippet
auto-complete
autopair
rainbow-mode
racket-mode
smex
))	               


(setq my:el-get-packages
      (append my:el-get-packages
              (mapcar #'el-get-source-name el-get-sources)))

;; install new packages and init already installed packages
(el-get 'sync my:el-get-packages)



(require 'color-theme-solarized)
(color-theme-solarized)


;;neotree配置
(require 'neotree)
  (global-set-key [f8] 'neotree-toggle)
  
(require 'yasnippet)
(yas-global-mode 1)

; org-mode export to latex
(require 'ox-latex)
(setq org-src-fontify-natively t)
(setq org-export-latex-listings t)
; org-mode source code setup in exporting to latex
(add-to-list 'org-latex-listings '("" "listings"))
(add-to-list 'org-latex-listings '("" "color"))

(add-to-list 'org-latex-packages-alist
             '("" "hyperref" t))
(add-to-list 'org-latex-packages-alist
         '("" "xcolor" t))
(add-to-list 'org-latex-packages-alist
         '("" "listings" t))
(add-to-list 'org-latex-packages-alist
         '("" "fontspec" t))
(add-to-list 'org-latex-packages-alist
         '("" "indentfirst" t))
(add-to-list 'org-latex-packages-alist
         '("" "xunicode" t))
(add-to-list 'org-latex-packages-alist
         '("" "amsmath"))
(add-to-list 'org-latex-packages-alist
         '("" "graphicx" t))

(add-to-list 'org-latex-classes
          '("my-org-book-zh"
"\\documentclass{book}
\\usepackage[slantfont, boldfont]{xeCJK}
% chapter set
\\usepackage[Lenny]{fncychap}
[NO-DEFAULT-PACKAGES]
[PACKAGES]
\\setCJKmainfont{SimSun} % 设置缺省中文字体
\\parindent 2em

\\setmainfont{Times New Roman} % 英文衬线字体
\\setsansfont{Source Code Pro} % 英文无衬线字体
\\setmonofont{Source Code Pro} % 英文等宽字体


\\defaultfontfeatures{Mapping=tex-text} %如果没有它，会有一些 tex 特殊字符无法正常使用，比如连字符。

% 中文断行
\\XeTeXlinebreaklocale \"zh\"
\\XeTeXlinebreakskip = 0pt plus 1pt minus 0.1pt

% 代码设置
\\lstset{
numbers=left, 
basicstyle=\\ttfamily,
numberstyle= \\tiny, 
keywordstyle= \\color{ blue!70}, % 设定相应语言中关键字颜色
commentstyle=\\color{red!50!green!50!blue!50},    % 设定注释部分字体
frame=shadowbox, % 设定代码区边框
breaklines=true,  % 设定LaTeX对过长的代码行进行自动换行
showstringspaces=false,   % 设定代码中字符串的空格正常显示
rulesepcolor= \\color{ red!20!green!20!blue!20} 
} 

[EXTRA]
"
             ("\\chapter{%s}" . "\\chapter*{%s}")
             ("\\section{%s}" . "\\section*{%s}")
             ("\\subsection{%s}" . "\\subsection*{%s}")
             ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
             ("\\paragraph{%s}" . "\\paragraph*{%s}")
             ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(add-to-list 'org-latex-classes
          '("my-org-article-zh"
"\\documentclass{article}
\\usepackage[slantfont, boldfont]{xeCJK}
[NO-DEFAULT-PACKAGES]
[PACKAGES]
\\setCJKmainfont{SimSun} % 设置缺省中文字体
\\parindent 2em

\\setmainfont{Times New Roman} % 英文衬线字体
\\setsansfont{Times New Roman} % 英文无衬线字体
\\setmonofont{Source Code Pro} % 英文等宽字体
%\\punctstyle{Times New Roman} % 开明式标点格式


\\defaultfontfeatures{Mapping=tex-text} %如果没有它，会有一些 tex 特殊字符无法正常使用，比如连字符。

% 中文断行
\\XeTeXlinebreaklocale \"zh\"
\\XeTeXlinebreakskip = 0pt plus 1pt minus 0.1pt

% 代码设置
\\lstset{numbers=left, 
basicstyle=\\ttfamily,
numberstyle= \\tiny, 
keywordstyle= \\color{ blue!70},commentstyle=\\color{red!50!green!50!blue!50}, 
frame=shadowbox, 
breaklines=true,
rulesepcolor= \\color{ red!20!green!20!blue!20} 
} 

[EXTRA]
"
             ("\\section{%s}" . "\\section*{%s}")
             ("\\subsection{%s}" . "\\subsection*{%s}")
             ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
             ("\\paragraph{%s}" . "\\paragraph*{%s}")
             ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(setq org-latex-pdf-process
      '("xelatex -interaction nonstopmode %b"
    "xelatex -interaction nonstopmode %b"))




(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)


(require 'rainbow-mode)
(define-globalized-minor-mode my-global-rainbow-mode rainbow-mode
  (lambda () (rainbow-mode 1)))

(my-global-rainbow-mode 1)

(require 'smex) ; Not needed if you use package.el
(smex-initialize) ; Can be omitted. This might cause a (minimal) delay
                  ; when Smex is auto-initialized on its first run.
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
