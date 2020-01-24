(provide 'my-email)

(use-package org-mime
  :ensure t)

(defun my-mu4e-hook ()
  (interactive)
  (local-set-key (kbd "<RET>") #'mu4e~view-browse-url-from-binding))

(defvar mu4e-maildir (expand-file-name "~/.mail"))
(defvar mu4e-get-mail-command "mbsync -c ~/.emacs.d/mu4e/.mbsyncrc -a")
(defvar mu4e-view-prefer-html t)
(defvar mu4e-confirm-quit nil)
(defvar mu4e-view-actions)
(defvar mu4e-view-show-images t)
(defvar mu4e-sent-messages-behavior 'delete)
(defvar mu4e-context-policy 'pick-first)
; http://pragmaticemacs.com/emacs/fixing-duplicate-uid-errors-when-using-mbsync-and-mu4e/
(defvar mu4e-change-filenames-when-moving t)
(defvar mu4e-contexts)

(add-to-list 'load-path "/usr/share/emacs/site-lisp/mu4e/")
(autoload 'mu4e "mu4e" nil t)
(autoload 'mu4e-update-index "mu4e" nil t)
(autoload 'mu4e-update-mail-and-index "mu4e" nil t)
(with-eval-after-load 'mu4e
  (add-hook 'mu4e-view-mode-hook #'my-mu4e-hook)
  (add-to-list 'mu4e-view-actions
               '("ViewInBrowser" . mu4e-action-view-in-browser) t)
  (when (fboundp 'imagemagick-register-types)
    (imagemagick-register-types))

  (setq mu4e-contexts
    (list
     (make-mu4e-context
      :name "personal"
      :match-func (lambda (msg)
                    (when msg
                      (mu4e-message-contact-field-matches
                       msg '(:from :to :cc :bcc) "rogryza@gmail.com")))
      :vars '((user-mail-address . "rogryza@gmail.com")
              (mu4e-sent-folder . "/personal-gmail[personal].Sent Mail")
              (mu4e-drafts-folder . "/personal-gmail[personal].drafts")
              (mu4e-trash-folder . "/personal-gmail[personal].Trash")
              (mu4e-maildir-shortcuts . (("/personal-gmail/INBOX" . ?i)))))))

  (require 'org-mu4e)
  (defvar mu4e-headers-mode-map)
  (defvar mu4e-view-mode-map)
  (define-key mu4e-headers-mode-map (kbd "C-c c") 'org-mu4e-store-and-capture)
  (define-key mu4e-view-mode-map (kbd "C-c c") 'org-mu4e-store-and-capture))
