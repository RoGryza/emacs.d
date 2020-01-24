(provide 'my-visuals)

;; Vim-like smooth scrolling
(setq scroll-conservatively 10000)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(setq-default cursor-type 'bar)
(blink-cursor-mode)

(use-package dracula-theme
  :ensure t
  :config
  (load-theme 'dracula t))

(add-to-list 'default-frame-alist
             '(font . "DejaVu Sans Mono-13"))

(use-package rainbow-delimiters
  :ensure rainbow-delimiters
  :init
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package dimmer
  :ensure t
  :config
  (dimmer-mode))

(require 'whitespace)
(setq whitespace-style '(face tabs tab-mark)
      whitespace-display-mappings '((tab-mark 9 [9655 9] [92 9])))
(global-whitespace-mode)
