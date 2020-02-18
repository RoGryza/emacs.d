(provide 'my-nix)

(defun my-nix-mode-hook ()
  (interactive)
  (add-hook 'before-save-hook #'nix-format-buffer nil t))

(use-package nix-mode
  :ensure t
  :functions nix-format-buffer
  :mode "\\.nix\\'"
  :commands nix-mode)
