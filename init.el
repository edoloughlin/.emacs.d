(setq inhibit-startup-message t)

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/"))
(package-initialize)
(package-refresh-contents)

;; bootstrap use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package try
  :ensure t)

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(use-package flx
  :ensure t)

(use-package ivy
 :ensure t
 :after flx
 :init
 (setq ivy-re-builders-alist '((t . ivy--regex-fuzzy))))

(use-package counsel
 :ensure t
 :after flx
 :config
 (ivy-mode 1)
 :bind
 ("M-x" . counsel-M-x))

(use-package autopair
  :ensure t)

(use-package counsel-projectile
  :ensure t
  :init
  (counsel-projectile-mode)
  :bind
  ("C-c p" . projectile-command-map))

(use-package howdoi
  :ensure t)

(use-package avy
  :ensure t
  :bind ("M-s" . avy-goto-char-2))

(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

;; using company-mode-instead
;; (use-package auto-complete
;;   :ensure t
;;   :init
;;   (progn
;;     (ac-config-default)
;;     (global-auto-complete-mode t)
;;     (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
;;     (ac-config-default)))

(use-package whitespace
  :ensure t
  :config
  (setq show-trailing-whitespace t)
  (setq whitespace-style (quote (trailing tab-mark lines))))

(use-package rainbow-delimiters
  :ensure t
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

;; (use-package org-journal
;;   :ensure t
;;   :config
;;   (setq org-journal-dir "~/org"))

(use-package org-roam
      :hook
      (after-init . org-roam-mode)
      :custom
      (org-roam-directory "/home/ed/Documents/org")
      :bind (:map org-roam-mode-map
              (("C-c n l" . org-roam)
               ("C-c n f" . org-roam-find-file)
               ("C-c n g" . org-roam-show-graph))
              :map org-mode-map
              (("C-c n i" . org-roam-insert))))

(use-package smart-mode-line
  :ensure t
  :config
  (setq smt/theme 'light-powerline)
  (sml/setup)
  ;; add projects here
  ;; (add-to-list 'sml/replacer-regexp-list '("something" "replacement") t)
  )

(use-package ace-window
  :ensure t
  :config
  (global-set-key (kbd "M-p") 'ace-window))

(use-package git-gutter
  :ensure t
  :config
  (global-git-gutter-mode +1))

(use-package feature-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\.feature$" . feature-mode)))

(use-package yasnippet
  :ensure t
  :config
  (setq yas-snippet-dirs
	'("~/.emacs.d/snippets"))
  (yas-global-mode 1))

(use-package yasnippet-snippets
  :after yasnippet
  :ensure t)

(use-package projectile
  :ensure t
  :config
  (projectile-global-mode)
  (setq projectile-enable-caching t))

(use-package adaptive-wrap
  :ensure t
  :config
  ;; stackoverflow.com/questions/13559061#13561223
  (when (fboundp 'adaptive-wrap-prefix-mode)
    (defun my-activate-adptive-wrap-prefix-mode ()
      "Toggle visual-line-mode and adaptive-wrp-mode sumiltaneously"
      (adaptive-wrap-prefix-mode (if visual-line-mode 1 -1)))
    (add-hook 'visual-line-mode-hook 'my-activate-adptive-wrap-prefix-mode))
  ;; proper work wrapping
  (global-visual-line-mode t))

;; (use-package multiple-cursors
;;   :ensure t
;;   :bind
;;   ("C-S-c C-S-c" . mc/edit-lines)
;;   ("C->" . mc/mark-next-like-this)
;;   ("C-<" . mc/mark-previous-like-this)
;;   ("C-c <" . mc/mark-all-like-this))

(use-package company               
  :ensure t
  :defer t
  :init (global-company-mode)
  :config
  (progn
    ;; Use Company for completion
    (bind-key [remap completion-at-point] #'company-complete company-mode-map)

    (setq company-tooltip-align-annotations t
          ;; Easy navigation to candidates with M-<n>
          company-show-numbers t)
    (setq company-dabbrev-downcase nil))
  :diminish company-mode)

(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

(use-package expand-region
  :ensure t
  :bind
  ("C-\\" . er/expand-region)
  ("M-\\" . er/contract-region))

(use-package rjsx-mode
  :ensure t)

(use-package flycheck
  :ensure t)

(use-package dumb-jump
  :ensure t)

(use-package paredit :ensure t)

(use-package clojure-mode :ensure t)

(use-package clojure-mode-extra-font-locking :ensure t)

(use-package cider :ensure t)

(use-package button-lock
  :ensure t)

(use-package wdired
  :ensure t)

;(use-package fixmee
;  :ensure t
;  :requires button-lock
;  :config
;  (global-fixmee-mode 1))

;; (use-package lsp-mode
;;  :ensure t
;;  :mode (\\.js$ . lsp))

; (use-package tide
;  :ensure t)

(global-set-key (kbd "C-<left>")  'windmove-left)
(global-set-key (kbd "C-<right>") 'windmove-right)
(global-set-key (kbd "C-<up>")    'windmove-up)
(global-set-key (kbd "C-<down>")  'windmove-down)

(menu-bar-mode 1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(show-paren-mode 1)

;; Backups
;; from https://stackoverflow.com/questions/151945/how-do-i-control-how-emacs-makes-backup-files
(setq version-control t     ;; Use version numbers for backups.
      kept-new-versions 10  ;; Number of newest versions to keep.
      kept-old-versions 0   ;; Number of oldest versions to keep.
      delete-old-versions t ;; Don't ask to delete excess backup versions.
      backup-by-copying t)  ;; Copy all files, don't rename them.
(setq vc-make-backup-files t)
;; Default and per-save backups go here:
(setq backup-directory-alist '(("" . "~/.emacs.d/backup/per-save")))

(defun force-backup-of-buffer ()
  ;; Make a special "per session" backup at the first save of each
  ;; emacs session.
  (when (not buffer-backed-up)
    ;; Override the default parameters for per-session backups.
    (let ((backup-directory-alist '(("" . "~/.emacs.d/backup/per-session")))
          (kept-new-versions 3))
      (backup-buffer)))
  ;; Make a "per save" backup on each save.  The first save results in
  ;; both a per-session and a per-save backup, to keep the numbering
  ;; of per-save backups consistent.
  (let ((buffer-backed-up nil))
    (backup-buffer)))

(add-hook 'before-save-hook  'force-backup-of-buffer)

(setq custom-file "~/.emacs.d/emacs-custom.el")
(load custom-file)

(load "~/.emacs.d/my-functions.el")
(global-set-key (kbd "M-<down>") 'copy-char-down-if-space)
