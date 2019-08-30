;;; g/haskell/config.el -*- lexical-binding: t; -*-


(after! haskell-mode
  (set-repl-handler! 'haskell-mode #'switch-to-haskell)
  (add-to-list 'completion-ignored-extensions ".hi"))
