;;; g/graphql/config.el -*- lexical-binding: t; -*-


(defun graphql-init()
  (message "initializing graphql")
  (doom|enable-line-numbers))

(def-package! graphql-mode
  :mode "\\.graphql$")
