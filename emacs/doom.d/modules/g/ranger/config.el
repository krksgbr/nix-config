;;; g/ranger/config.el -*- lexical-binding: t; -*-
 
(defun g/toggle-ranger()
  (interactive)
  (if (equal major-mode 'ranger-mode)
      (ranger-close)
    (deer)))

(defun g/ranger-close()
  (interactive)
  (ranger-close))

;; (def-package! all-the-icons-dired
;;   :config
;;   (after! ranger
;;     (add-hook 'ranger-mode-hook 'all-the-icons-dired-mode)))

(def-package! ranger
  :config

;; (defun g/set-evil-normal-state()
;;     (evil-set-initial-state 'ranger-mode 'normal)
;;     (evil-normal-state 1))
  (setq ranger-max-preview-size 10)
  (setq ranger-dont-show-binary t)
  (setq ranger-show-hidden t)
  (ranger-override-dired-mode t)
  ;; (add-hook 'ranger-mode-load-hook #'g/set-evil-normal-state)
  )
