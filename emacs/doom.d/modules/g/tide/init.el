;;; g/tide/init.el -*- lexical-binding: t; -*-

;; (def-package-hook! typescript-mode
;;   :post-config
;;   (defun g/init-flycheck-tslint()
;;     (when-let* ((exec-path (list (doom-project-expand "node_modules/.bin")))
;;                 (tslint (executable-find "tslint")))
;;       (setq-local flycheck-typescript-tslint-executable tslint)))
;;   (add-hook 'flycheck-mode-hook #'g/init-flycheck-tslint))
