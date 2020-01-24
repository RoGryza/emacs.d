(provide 'my-flycheck)

(use-package flycheck
  :ensure flycheck
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode)
  (setq-default flycheck-check-syntax-automatically '(save model-enabled)
                flycheck-checkers (delq 'emacs-lisp-checkdoc flycheck-checkers)
                flycheck-checkers (delq 'html-tidy flycheck-checkers)
                flycheck-emacs-lisp-load-path 'inherit)
  (add-to-list 'flycheck-disabled-checkers 'python-flake8))

(use-package flycheck-mypy
  :ensure t
  :after flycheck)

(use-package flycheck-pos-tip
  :ensure t
  :after flycheck
  :init
  (add-hook 'flycheck-mode-hook #'flycheck-pos-tip-mode))
