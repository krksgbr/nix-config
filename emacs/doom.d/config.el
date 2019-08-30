;;; config.el --- description -*- lexical-binding: t; -*-

(tool-bar-mode -1)
(defun g/edit-config()
  (interactive)
  (find-file (expand-file-name "config.el" doom-private-dir)))

(defun g/edit-bindings()
  (interactive)
  (find-file (expand-file-name "+bindings.el" doom-private-dir)))

(defun g/reload-config()
  (interactive)
  (load-file user-init-file))

(defun g/edit-doom-config()
  (interactive)
  (doom-project-find-file doom-emacs-dir))


;; hooks

;; these interfere with auto-save
(remove-hook! emacs-lisp-mode #'(doom|enable-delete-trailing-whitespace auto-compile-on-save-mode))
;; to be able to save silently
(remove-hook 'after-save-hook #'+evil|save-buffer)
(remove-hook '+write-mode-hook #'mixed-pitch-mode)

(add-hook 'prog-mode-hook #'rainbow-mode)

(load! "+bindings")
(setq +write-mode-hook
      #'(visual-fill-column-mode
         visual-line-mode
         +write|init-org-mode))

;;(after! yasnippet
  ;;(setq g/snippets-dir (concat +private-config-path "/snippets"))
  ;;(setq yas--default-user-snippets-dir g/snippets-dir)
  ;;(add-to-list 'yas-snippet-dirs g/snippets-dir))

(when doom-debug-mode
  (add-hook 'window-setup-hook (lambda () (switch-to-buffer "*Messages*"))))

(when IS-MAC
  (setq default-frame-alist '((ns-transparent-titlebar . t)
                              (ns-appearance . dark)
                              ))
  (setq dired-use-ls-dired nil))

(provide 'config)
;;; config.el ends here
