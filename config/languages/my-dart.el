(provide 'my-dart)

(require 'cl)

;; Find correct project root for dart projects
;; Copied from the dart wiki: https://github.com/bradyt/dart-mode/wiki/LSP
(defun project-try-dart (dir)
  (let ((project (or (locate-dominating-file dir "pubspec.yaml")
                     (locate-dominating-file dir "BUILD"))))
    (if project
        (cons 'dart project)
      (cons 'transient dir))))

(add-hook 'project-find-functions #'project-try-dart)
(cl-defmethod project-roots ((project (head dart)))
  (list (cdr project)))

(with-eval-after-load 'projectile
  (defvar projectile-project-root-files-bottom-up)
  (add-to-list 'projectile-project-root-files-bottom-up "pubspec.yaml")
  (add-to-list 'projectile-project-root-files-bottom-up "BUILD"))

(use-package dart-mode
  :ensure t
  :defines dart-format-on-save
  :commands (dart-mode)
  :config
  (setq dart-format-on-save t))

(use-package flutter
  :ensure t
  :after dart-mode
  :functions (flutter--running-p flutter-hot-reload)
  :commands (flutter-run-or-hot-reload)
  :bind (:map dart-mode-map
              ("C-M-x" . #'flutter-run-or-hot-reload))
  :config
  (defun flutter-run-chrome-or-hot-reload ()
    (interactive)
    (if (flutter--running-p)
        (flutter-hot-reload)
      (flutter-run "-d chrome"))))
