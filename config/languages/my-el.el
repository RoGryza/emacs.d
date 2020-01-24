(provide 'my-el)

(defun describe-symbol-at-point ()
  "Describe the symbol under the cursor"
  (interactive)
  (describe-symbol (or (symbol-at-point) (error "No symbol-at-point"))))

(defun my-el-hook ()
  (setq indent-tabs-mode nil
        tab-width 2))

(add-hook 'emacs-lisp-mode-hook #'my-el-hook)
