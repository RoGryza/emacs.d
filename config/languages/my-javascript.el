(provide 'my-javascript)

(defun my-flycheck-npx-wrapper (command)
  (cons "npx" command))

(defun my-js-mode-hook ()
  (setq indent-tabs-mode nil
        tab-width 2
        js-indent-level 2
        js2-mode-show-parse-errors nil
        js2-mode-show-strict-warnings nil)
  (setq-local flycheck-command-wrapper-function #'my-flycheck-npx-wrapper)
  (flycheck-select-checker 'javascript-eslint)
  (when (bound-and-true-p projectile-project-root)
    (setq-local flycheck-eslint-args
                (list "-c"
                      (concat (projectile-project-root "..eslintrc.js"))))))

(defun my-jsx-mode-hook ()
  (my-js-mode-hook))

(use-package js2-mode
  :ensure t
  :commands js2-mode
  :mode "\\.js\\'"
  :hook (js2-mode . my-js-mode-hook))

(use-package xref-js2
  :ensure t
  :after js2-mode)

(use-package rjsx-mode
  :ensure t
  :commands rjsx-mode
  :mode "\\.jsx\\'"
  :hook (rjsx-mode . my-jsx-mode-hook))
