(provide 'my-org)

(require 'cl)
(require 'f)

(require 'org)
(defvar my-org-dir (expand-file-name "~/Dropbox/notes")
  "Personal org files path")
(defun my-org-file (name)
  "Get path to a file inside my-org-dir"
  (f-join my-org-dir name))

(defun my-org-revert-persistent-buffers ()
  (interactive)
  (cl-loop for buf in (buffer-list)
           when (and (buffer-file-name buf)
                     (f-ancestor-of-p my-org-dir (buffer-file-name buf))
                     (file-exists-p (buffer-file-name buf)))
           do (with-current-buffer buf
                (revert-buffer t t t))))

;; (defmacro my-def-org-files (&rest names) TODO why won't this work?
;;   "Macro to define my-*-file vars referencing my default org file paths"
;;   (cons 'progn
;;         (cl-loop for name in (mapcar #'symbol-name names)
;;                  collect `(defvar ,(make-symbol (concat "my-" name "-file"))
;;                             (my-org-file ,(concat name ".org"))
;;                             ,(format "Path to my %s file" name)))))
;; (my-def-org-files inbox gtd tickler someday readlater)
(progn
  (defvar my-inbox-file
    (my-org-file "inbox.org")
    "Path to my inbox file")
  (defvar my-gtd-file
    (my-org-file "gtd.org")
    "Path to my gtd file")
  (defvar my-tickler-file
    (my-org-file "tickler.org")
    "Path to my tickler file")
  (defvar my-someday-file
    (my-org-file "someday.org")
    "Path to my someday file")
  (defvar my-bookmarks-file
    (my-org-file "bookmarks.org")
    "Path to my bookmarks file")
  (defvar my-lists-file
    (my-org-file "lists.org")))
(setq org-agenda-files (list my-inbox-file
                             my-gtd-file
                             my-tickler-file))
(setq org-archive-location "%s_archive::datetree/")
(setq org-default-notes-file my-inbox-file
      org-refile-targets `((my-gtd-file :maxlevel . 3)
                           (my-tickler-file :maxlevel . 3)
                           (my-someday-file :maxlevel . 3)
                           (my-bookmarks-file :maxlevel . 3)))
(setq org-log-reschedule 'time
      org-log-done 'time)

(defvar org-capture-templates)
(setq org-capture-templates
      '(("i" "Generic Inbox Task" entry
         (file+headline my-inbox-file "Tasks")
         "* TODO %?\n  :PROPERTIES:\n  :CREATED: %U\n  :END:")

        ("m" "E-Mail Inbox Task" entry
         (file+headline my-inbox-file "Tasks")
         "* TODO %a %?"
         :immediate-finish t)

        ("r" "Read Later" entry
         (file+headline my-gtd-file "Read Later")
         "* TODO %?\n  :PROPERTIES:\n  :CREATED: %U\n  :END:")

        ("T" "Tickler" entry
         (file+headline my-tickler-file "Tickler")
         "* TODO %?\n  :PROPERTIES:\n  :CREATED: %U\n  :END:\n  SCHEDULED: %^T")

        ("b" "Bookmark" entry
         (file+headline my-bookmarks-file "Bookmarks")
         "* %?\n  :PROPERTIES:\n  :CREATED: %U\n  :END:")))

(use-package org-projectile
  :ensure t
  :bind (("C-c n p" . org-projectile-project-todo-completing-read)
         ("C-c c" . org-capture))
  :config
  (org-projectile-per-project)
  (setq org-projectile-projects-directory (my-org-file "projects"))
  (setq org-projectile-per-project-filepath "TODO.org")
  (add-to-list 'org-agenda-files org-projectile-projects-directory t))

(use-package evil-org
  :ensure t
  :after (evil org)
  :functions (evil-org-set-key-theme evil-org-agenda-set-keys)
  :config
  (add-hook 'org-mode-hook #'evil-org-mode)
  (add-hook 'evil-org-mode-hook (lambda ()
                                  (evil-org-set-key-theme)))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))
