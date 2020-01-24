(provide 'my-systemd)

(defun my-systemd-hook ()
  (setq indent-tabs-mode nil
        tab-width 2))

(use-package systemd
  :ensure t
  :commands systemd-mode
  :mode ("\\.service\\'" "\\.socket\\'")
  :hook (systemd-mode . my-systemd-hook))
