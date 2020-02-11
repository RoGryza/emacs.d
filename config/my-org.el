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

(defun my-org-capture ()
  (interactive)
  (if (fboundp 'counsel-org-capture)
      (counsel-org-capture)
    (org-capture)))

(defun my-org-find-file ()
  (interactive)
  (counsel-find-file my-org-dir))

(my-major-mode-def org-mode-map
 "" '(nil :which-key "org-mode")

 "<" #'org-promote-subtree
 ">" #'org-demote-subtree
 "c" '(org-ctrl-c-ctrl-c :which-key "C-c")
 "t" #'org-todo
 "w" #'org-refile
 "a" #'org-archive-subtree
 "p" #'org-set-property
 "P" #'org-set-property-and-value)

(general-define-key
 :prefix (concat my-leader "o")
 :keymaps 'normal

 "" '(nil :which-key "org")

 "a" #'org-agenda
 "c" '(my-org-capture :which-key "org-capture")
 "p" #'my-org-find-file
 "s" #'org-save-all-org-buffers)

(general-define-key
 :prefix (concat my-leader "ol")
 :keymaps 'normal

 "" '(nil :which-key "link")

 "y" #'org-store-link
 "p" #'org-insert-last-stored-link)

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
