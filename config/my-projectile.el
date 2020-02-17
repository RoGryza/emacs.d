(provide 'my-projectile)

(defvar my-leader)
(defvar my-projectile-project-manager-fn nil)

(use-package projectile
  :ensure projectile
  :general
  ("C-c p" #'projectile-command-map)
  (:keymaps 'normal
            (concat my-leader "p") '(:keymap projectile-command-map :which-key "projectile"))
  :config
  (add-to-list 'projectile-globally-ignored-directories "elpa")
  (add-to-list 'projectile-globally-ignored-directories ".cache")
  (add-to-list 'projectile-globally-ignored-directories "node_modules")

  (def-projectile-commander-method ?x
    "Open eshell in project root."
    (projectile-run-eshell))

  (projectile-mode)
  (setq projectile-switch-project-action 'projectile-commander))

(use-package counsel-projectile
  :ensure t
  :after projectile
  :config
  (counsel-projectile-mode))

(use-package perspective
  :ensure t)

;; (use-package persp-projectile
;;   :ensure t
;;   :after (perspective )
;;   :config
;;   (persp-mode)
;;   (define-key projectile-command-map (kbd "p") #'projectile-persp-switch-project))
