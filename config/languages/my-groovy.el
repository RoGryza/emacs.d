(provide 'my-groovy)

(defun my-groovy-hook ()
  (setq indent-tabs-mode nil
        tab-width 2))

(use-package groovy-mode
  :ensure t
  :mode ("\\.groovy\\'" "Jenkinsfile")
  :config
  (add-hook 'groovy-mode-hook #'my-groovy-hook)
  (setq groovy-indent-offset 2))
