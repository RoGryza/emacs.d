(provide 'my-json)

(defun my-json-hook ()
  (setq indent-tabs-mode nil
        tab-width 2
        js-indent-level 2
        json-reformat:indent-width 2))

(use-package json-mode
  :ensure t
  :mode ("\\.json\\'" ".eslintrc")
  :config
  (add-hook 'json-mode-hook #'my-json-hook))
