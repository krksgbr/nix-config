;;; g/haskell/config.el -*- lexical-binding: t; -*-


(def-package! lsp-haskell
  :hook ((haskel-mode) . lsp-haskell-enable)
  :config 
  (message "configuring lsp-haskell"))
