(provide 'my-org)

(defvar my-leader)
(declare my-major-mode-def)

(require 'cl)
(require 'f)

(require 'org)
(defvar my-org-dir (expand-file-name "~/Dropbox/notes")
  "Personal org files path")
(with-eval-after-load 'projectile
  (projectile-add-known-project my-org-dir))
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

(defmacro my-def-org-files (&rest names)
          "Macro to define my-*-file vars referencing my default org file paths"
          (cons 'progn
                (cl-loop for name in (mapcar #'symbol-name names)
                         collect `(defvar ,(intern (concat "my-" name "-file"))
                                    (my-org-file ,(concat name ".org"))
                                    ,(format "Path to my %s file" name)))))
(my-def-org-files inbox bookmarks gtd tickler someday readlater lists)

(setq org-agenda-files (list my-inbox-file
                             my-gtd-file
                             my-tickler-file))
(setq org-archive-location "%s_archive::datetree/")
(setq org-default-notes-file my-inbox-file
      org-refile-use-outline-path t
      org-refile-allow-creating-parent-nodes 'confirm
      org-outline-path-complete-in-steps nil
      org-refile-targets `((my-gtd-file :level . 1)
                           (my-tickler-file :level . 1)
                           (my-someday-file :level . 1)
                           (my-bookmarks-file :level . 1)))
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

(defun my-org-find-file ()
  "Find a file under `my-org-dir'."
  (interactive)
  (counsel-find-file my-org-dir))

(defun my-org-insert-todo-at-point ()
  "Insert todo with \"i\" template at the end of current subtree."
  (interactive)
  (when (org-get-todo-state)
    (org-up-element))
  (org-back-to-heading)
  (org-capture 0 "i")
  (org-move-subtree-down)
  (org-demote-subtree)
  (evil-insert-state nil))

(defun my-org-set-created ()
  "Set created property to current time."
  (interactive)
  (org-set-property "CREATED" (format-time-string (org-time-stamp-format nil t))))

(defhydra my-hydra-org (:columns 3)
  "Org"
  ("c" org-ctrl-c-ctrl-c "C-c")
  ("t" org-todo "TODO")
  ("w" org-refile "Refile")
  ("a" org-archive-subtree "Archive Subtree")
  ("p" org-set-property "Set Property")
  ("P" org-set-property-and-value "Set Property and Value")
  ("s" org-schedule "Schedule")
  ("i" my-org-insert-todo-at-point "Insert TODO" :exit t)

  ("h" org-metaleft "Promote Subtree/Move Column Left")
  ("l" org-metaright "Demote Subtree/Move Column Right")
  ("j" org-metadown "Move Down")
  ("k" org-metaup "Move Up"))

(my-major-mode-def org-mode-map
 "" '(my-hydra-org/body :which-key "org-mode"))

(general-define-key
 :prefix (concat my-leader "o")
 :keymaps 'normal

 "" '(nil :which-key "org")

 "a" #'org-agenda
 "c" #'org-capture
 "p" #'my-org-find-file
 "s" #'org-save-all-org-buffers)

(general-define-key
 :prefix (concat my-leader "ol")
 :keymaps 'normal

 "" '(nil :which-key "link")

 "y" #'org-store-link
 "p" #'org-insert-last-stored-link)

(defun my-org-hook ()
  (interactive)
  (add-hook 'before-save-hook #'org-align-all-tags nil t))

(add-hook 'org-mode-hook #'my-org-hook)

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
