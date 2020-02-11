(provide 'my-projectile)

(defvar my-leader)
(defvar my-projectile-project-manager-fn nil)

;; (cl-defun my-projectile-register-project-type
;;     (project-type marker-files
;;                   &key compilation-dir configure compile test run test-suffix test-prefix src-dir test-dir related-files-fn manager-fn)
;;   (projectile-register-project-type project-type marker-files
;;                                     :compilation-dir compilation-dir
;;                                     :configure configure
;;                                     :compile compile
;;                                     :test test
;;                                     :run run
;;                                     :test-suffix test-suffix
;;                                     :test-prefix test-prefix
;;                                     :src-dir src-dir
;;                                     :test-dir test-dir
;;                                     :related-files-fn related-files-fn)
;;   (let ((project-plist (alist-get project-type projectile-project-types)))
;;     (when manager-fn
;;       (plist-put project-plist 'manager-fn manager-fn))
;;     project-plist))

;; (defun my-projectile-manager-fn (project-type)
;;   (or my-projectile-project-manager-fn
;;       (plist-get (alist-get project-type projectile-project-types) 'manager-fn)))

;; (defun my-projectile-manager-project (arg)
;;   (interactive "P")
;;   (funcall (my-projectile-manager-fn (projectile-project-type))))

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
