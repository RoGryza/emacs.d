;; Fix bug with elpa returning bad request
(defvar gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

(add-to-list 'load-path (concat user-emacs-directory "vendor"))
(add-to-list 'load-path (concat user-emacs-directory "config"))
(add-to-list 'load-path (concat user-emacs-directory "config/languages"))

(savehist-mode 1)

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(setq make-backup-files nil)

(setq inhibit-splash-screen t
      initial-scratch-message nil)

(setq backup-directory-alist `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

(defvar-local my-tab-width 2)

(defun my-indent-setup ()
  (interactive)
  (setq indent-tabs-mode nil
        tab-width my-tab-width))

(add-hook 'prog-mode-hook #'my-indent-setup)

(require 'package)
(add-to-list 'package-archives
             '("gnu" . "https://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(dolist (pkg '(use-package s f cl-lib))
  (if (not (package-installed-p pkg))
      (package-install pkg)))

(setenv "PATH"
        (concat (expand-file-name "~/bin") ":"
                (expand-file-name "~/.local/bin") ":"
                (getenv "PATH")))
(add-to-list 'exec-path (expand-file-name "~/bin"))
(add-to-list 'exec-path (expand-file-name "~/.local/bin"))
(add-to-list 'exec-path (expand-file-name "~/google-cloud-sdk/bin"))

(use-package tree-mode
  :ensure t)
(require 'glade-mode)
;; (require 'enaml-mode)

(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode)
  (setq undo-tree-auto-save-history t)
  (setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo"))))

(use-package rg
  :ensure t
  :commands rg-map)

(require 'my-functions)
(require 'my-evil)
(require 'my-keybindings)
(require 'my-buffers)
(require 'my-files)
(require 'my-dired)
(require 'my-editing)
(require 'my-autocomplete)
(require 'my-ddg)
(require 'my-flycheck)
(require 'my-ivy)
(require 'my-movement)
(require 'my-kubernetes)
(require 'my-lsp)
(require 'my-modeline)
(require 'my-email)
(require 'my-feeds)
(require 'my-system)
(require 'my-systemd)
(require 'my-term)
(require 'my-git)
(require 'my-org)
(require 'my-projectile)
(require 'my-snippets)

(require 'my-c)
(require 'my-clisp)
(require 'my-dart)
(require 'my-groovy)
(require 'my-el)
(require 'my-javascript)
(require 'my-json)
(require 'my-jsonnet)
(require 'my-pkgbuild)
(require 'my-go)
(require 'my-haskell)
(require 'my-markdown)
(require 'my-python)
(require 'my-racket)
(require 'my-rust)
(require 'my-sh)
(require 'my-terraform)
(require 'my-typescript)
(require 'my-tex)
(require 'my-toml)
(require 'my-yaml)
(require 'my-web)

(require 'my-visuals)
(require 'my-diminish)
