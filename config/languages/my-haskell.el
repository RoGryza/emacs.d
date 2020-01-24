(provide 'my-haskell)

(use-package haskell-mode
  :ensure t
  :defines (haskell-mode-stylish-haskell-path haskell-hoogle-url)
  :commands haskell-mode
  :mode ("\\.hs\\'" "\\.lhs\\'")
  :init
  (defun my-haskell-hook ()
    (setq indent-tabs-mode nil
          tab-width 2
          haskell-mode-stylish-haskell-path "brittany"
          haskell-hoogle-url "https://www.stackage.org/lts/hoogle?q=%s")
    (haskell-decl-scan-mode)
    (add-hook 'before-save-hook #'haskell-mode-stylish-buffer nil t))
  :bind (:map haskell-mode-map
              ("C-c h" . hoogle)
              ("C-c i" . ghcid))
  :hook (haskell-mode . my-haskell-hook))

(with-eval-after-load 'haskell-mode
 (require 'ghcid))

(use-package lsp-haskell
  :ensure t
  :after (haskell-mode)
  :hook (haskell-mode . lsp)
  :init
  (setq lsp-haskell-process-path-hie "ghcide"
        lsp-haskell-process-args-hie nil)
  :config
  (require 'lsp))
