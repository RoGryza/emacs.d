(provide 'my-typescript)

(defun my-tide-mode-setup ()
  (tide-setup)
  (eldoc-mode)
  (tide-hl-identifier-mode)
  (setq indent-tabs-mode nil
        tab-width 2))

(use-package typescript-mode
  :ensure t
  :commands typescript-mode
  :mode ("\\.ts\\'" "\\.tsx\\'")
  :hook (typescript-mode . my-ts-mode-hook))

(use-package tide
  :ensure t
  :commands tide-setup
  :diminish (tide-hl-identifier-mode)
  :hook (typescript-mode . my-tide-mode-setup))
