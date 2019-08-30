;;; g/lsp/config.el -*- lexical-binding: t; -*-

(def-package! lsp-mode
  :config
  (message "configuring lsp-mode")
  (add-hook 'lsp-mode-hook #'flycheck-mode))

(def-package! lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :init
  (setq lsp-ui-sideline-enable nil)
  (setq lsp-ui-peek-enable nil)
  (setq lsp-ui-doc-enable nil)
  (setq lsp-ui-imenu-enable nil)
  (setq lsp-ui-flycheck-enable t)
  :config
  (message "configuring lsp-ui-mode")
  )
