(provide 'my-c)

(defun my-c-hook ()
  (setq indent-tabs-mode nil
        tab-width 2
        c-basic-offset 2)
  (rtags-start-process-unless-running)
  (flycheck-select-checker 'rtags)
  (flycheck-irony-setup)
  (setq-local flycheck-highlighting-mode nil)
  (add-hook 'before-save-hook #'clang-format-buffer nil t))

(add-hook 'c-mode-hook #'my-c-hook)
(add-hook 'c++-mode-hook #'my-c-hook)

(setq rtags-completion-enabled t)
(use-package rtags
  :ensure t)
(use-package flycheck-rtags
  :ensure t
  :after (flycheck rtags))
(use-package company-rtags
  :ensure t
  :after (company rtags)
  :config
  (push 'company-rtags company-backends))

(use-package irony
  :ensure t)
  ;; :commands irony-mode
  ;; :diminish irony-mode
  ;; :hook ((c-mode . #'irony-mode)
  ;;        (c++-mode . #'irony-mode)
  ;;        (irony-mode . #'irony-cdb-autosetup-compile-options)))

(use-package irony-eldoc
  :ensure t
  :after irony
  :commands irony-eldoc
  :diminish t
  :hook (irony-mode . #'irony-eldoc))

(use-package flycheck-irony
  :ensure t)

(use-package company-irony
  :ensure t
  :after irony
  :config
  (add-to-list 'company-backends 'company-irony))

(use-package company-irony-c-headers
  :ensure t
  :after company-irony
  :config
  (add-to-list 'company-backends 'company-irony-c-headers))

(use-package clang-format
  :ensure t
  :init
  (setq clang-format-style-option "llvm"))

(use-package cmake-ide
  :ensure t
  :init
  (setq cmake-ide-flags-c '("/usr/lib/gcc/x86_64-pc-linux-gnu/9.1.0/include"
                            "/usr/local/include"
                            "/usr/lib/gcc/x86_64-pc-linux-gnu/9.1.0/include-fixed"
                            "/usr/include"))
  (setq cmake-ide-flags-c++ (concatenate 'list
                                         '("/usr/lib/gcc/x86_64-pc-linux-gnu/9.1.0/../../../../include/c++/9.1.0"
                                           "/usr/lib/gcc/x86_64-pc-linux-gnu/9.1.0/../../../../include/c++/9.1.0/x86_64-pc-linux-gnu"
                                           "/usr/lib/gcc/x86_64-pc-linux-gnu/9.1.0/../../../../include/c++/9.1.0/backward")
                                         cmake-ide-flags-c))
  :config
  (cmake-ide-setup))
