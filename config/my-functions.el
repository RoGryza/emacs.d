(provide 'my-functions)

(require 'cl-lib)

(defun kill-other-buffers ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer
        (delq (current-buffer) (buffer-list))))

(defun kill-all-buffers ()
  "Kill all buffers."
  (interactive)
  (mapc 'kill-buffer (buffer-list)))

(defun fill-buffer ()
  (interactive)
  (save-excursion
    (save-restriction
      (widen)
      (fill-region (point-min) (point-max)))))

;; From the emacs wiki
;; https://www.emacswiki.org/emacs/SudoSave
(defun my-sudo-save ()
  "Save current file as sudo"
  (interactive)
  (if (not buffer-file-name)
      (write-file (concat "/sudo:root@localhost:" (ido-read-file-name "File:")))
    (write-file (concat "/sudo:root@localhost:" buffer-file-name))))
