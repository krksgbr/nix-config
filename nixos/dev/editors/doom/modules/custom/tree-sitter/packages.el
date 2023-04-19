;; -*- no-byte-compile: t; -*-
;;; custom/tree-sitter/packages.el

(package! tree-sitter
  :ignore (null (bound-and-true-p module-file-suffix))
  :pin "401f7fb7421185f0e442b989f8ed2d15315f04aa")
(package! tree-sitter-langs
  :ignore (null (bound-and-true-p module-file-suffix))
  :pin "75e0aa3253a25643e8b377c8f5ab10fe720d5d01")
