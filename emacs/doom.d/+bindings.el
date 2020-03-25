;;; bindings.el --- description -*- lexical-binding: t; -*-

(map!
 "C-\\" #'+treemacs/toggle
 ;; Easier window navigation
 :en "C-h"   #'evil-window-left
 :en "C-j"   #'evil-window-down
 :en "C-k"   #'evil-window-up
 :en "C-l"   #'evil-window-right

 ;; --- <leader> -------------------------------------
 (:leader
   ;; Most commonly used
   :desc "Switch to last buffer"   :n "SPC" #'evil-switch-to-windows-last-buffer ;; this should only switch within a project
   ;; C-u is used by evil

   (:desc "search" :prefix "/"
     :desc "Project Files"         :n  "p" #'counsel-projectile-ag
     :desc "Swiper"                :nv "/" #'swiper)

   (:desc "buffer" :prefix "b"
     :desc "New empty buffer"        :n "n" #'evil-buffer-new
     :desc "Switch workspace buffer" :n "b" #'persp-switch-to-buffer
     :desc "Switch buffer"           :n "B" #'switch-to-buffer
     :desc "Kill buffer"             :n "k" #'kill-this-buffer
     :desc "Remove from perspective" :n "K" #'persp-remove-buffer)

   (:desc "project" :prefix "p"
     :desc "Browse project"          :n  "." #'+default/browse-project
     :desc "Find file in project"    :n  "/" #'projectile-find-file
     :desc "Run cmd in project root" :nv "!" #'projectile-run-shell-command-in-root
     :desc "Switch to Buffer"        :n  "b" #'+ivy/switch-workspace-buffer
     :desc "Compile project"         :n  "c" #'projectile-compile-project
     :desc "Find File"               :n  "f" #'counsel-projectile-find-file
     :desc "Kill"                    :n  "k" #'persp-kill
     :desc "Find other file"         :n  "o" #'projectile-find-other-file
     :desc "Switch to open project"  :n  "p" #'g/projectile-switch-open-project
     :desc "Switch to project"       :n  "P" #'projectile-switch-project
     :desc "Recent project files"    :n  "r" #'projectile-recentf
     :desc "List project tasks"      :n  "t" #'+ivy/tasks
     :desc "Invalidate cache"        :n  "x" #'projectile-invalidate-cache)

   (:desc "toggle" :prefix "t"
     :desc "Toggle Theme"           :n "t" #'g/toggle-theme)
   ))

;;; bindings.el ends here
