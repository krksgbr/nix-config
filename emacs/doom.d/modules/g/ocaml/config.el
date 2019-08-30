;;; g/ocaml/config.el -*- lexical-binding: t; -*-

(def-package! tuareg
  :mode ("\\.ml[4ilpy]?$" . tuareg-mode)
  :config
  (message "configuring tuareg"))

;; (let* ((opam-share (ignore-errors (car (process-lines "opam" "config" "var" "share"))))
;;        (merlin-load-path (expand-file-name "emacs/site-lisp" opam-share)))
;;   (message "loading merlin from %s" merlin-load-path)
;;   (def-package! merlin
;;     :load-path 'merlin-load-path
;;     :after tuareg
;;     :init
;;     :config
;;   (message "loading merlin from %s" merlin-load-path)))
;;


(def-package! reason-mode
  :mode ("\\.re?$")
  :config
  (message "configuring reason-mode"))

(def-package! merlin
  :after (:any tuareg reason-mode)
  :init
  (setq merlin-command "ocamlmerlin")
  :config
  (message "configuring merlin"))

(def-package! lsp-ocaml
  ;;:after tuareg
  :hook ((tuareg-mode reason-mode) . lsp-ocaml-enable)
  :config
  (message "configuring lsp-ocaml"))
