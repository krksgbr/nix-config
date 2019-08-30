;;; g/instant-save/config.el -*- lexical-binding: t; -*-

(defun g/instant-save-buffer(&rest _)
  (if buffer-file-name
      (let ((message-log-max))
        (save-buffer))))

(defun g/enable-instant-save()
  (when (and buffer-file-name (file-writable-p buffer-file-name))
    (unless (member 'instant-save-buffer after-change-functions)
      (message "enabling instant save for %s" buffer-file-name)
       (add-hook 'after-change-functions 'g/instant-save-buffer))))

(add-hook 'find-file-hook 'g/enable-instant-save)
