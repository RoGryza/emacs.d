(provide 'my-editing)

(delete-selection-mode t)

(defun my-proj-relative-buf-name ()
  (ignore-errors
    (rename-buffer
     (file-relative-name buffer-file-name (projectile-project-root)))))

(add-hook 'find-file-hook #'my-proj-relative-buf-name)

(use-package move-text
  :ensure t
  :config
  (move-text-default-bindings))

(use-package paredit
  :ensure t
  :commands enable-paredit-mode
  :hook ((emacs-lisp-mode eval-expression-minibuffer-setup lisp-mode lisp-interaction-mode scheme-mode) . enable-paredit-mode)
  :config
  (bind-keys :map paredit-mode-map
             ("{" . paredit-open-curly)
             ("}" . paredit-close-curly))
  (unless terminal-frame
    (bind-keys :map paredit-mode-map
               ("M-[" . paredit-wrap-square)
               ("M-{" . paredit-wrap-curly)))
  (eval-after-load 'eldoc
    '(eldoc-add-command
      'paredit-backward-delete
      'paredit-close-round)))
