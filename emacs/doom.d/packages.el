;; -*- no-byte-compile: t; -*-
;;; private/default/packages.el

;; core

;; extras
(package! emacs-snippets
  :recipe (:fetcher github
           :repo "hlissner/emacs-snippets"
           :files ("*")))
