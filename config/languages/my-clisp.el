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
  :defer t
  :commands slime-company)

(use-package slime
  :ensure t
  :defer t
  :commands (slime slime-lisp-mode-hook slime-mode)
  :custom
  (inferior-lisp-program (executable-find "sbcl"))
  (slime-complete-symbol*-fancy t)
  (slime-complete-symbol-function 'slime-fuzzy-complete-symbol)
  (slime-contribs '(slime-fancy))
  :config
  (load (expand-file-name "~/quicklisp/slime-helper.el"))
  (setq slime-contibs
        '(slime-fancy slime-asdf slime-quicklisp slime-cl-indent))
  (slime-setup '(slime-fancy slime-asdf slime-quicklisp slime-company slime-cl-indent)))
