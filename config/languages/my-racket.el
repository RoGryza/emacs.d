(provide 'my-racket)

(defun my-racket-hook ()
  (enable-paredit-mode))

(use-package racket-mode
  :ensure t
  :hook (racket-mode . my-racket-hook)
  :commands racket-mode
  :mode "\\.rkt\\'")

(use-package geiser
  :ensure t
  :commands (geiser-mode run-geiser))

(use-package scribble-mode
  :ensure t
  :commands scribble-mode
  :hook (scribble-mode . geiser-mode)
  :mode "\\.scrbl\\'")
