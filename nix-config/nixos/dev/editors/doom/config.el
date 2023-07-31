;;; config.el --- description -*- lexical-binding: t; -*-

(tool-bar-mode -1)

;; hooks

(add-hook 'prog-mode-hook #'rainbow-mode)

(load! "+bindings")
(setq +write-mode-hook
      #'(visual-fill-column-mode
         visual-line-mode
         +write|init-org-mode))

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

;; THEME
(custom-theme-set-faces! 'doom-solarized-dark
  '(lsp-face-highlight-textual :background "#00212B" :foreground nil)
  '(highlight :background "#b58900" :foreground "#00212B")
  '(region :background "#b58900" :foreground "#00212B"))

(custom-set-faces!
  '(cursor :background "#00FF00" :foreground "#00FF00" ))


(let ((default-font "Iosevka")
      (default-font-size 34))

  (setq doom-font (font-spec :family default-font :size default-font-size :weight 'semibold)
        doom-variable-pitch-font (font-spec :family default-font :size default-font-size)
        doom-unicode-font (font-spec :family default-font :size default-font-size)
        doom-big-font (font-spec :family default-font :size default-font-size)
        doom-line-numbers-style 'relative
        doom-themes-enable-bold nil
        org-ellipsis " ▾ "
        org-bullets-bullet-list '(">"))
  )

(setq doom-theme 'doom-solarized-dark)


;; ivy-posframe
;;

(after! ivy-posframe
  (defun get-posframe-size ()
    (list
     :height ivy-posframe-height
     :width (round (* (frame-width) 0.9))
     :min-height (or ivy-posframe-min-height
                     (let ((height (+ ivy-height 1)))
                       (min height (or ivy-posframe-height height))))
     :min-width (or ivy-posframe-min-width
                    (let ((width (round (* (frame-width) 0.62))))
                      (min width (or ivy-posframe-width width))))))
  (setq ivy-posframe-size-function #'get-posframe-size)
  (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-center)))
  (setq ivy-posframe-border-width 2)
  (setq ivy-posframe-parameters
        '((left-fringe . 16)
          (right-fringe . 16)
          (top-fringe . 16)))
  (custom-set-faces! '(ivy-posframe-border :background "#268bd2")))


;; org

(setq org-roam-directory "~/org-roam")

(provide 'config)
;;; config.el ends here
