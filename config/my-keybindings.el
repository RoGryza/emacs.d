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

(general-create-definer my-major-mode-def
  :states '(normal insert)
  :prefix (concat my-leader "m")
  :non-normal-prefix "M-m")
