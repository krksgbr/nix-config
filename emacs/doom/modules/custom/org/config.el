;;; custom/org/config.el -*- lexical-binding: t; -*-

(add-hook! 'org-mode-hook
  #'(doom|disable-line-numbers
     +write-mode
     flyspell-mode-off
     ))

(defun count-words-region (start end)
  (interactive "r")
  (save-excursion
    (let ((n 0))
      (goto-char start)
      (while (< (point) end)
        (if (forward-word 1)
            (setq n (1+ n))))
      (message "Region has %d words" n)
      n)))
