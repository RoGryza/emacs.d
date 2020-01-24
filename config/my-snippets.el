(provide 'my-snippets)

(use-package yasnippet
  :ensure t
  :diminish (yas-mode yas-global-mode)
  :config
  (yas-global-mode t))

(use-package yasnippet-snippets
  :ensure t
  :after yasnippet)
