(provide 'my-go)

(defun my-go-hook ()
  (setq indent-tabs-mode nil
        tab-width 2)
  (add-hook 'before-save-hook #'gofmt-before-save))

(use-package go-mode
  :ensure t
  :commands go-mode
  :mode "\\.go\\'"
  :hook (go-mode . my-go-hook))
