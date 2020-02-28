(provide 'my-feeds)

(defvar my-leader)

(use-package elfeed
  :ensure t
  :commands elfeed
  :general
  (:keymaps '(elfeed-show-mode-map elfeed-search-mode-map)
            :states '(normal visual)
            "U" #'elfeed-update)
  :init
  (setq elfeed-db-directory (expand-file-name "~/Dropbox/.elfeed")))

(use-package elfeed-org
  :ensure t
  :defines (rmh-elfeed-org-files)
  :config
  (elfeed-org)
  (setq rmh-elfeed-org-files '("~/Dropbox/elfeed.org")))
