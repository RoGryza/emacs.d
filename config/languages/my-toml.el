(provide 'my-toml)

(defun my-toml-hook ()
  (setq indent-tabs-mode nil
        tab-width 2))

(use-package toml-mode
  :ensure t
  :commands toml-mode
  :mode "\\.toml\\'"
  :hook (toml-mode . my-toml-hook))
