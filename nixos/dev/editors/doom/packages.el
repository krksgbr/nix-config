;; -*- no-byte-compile: t; -*-
;;; private/default/packages.el

;; core

;; extras
;;(package! emacs-snippets
;;  :recipe (:fetcher github
;;           :repo "hlissner/emacs-snippets"
;;           :files ("*")))


(package! exec-path-from-shell)
(package! prettier-js)
(package! example
  :recipe (:host github :repo "mickeynp/ligature.el"))
