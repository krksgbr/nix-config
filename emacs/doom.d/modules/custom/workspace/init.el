;;; custom/workspace/init.el -*- lexical-binding: t; -*-

(def-package-hook! persp-mode
  ;; stay in same perspective when creating new frame
  :post-config
  (setq persp-interactive-init-frame-behaviour-override nil
        persp-emacsclient-init-frame-behaviour-override nil))

;; seems like cannot use post-init hook because it's part of the core?
(after! projectile
  (setq projectile-require-project-root t))

;; projectile hacks
(defun g/projectile-open-projects ()
  "Modified version of the original `projectile-open-projects' Return a list of all open projects except current one.
An open project is a project with any open buffers that are backed by a file. (Added file-backed buffer constraint)"
  (interactive)
  (projectile--remove-current-project
   (delete-dups
    (delq nil
          (mapcar (lambda (buffer)
                    (with-current-buffer buffer
                      (when (and (projectile-project-p) buffer-file-name)
                        (abbreviate-file-name (projectile-project-root)))))
                  (buffer-list))))))

(defun g/projectile-switch-open-project (&optional arg)
  "Modified version of the original `projectile-switch-open-project', that uses `g/projectile-open-projects' to list projects. Switch to a project we have currently opened.
Invokes the command referenced by `projectile-switch-project-action' on switch.
With a prefix ARG invokes `projectile-commander' instead of
`projectile-switch-project-action.'"
  (interactive)
  (let ((projects (g/projectile-open-projects)))
    (if projects
        (projectile-switch-project-by-name
         (projectile-completing-read "Switch to open project: " projects)
         arg)
      (user-error "There are no open projects"))))
