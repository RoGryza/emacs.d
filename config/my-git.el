(provide 'my-git)

(defvar my-leader)

(use-package git-gutter
  :ensure t
  :config
  (global-git-gutter-mode +1))

(use-package magit
  :ensure t
  :commands (magit-status)
  :general
  ("C-c g" #'magit-status)
  (:keymaps 'normal
            :prefix my-leader
            "g" #'magit-status))

(use-package forge
  :ensure t
  :after magit)

(use-package evil-magit
  :ensure t
  :after (evil magit))
