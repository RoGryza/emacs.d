(provide 'my-term)

(defvar my-leader)
(defvar my-vterm-map (make-sparse-keymap))
(defvar multi-libvterm-dedicated-buffer)

(defun my-vterm-hook ()
  (setq-local display-line-numbers nil))

(defvar multi-libvterm-dedicated-buffer)

(defun my-multi-libvterm-toggle ()
  (interactive)
  (if (and (multi-libvterm-dedicated-exist-p)
           (not (equal (current-buffer) multi-libvterm-dedicated-buffer)))
      (multi-libvterm-dedicated-select)
    (multi-libvterm-dedicated-toggle)))

(defun my-vterm-exit-hook (buf event)
  (ignore event)
  (when buf
    (kill-buffer buf)))

(use-package vterm
  :ensure t
  :commands (vterm vterm-other-window)
  :functions (vterm-send-key multi-libvterm-projectile)
  :general
  (:prefix (concat my-leader "t")
           :keymaps 'normal

           "" '(nil :which-key "vterm")

           "t" #'vterm
           "w" #'vterm-other-window
           "'" '(my-multi-libvterm-toggle :which-key "multi-libvterm-toggle"))
  :hook (vterm-mode . my-vterm-hook)
  :config
  (add-hook 'vterm-exit-functions #'my-vterm-exit-hook)
  (dolist (fn '(multi-libvterm
                multi-libvterm-dedicated-toggle
                multi-libvterm-projectile
                multi-libvterm-dedicated-exist-p
                multi-libvterm-dedicated-select))
    (autoload fn "multi-libvterm" nil t))

  (require 'evil)
  (require 'projectile)

  (declare-function evil-set-initial-state 'evil)
  (declare-function evil-define-key 'evil)

  (evil-set-initial-state 'vterm-mode 'insert)

  (define-key 'projectile-command-map (kbd "t") #'multi-libvterm-projectile)
  (define-key 'projectile-command-map (kbd "x v") #'multi-libvterm-projectile))
