(provide 'my-markdown)

(defun my-markdown-hook ()
  (setq indent-tabs-mode nil
        tab-width 2
        fill-column 100))

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :hook (markdown-mode . my-markdown-hook)
  :init (setq markdown-command "multimarkdown"
              markdown-asymmetric-header t
              markdown-list-indent-width 2))

;; (use-package markdown-preview-mode
;;   :ensure t
;;   :after markdown-mode
;;   :diminish markdown-preview-mode
;;   :hook (markdown-mode . markdown-preview-mode)
;;   :config
;;   (setq browse-url-browser-function 'browse-url-generic
;; 	browse-url-generic-program "firefox"
;; 	markdown-preview-auto-open nil
;; 	markdown-preview-stylesheets nil))
