(provide 'my-jsonnet)

(defun my-jsonnet-jump-to-definition-at-point ()
  (interactive)
  (jsonnet-jump-to-definition (symbol-name (symbol-at-point))))

(defun my-jsonnet-hook ()
  (setq indent-tabs-mode nil
        tab-width 2)
  (add-hook 'before-save-hook #'jsonnet-reformat-buffer nil t))

(use-package jsonnet-mode
  :ensure t
  :mode ("\\.jsonnet\\'" "\\.libsonnet\\'")
  :hook (jsonnet-mode . my-jsonnet-hook))
