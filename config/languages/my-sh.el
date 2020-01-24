(provide 'my-sh)

(setq sh-basic-offset 2
      sh-indentation 2
      smie-indent-basic 2)

(defun my-sh-hook ()
  (setq indent-tabs-mode nil
        tab-width 2))

(add-hook 'shell-mode-hook #'my-sh-hook)
