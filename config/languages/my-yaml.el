(provide 'my-yaml)

(defun my-yaml-hook ()
  (setq indent-tabs-mode nil
        tab-width 2
        yaml-indent-offset 2))

(use-package yaml-mode
  :ensure yaml-mode
  :commands yaml-mode
  :mode ("\\.yml\\'" "\\.yaml\\'")
  :hook (yaml-mode . my-yaml-hook))
