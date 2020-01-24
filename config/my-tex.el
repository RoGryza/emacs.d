(provide 'my-tex)

(defun my-latex-hook ()
  (setq indent-tabs-mode nil
        tab-width 2))

(use-package auctex
  :defer t
  :ensure t
  :init
  (setq TeX-auto-save t
        TeX-parse-self t
        TeX-PDF-mode t)
  (setq-default TeX-master nil)
  :config
  (add-hook 'LaTeX-mode-hook #'LaTeX-math-mode)
  (add-hook 'LaTeX-mode-hook #'my-latex-hook))

(use-package company-auctex
  :ensure t
  :after auctex
  :config
  (company-auctex-init))
