;;; g/web/config.el -*- lexical-binding: t; -*-

;; TODO move this configuration to web-dev-mode
(def-package! web-mode
  :init
  (message "running web-mode init hook")
  ;;(run-hooks 'prog-mode-hook)
  (setq web-mode-content-types-alist
        '(("jsx"  . ".*\\.[m]?js[x]?\\'")
          ("jsx"  . ".*\\.tsx\\'")))
  (setq web-mode-enable-current-element-highlight t)
  (setq mweb-submode-indent-offset 2)
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-enable-html-entities-fontification t)
  :config
  ;; (setq-default web-mode-comment-formats
  ;;               (remove '("jsx" . "/*") web-mode-comment-formats))
  ;; (add-to-list 'web-mode-comment-formats '("jsx" . "//"))
  (setq-default web-mode-comment-formats
                (remove '("javascript" . "/*") web-mode-comment-formats))
  (add-to-list 'web-mode-comment-formats '("javascript" . "//"))
  (message "running web-mode config hook")
  (add-hook 'web-mode-hook 'doom|enable-line-numbers)
  (set-company-backend! 'web-mode '(company-web-html company-yasnippet))
  (map! :map web-mode-map
        (:localleader :n "rt" #'web-mode-element-rename)
        "M-/" #'web-mode-comment-or-uncomment
        :i  "SPC" #'self-insert-command
        :n  "M-r" #'doom/web-refresh-browser
        :n  "za"  #'web-mode-fold-or-unfold
        :nv "]a"  #'web-mode-attribute-next
        :nv "[a"  #'web-mode-attribute-previous
        :nv "]t"  #'web-mode-tag-next
        :nv "[t"  #'web-mode-tag-previous
        :nv "]T"  #'web-mode-element-child
        :nv "[T"  #'web-mode-element-parent))


(def-package! web-dev-mode
  :load-path "~/.doom.d/modules/g/web"
  :mode "\\.html?$"
  :mode "\\.jsx?$"
  :mode "\\.tsx$"
  :mode "\\.vue$"
  :init
  (set-lookup-handlers! 'web-dev-mode
    :definition #'tide-jump-to-definition
    :references #'tide-references
    :documentation #'tide-documentation-at-point)

  (message "running web-dev-mode init hook")
  :config
  (message "running web-dev-mode config hook")
  )

(def-package! company-web
  :after web-dev-mode)

