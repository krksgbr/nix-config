;;; custom/theme/init.el -*- lexical-binding: t; -*-

(add-to-list 'default-frame-alist
             '(ns-transparent-titlebar . t))

(setq doom-font (font-spec :family "Iosevka" :size 32 :weight 'normal)
      doom-variable-pitch-font (font-spec :family "Iosevka" :size: 32)
      doom-unicode-font (font-spec :family "Iosevka" :size 32)
      doom-big-font (font-spec :family "Iosevka" :size 32)
      doom-line-numbers-style 'relative
      doom-themes-enable-bold nil
      org-ellipsis " ▾ "
      org-bullets-bullet-list '(">")
      )

;;(def-package-hook! solaire-mode :disable)



(add-to-list 'custom-theme-load-path
             (expand-file-name "~/git/emacs-doom-themes/themes"))

(def-package! doom-themes :load-path "~/git/emacs-doom-themes")

(defun g/doom-customize-faces()
  (message "running g/doom-customize-faces")
	 (doom-themes-set-faces
	 	'doom-solarized-dark
	 	(cursor  :background  "#00FF00" :foreground "#00FF00")
	 	(doom-neotree-file-face :foreground base1)))

(setq g/themes-index 0)
(setq g/themes '(doom-solarized-dark doom-solarized-light))


(setq doom-theme (nth g/themes-index g/themes))
;;(setq doom-neotree-file-icons t)


;; (def-package-hook! doom-themes
;;  :pre-config
;;  (message "running doom-themes pre-config")
;;  ;; doesn't work when doom-themes is set to load from custom load-path
;;  ;;(add-hook! 'doom-load-theme-hook 'g/doom-customize-faces)
;; )


(defun g/toggle-theme()
  (interactive)
  (setq g/themes-index (% (+ 1 g/themes-index) (length g/themes)))
  (setq doom-theme (nth g/themes-index g/themes))
  (message (format "setting theme to %s" doom-theme))
  (doom/reload-theme))

(defun g/toggle-solaire-mode()
  (interactive)
  (if solaire-mode
      (turn-off-solaire-mode)
      (turn-on-solaire-mode)))

(load! "+ligatures")
