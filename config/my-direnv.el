(provide 'my-direnv)

(use-package direnv
  :ensure t
  :commands (direnv-mode)
  :functions (direnv-mode)
  :config
  (direnv-mode))
