(provide 'my-python)

(defun my-python-hooks ()
  (interactive)
  (setq indent-tabs-mode nil
        tab-width 4
        python-shell-interpreter "ipython"
        python-shell-interpreter-args "-i --simple-prompt"))

;; Run flycheck inside a virtualenv
(defun flycheck-virtualenv-executable-find (executable)
  "Find an EXECUTABLE in the current virtualenv, if any."
  (if (bound-and-true-p python-shell-virtualenv-root)
      (let ((exec-path (python-shell-calculate-exec-path)))
        (executable-find executable))
    (executable-find executable)))

(defun flycheck-virtualenv-setup ()
  "Setup Flycheck for the current virtualenv."
  (setq-local flycheck-executable-find #'flycheck-virtualenv-executable-find))

(use-package elpy
  :ensure elpy
  :defer t
  :init
  (advice-add 'python-mode :before 'elpy-enable)
  :config
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode)
  (add-hook 'elpy-mode-hook 'my-python-hooks)
  (add-hook 'python-mode #'flycheck-virtualenv-setup))

(use-package poetry
  :ensure t
  :commands poetry)

(use-package py-isort
  :ensure t
  :after elpy
  :config
  (add-hook 'before-save-hook 'py-isort-before-save)
  (setq py-isort-options '("--lines=88" "--multi-line=3" "--trailing-comma")))

(use-package pip-requirements
  :ensure t)

(use-package pyenv-mode-auto
  :ensure t)

(use-package blacken
  :ensure t
  :after elpy
  :config
  (add-hook 'elpy-mode-hook 'blacken-mode))

(use-package auto-virtualenv
  :ensure t
  :after (elpy projectile)
  :config
  (add-hook 'python-mode-hook 'auto-virtualenv-set-virtualenv)
  (add-hook 'projectile-after-switch-project-hook 'auto-virtualenv-set-virtualenv))
