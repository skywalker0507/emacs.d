;;隐藏工具栏
(tool-bar-mode -1)

;;关闭警告声音
 (setq ring-bell-function 'ignore)
 
 ;;在mode line显示行号和列
(require 'linum)
(global-linum-mode t) 

(setq-default cursor-type 'bar) ; 设置光标为竖线 
;;(setq-default cursor-type 'box) ; 设置光标为方块 



(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil t)
  (url-retrieve
   "https://github.com/dimitri/el-get/raw/master/el-get-install.el"
   (lambda (s)
     (end-of-buffer)
     (eval-print-last-sexp))))

;; now either el-get is `require'd already, or have been `load'ed by the
;; el-get installer.

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
auto-complete-clang
autopair
org-mode
rainbow-mode
   
))	               

;
;; Some recipes require extra tools to be installed
;;
;; Note: el-get-install requires git, so we know we have at least that.
;;
(when (el-get-executable-find "cvs")
  (add-to-list 'my:el-get-packages 'emacs-goodies-el)) ; the debian addons for emacs

(when (el-get-executable-find "svn")
  (loop for p in '(psvn    		; M-x svn-status
		   yasnippet		; powerful snippet mode
		   )
	do (add-to-list 'my:el-get-packages p)))

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
  


(require 'auto-complete-clang)  
(setq ac-clang-auto-save t)  
(setq ac-auto-start t)  
(setq ac-quick-help-delay 0.5)  
;; (ac-set-trigger-key "TAB")  
;; (define-key ac-mode-map  [(control tab)] 'auto-complete)  
(define-key ac-mode-map  [(control tab)] 'auto-complete)  
(defun my-ac-config ()  
  (setq ac-clang-flags  
        (mapcar(lambda (item)(concat "-I" item))  
               (split-string  
                "  
 /usr/lib64/gcc/x86_64-suse-linux/4.8/include
 /usr/local/include
 /usr/lib64/gcc/x86_64-suse-linux/4.8/include-fixed
 /usr/lib64/gcc/x86_64-suse-linux/4.8/../../../../x86_64-suse-linux/include
 /usr/include
 
 ;/usr/include/c++/4.8
 ;/usr/include/c++/4.8/x86_64-suse-linux
 ;/usr/include/c++/4.8/backward
 
"))) 
 

  (setq-default ac-sources '(ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))  
  (add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)  
  ;; (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)  
  (add-hook 'ruby-mode-hook 'ac-ruby-mode-setup)  
  (add-hook 'css-mode-hook 'ac-css-mode-setup)  
  (add-hook 'auto-complete-mode-hook 'ac-common-setup)  
  (global-auto-complete-mode t))  
(defun my-ac-cc-mode-setup ()  
  (setq ac-sources (append '(ac-source-clang ac-source-yasnippet) ac-sources)))  
(add-hook 'c-mode-common-hook 'my-ac-cc-mode-setup)  
;; ac-source-gtags  
(my-ac-config) 



(require 'yasnippet)
(yas-global-mode 1)


(require 'org)
(setq org-src-fontify-natively t)
;(setq org-ditaa-jar-path "/home/liuqiang/.emacs.d/el-get/org-mode/contrib/scripts/ditaa.jar"
;)



(add-hook 'org-babel-after-execute-hook 'bh/display-inline-images 'append)

; Make babel results blocks lowercase
(setq org-babel-results-keyword "results")

(defun bh/display-inline-images ()
  (condition-case nil
      (org-display-inline-images)
    (error nil)))


(org-babel-do-load-languages
 'org-babel-load-languages
 '((ditaa . t))) ; this line activates ditaa
(add-hook 'org-babel-after-execute-hook 'bh/display-inline-images 'append)
; Make babel results blocks lowercase
;(setq org-babel-results-keyword "results")



(require 'rainbow-mode)
(define-globalized-minor-mode my-global-rainbow-mode rainbow-mode
  (lambda () (rainbow-mode 1)))

(my-global-rainbow-mode 1)
