;;; g/web/web-dev-mode.el -*- lexical-binding: t; -*-

;; TODO merge tide-mode here
(define-derived-mode web-dev-mode web-mode "WebDev"
  "Custom major mode for js development based on web-mode and tide"
  (message "running web-dev-mode"))

(provide 'web-dev-mode)
