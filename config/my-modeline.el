(provide 'my-modeline)

(use-package all-the-icons
  :ensure t)

(use-package doom-modeline
  :after all-the-icons
  :ensure  t
  :hook (after-init . doom-modeline-mode)
  :config
  (setq doom-modeline-minor-modes nil
        doom-modeline-buffer-encoding nil
        doom-modeline-env-version nil
        doom-modeline-buffer-file-name-style 'relative-to-project))
