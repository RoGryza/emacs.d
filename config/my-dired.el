(provide 'my-dired)

(require 'dired-x)

(defun my-dired-mode-hook ()
  (dired-hide-details-mode t)
  ;; Don't create a bunch of buffers when navigating in dired
  (define-key dired-mode-map (kbd "^")
    (lambda () (interactive) (find-alternate-file "..")))
  (define-key dired-mode-map [remap dired-find-file] #'dired-find-alternate-file))

(add-hook 'dired-mode-hook #'my-dired-mode-hook)

(setq dired-recursive-copies 'always
      dired-recursive-deletes 'top)
(put 'dired-find-alternate-file 'disabled nil)
