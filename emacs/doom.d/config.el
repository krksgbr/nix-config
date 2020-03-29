;;; config.el --- description -*- lexical-binding: t; -*-

(tool-bar-mode -1)

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

(setq evil-want-Y-yank-to-eol nil)
(setq doom-themes-neotree-enable-variable-pitch nil)

(set-formatter! 'ormolu "ormolu" :modes '(haskell-mode))
(set-formatter! 'nixpkgs-fmt "nixpkgs-fmt" :modes '(nix-mode))

(provide 'config)
;;; config.el ends here
