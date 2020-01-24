(provide 'my-diminish)

(use-package diminish
  :ensure t
  :config
  (dolist (mode '(abbrev-mode
                  company-mode
                  eldoc-mode
                  helm-mode
                  projectile-mode
                  git-gutter-mode
                  (flycheck-mode "c")
                  undo-tree-mode
                  which-key-mode
                  yas-mode
                  yas-minor-mode
                  yas-global-mode
                  ;; language-specific
                  blacken-mode))
    (if (atom mode)
        (diminish mode)
      (apply 'diminish mode))))
