(provide 'my-keybindings)

(defvar my-leader ",")

(use-package which-key
  :ensure t
  :diminish which-key-mode
  :config
  (which-key-mode))

(use-package general
  :ensure t
  :after which-key
  :config
  (general-auto-unbind-keys)
  (general-define-key
    :prefix my-leader
    :keymaps 'normal

    "" '(nil :which-key "<leader>")
    "w" #'save-buffer))
