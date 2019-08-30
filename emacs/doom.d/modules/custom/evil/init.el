;;; custom/evil/init.el -*- lexical-binding: t; -*-

(def-package-hook! evil
  :post-init
  (setq evil-want-Y-yank-to-eol nil))
