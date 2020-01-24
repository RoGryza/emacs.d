(provide 'my-evil)

(defvar-local my-tab-width 2)

(use-package evil
  :ensure t
  :defines (evil-tab-width evil-shift-width)
  :init
  (setq evil-want-keybinding nil)
  (setq evil-want-integration t)
  (setq evil-want-C-u-scroll t)
  (setq evil-mode-line-format nil
        evil-insert-state-cursor '(bar "White")
        evil-normal-state-cursor '(box "White")
        evil-visual-state-cursor '(box "#F86155"))
  (setq-default evil-tab-width my-tab-width
                evil-shift-width my-tab-width)
  :config
  (define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
  (add-hook 'prog-mode-hook #'my-evil-indent-setup)
  ;; Make ESC work like C-g
  (dolist (map (list evil-normal-state-map
                     evil-visual-state-map
                     minibuffer-local-map
                     minibuffer-local-ns-map
                     minibuffer-local-completion-map
                     minibuffer-local-must-match-map
                     minibuffer-local-isearch-map))
    (define-key map [escape] #'keyboard-quit))
  
  (evil-mode))

(defun my-evil-indent-setup ()
  (setq evil-tab-width my-tab-width
        evil-shift-width my-tab-width))

(use-package evil-surround
  :ensure t
  :after evil
  :config
  (global-evil-surround-mode t))

(use-package evil-nerd-commenter
  :ensure t
  :after evil
  :config
  (evilnc-default-hotkeys))

(use-package evil-collection
  :ensure t
  :defines evil-collection-init
  :after evil
  :config
  (evil-collection-init))
