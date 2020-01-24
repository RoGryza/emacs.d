(provide 'my-rust)

(defun my-rust-hook ()
  (setq indent-tabs-mode nil
        tab-width 2
        rust-format-on-save t)
  (lsp))

(use-package rust-mode
  :ensure t
  :mode "\\.rs\\'"
  :hook (rust-mode . my-rust-hook))

(use-package cargo
  :ensure t
  :diminish cargo-minor-mode
  :hook (rust-mode . cargo-minor-mode))

(use-package flycheck-rust
  :ensure t
  :hook (flycheck-mode . flycheck-rust-setup))
