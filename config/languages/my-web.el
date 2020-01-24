(provide 'my-web)

(defun my-web-mode-hook ()
  (setq indent-tabs-mode nil
        tab-width 2
        web-mode-markup-indent-offset 2
        web-mode-css-indent-offset 2
        web-mode-code-indent-offset 2))

(use-package web-mode
  :ensure t
  :mode ("\\.html?\\'" "\\.css\\'" "\\.j2\\'")
  :init
  (add-hook 'web-mode-hook #'my-web-mode-hook))
