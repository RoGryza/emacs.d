(provide 'my-lsp)

(use-package lsp-mode
  :ensure t
  :commands lsp
  :init
  (setq lsp-prefer-flymake nil)
  :config
  (require 'lsp-clients))

(use-package lsp-ui
  :ensure t
  :after lsp-mode
  :commands lsp-ui-mode)

(use-package company-lsp
  :ensure t
  :after lsp-mode)
