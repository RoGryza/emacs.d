(provide 'my-buffers)

;; Source: https://emacsredux.com/blog/2013/04/28/switch-to-previous-buffer/
(defun my-switch-to-last-buffer ()
  "Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

(with-eval-after-load 'general
  (defvar my-leader)
  (declare-function projectile-next-project-buffer "projectile")
  (declare-function projectile-previous-project-buffer "projectile")

  (general-define-key
    :prefix my-leader
    :keymaps 'normal

    "B" '(my-switch-to-last-buffer :which-key "last-buffer"))

  (general-define-key
    :prefix (concat my-leader "b")
    :keymaps 'normal

    "" '(nil :which-key "buffers")

    "b" '(counsel-switch-buffer :which-key "switch-buffer")
    "w" '(counsel-switch-buffer-other-windiw :which-key "switch-buffer-other-window")
    "d" #'kill-current-buffer
    "n" #'projectile-next-project-buffer
    "p" #'projectile-previous-project-buffer))
