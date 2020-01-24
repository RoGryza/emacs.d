(provide 'my-files)

(with-eval-after-load 'general
  (defvar my-leader)

  (general-define-key
   :prefix (concat my-leader "f")
   :keymaps 'normal

   "" '(nil :which-key "files")

   "f" '(counsel-find-file :which-key "find-file")))
