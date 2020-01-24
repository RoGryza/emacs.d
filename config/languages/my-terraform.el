(provide 'my-terraform)

(defun my-terraform-hook ()
  (setq indent-tabs-mode nil
        terraform-indent-level 2)
  (terraform-format-on-save-mode))

(use-package terraform-mode
  :ensure t
  :commands terraform-mode
  :mode "\\.tf\\'"
  :hook (terraform-mode . my-terraform-hook))

(use-package company-terraform
  :ensure t
  :after terraform-mode
  :config
  (company-terraform-init))
