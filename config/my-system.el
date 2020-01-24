(provide 'my-system)

(use-package system-packages
  :ensure t
  :commands (system-packages-install
             system-packages-ensure
             system-packages-installed-p
             system-packages-search
             system-packages-uninstall
             system-packages-list-dependencis-of
             system-packages-get-info
             system-packages-list-files-provided-by
             system-packages-update
             system-packages-remove-orphaned
             system-packages-list-installed-packages
             system-packages-clean-cache
             system-packages-log
             system-packages-verify-all-packages
             system-packages-verify-all-dependencies)
  :config
  (add-to-list 'system-packages-supported-package-managers
               '(yay .
                     ((default-sudo . nil)
                      (install . "yay -S")
                      (search . "yay -Ss")
                      (uninstall . "yay -Rs")
                      (update . "yay -Syu")
                      (clean-cache . "yay -Sc")
                      (log . "cat /var/log/pacman.log")
                      (get-info . "yay -Qi")
                      (get-info-remote . "yay - Qi")
                      (list-files-provided-by . "yay - Ql")
                      (verify-all-packages . "yay -Qkk")
                      (verify-all-dependencies . "yay -Dk")
                      (remove-orphaned . "yay -Rns $(yay -Qtdq)")
                      (list-installed-packages . "yay -Qe")
                      (list-installed-packages-all . "yay -Q")
                      (list-dependencies-of . "yay -Qi")
                      (noconfirm . "--noconfirm"))))
  (setq system-packages-use-sudo nil
        system-packages-package-manager 'yay))
