(provide 'my-clisp)

(defun my-lisp-hook ()
  (setq indent-tabs-mode nil
        tab-width 2)
  (slime-mode t))

(use-package lisp-mode
  :mode ("\\.cl\\'" "\\.lisp\\'" "\\.sbclrc\\'" ".stumpwmrc")
  :config
  (add-hook 'lisp-mode-hook #'my-lisp-hook))

(use-package slime-company
  :ensure t
  :commands slime-company)

(use-package slime
  :ensure t
  :commands (slime slime-lisp-mode-hook slime-mode)
  :custom
  (slime-complete-symbol*-fancy t)
  (slime-complete-symbol-function 'slime-fuzzy-complete-symbol)
  (slime-contribs '(slime-fancy))
  :config
  (setq inferior-lisp-program (executable-find "sbcl"))
  (setq slime-contribs
        '(slime-fancy slime-asdf slime-quicklisp slime-cl-indent))
  (slime-setup slime-contribs))
