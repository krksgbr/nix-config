;;; g/tide/config.el -*- lexical-binding: t; -*-

(def-package! typescript-mode
  :mode "\\.ts$"
  :config

  (set-electric! 'typescript-mode :chars '(?\} ?\)) :words '("||" "&&"))

  ;; TODO tide-jump-back
  ;; TODO (tide-jump-to-definition t)
  ;; TODO convert into keybinds
  ;; (set! :emr 'typescript-mode
  ;;       '(tide-find-references             "find usages")
  ;;       '(tide-rename-symbol               "rename symbol")
  ;;       '(tide-jump-to-definition          "jump to definition")
  ;;       '(tide-documentation-at-point      "current type documentation")
  ;;       '(tide-restart-server              "restart tide server"))
  )

(setq g/tide-format-fn nil)

(def-package! tide
  :after (:any typescript-mode web-dev-mode)
  :config
  (message "running tide-mode config")
  (add-hook 'tide-mode-hook #'rainbow-delimiters-mode)
  (set-lookup-handlers! 'typescript-mode
    :definition #'tide-jump-to-definition
    :references #'tide-references
    :documentation #'tide-documentation-at-point)

  (setq tide-format-options
        '(:insertSpaceAfterFunctionKeywordForAnonymousFunctions t
          :placeOpenBraceOnNewLineForFunctions nil))

  (set-evil-initial-state! 'tide-references-mode 'motion)
  (map! :map tide-references-mode-map
        :m "j" #'tide-find-next-reference
        :m "k" #'tide-find-previous-reference
        :m "n" #'tide-find-next-reference
        :m "p" #'tide-find-previous-reference
        :m "C-m" #'tide-goto-reference)

  (defun init-tide ()
    (let ((ext (file-name-extension buffer-file-name)))
      (when (or (member major-mode '(typescript-mode js-mode))
                (and (eq major-mode 'web-dev-mode)
                     buffer-file-name
                     (member ext '("js" "jsx" "tsx"))))
        (tide-setup)
        (flycheck-mode +1)
        (eldoc-mode +1)
        (tide-hl-identifier-mode t)
        ;; (company-mode t)
        (set-company-backend! :derived 'web-mode 'company-tide)
        (setq tide-project-root (doom-project-root))
        (setq-default flycheck-disabled-checkers
                      (append flycheck-disabled-checkers '(handlebars)))

        (cond ((member ext '("js" "jsx"))
               (flycheck-add-mode 'javascript-tide 'web-dev-mode)
               (flycheck-add-mode 'jsx-tide 'web-dev-mode)
               (flycheck-add-mode 'javascript-eslint 'web-dev-mode)
               ;; (setq flycheck-checker 'jsx-tide)
               ;; (setq-default flycheck-disabled-checkers
               ;;               (append flycheck-disabled-checkers '(tsx-tide)))
               ;; (flycheck-add-next-checker 'jsx-tide '(t . javascript-eslint) 'append)
               (setq g/tide-format-fn 'prettier-js))

              ((string-equal ext "ts")
               (flycheck-add-mode 'typescript-tide 'web-dev-mode)
               ;; (setq flycheck-checker 'typescript-tide)
               ;; (setq-default flycheck-disabled-checkers
               ;;               (append flycheck-disabled-checkers '(jsx-tide)))
               ;; (flycheck-add-next-checker 'typescript-tide '(t . typescript-tslint) 'append)
               (setq g/tide-format-fn 'prettier-js))


              ((string-equal ext "tsx")
               (flycheck-add-mode 'tsx-tide 'web-dev-mode)
               ;; (setq flycheck-checker 'tsx-tide)
               ;; (setq-default flycheck-disabled-checkers
               ;;               (append flycheck-disabled-checkers '(jsx-tide)))
               ;; (flycheck-add-next-checker 'tsx-tide '(t . typescript-tslint) 'append)
               (setq g/tide-format/fn 'prettier-js))))))

  (add-hook! (typescript-mode web-dev-mode) #'init-tide))

(def-package! eslintd-fix
  :commands (eslintd-fix-mode eslintd-fix))

;;(def-project-mode! +npm-mode
;;  :modes (html-mode css-mode web-dev-mode typescript-mode markdown-mode)
;;  :files "package.json"
;;  :on-enter
;;  (when (make-local-variable 'exec-path)
;;    (let* ((npm-project-root (projectile-locate-dominating-file (projectile-project-root) "package.json"))
;;           (npm-bin (concat npm-project-root "node_modules/.bin")))
;;      (message "adding %s to exec-path" npm-bin)
;;      (push npm-bin exec-path))))
