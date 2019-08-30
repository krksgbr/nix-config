;;; g/elm/config.el -*- lexical-binding: t; -*-

(def-package! elm-mode
  :mode "\\.elm$"
  :config
  ;;(load "elm-mode-autoloads" nil t)
  (setq elm-format-on-save nil)
  (setq flycheck-elm-executable "elm make")
  (add-hook! 'elm-mode-hook #'(flycheck-mode rainbow-delimiters-mode))
  (set-company-backend! 'elm-mode '(company-elm))
  (set-repl-handler! 'elm-mode #'run-elm-interactive)
  (set-lookup-handlers! 'elm-mode
    :definition #'projectile-find-tag
    :references #'projectile-find-tag)
  )


(def-package! flycheck-elm
  :after (:all flycheck elm-mode)
  :hook (flycheck-mode . flycheck-elm-setup))
