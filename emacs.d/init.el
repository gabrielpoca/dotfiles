(require 'package)
(add-to-list 'load-path "~/.emacs.d/evil-tmux-navigator")
(add-to-list 'load-path "~/.emacs.d/evil-matchit")
(add-to-list 'load-path "~/.emacs.d/rvm.el")
(add-to-list 'load-path "~/.emacs.d/lisp/")
(add-to-list 'load-path "~/.emacs.d/evil-plugins")
(add-to-list 'load-path "~/.emacs.d/powerline")

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))

(package-initialize)

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

; https://github.com/jfroffice/emacs.d/blob/master/init.el
(defun load-conf (filename)
  "load the file in ~/.emacs.d/ unless it has already been loaded"
  (defvar *my-loaded-files* '())
  (if (not (memq filename *my-loaded-files*))
      (progn
        (load-file (expand-file-name (concat "~/.emacs.d/" filename ".el")))
        (add-to-list '*my-loaded-files* filename))))

(require 'use-package)
(require 'diminish)

(setq resize-mini-windows nil)
(setq-default indent-tabs-mode nil)
(setq tab-width 2)
(setq standard-indent 2)
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)

;; sounds
(setq visual-bell nil)
(setq ring-bell-function '(lambda () nil))

;; dired
(setq dired-recursive-copies 'always)
(setq dired-recursive-deletes 'always)

;; increase text size
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

(global-set-key (kbd "C-7") "[")
(global-set-key (kbd "C-8") "{")
(global-set-key (kbd "C-9") "}")
(global-set-key (kbd "C-0") "]")

;; scroll
(setq redisplay-dont-pause t
      scroll-margin 4
      scroll-step 1
      scroll-conservatively 10000
      scroll-preserve-screen-position 1)

(setq inhibit-startup-message t)
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(setq mac-option-modifier nil
      mac-command-modifier 'meta
      x-select-enable-clipboard t)

(use-package rainbow-delimiters
  :ensure t
  :config
  (require 'rainbow-delimiters)
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

(use-package flycheck
  :ensure t
  :config
  (require 'flycheck)
  (diminish 'flycheck-mode)

  (setq-default flycheck-disabled-checkers
                '(javascript-jshint emacs-lisp json-jsonlist html-tidy slim scss-lint scss_lint scss))

  ;; turn on flychecking globally
  (add-hook 'after-init-hook 'global-flycheck-mode)

  ;; use eslint with web-mode for jsx files
  (flycheck-add-mode 'javascript-eslint 'web-mode))

(require 'navigate)

(use-package projectile
  :ensure t
  :diminish projectile-mode
  :config
  (require 'projectile)
  (setq projectile-completion-system 'helm)
  (projectile-global-mode 1))

(use-package helm
  :ensure t
  :diminish helm-mode
  :config
  (require 'helm-config)
  (helm-mode 1)
  (helm-autoresize-mode 1)
  (helm-projectile-on)
  (use-package helm-ag
    :ensure t))

(use-package writeroom-mode
  :ensure t
  :config
  (require 'writeroom-mode))

(use-package auto-complete
  :ensure t
  :config
  (require 'auto-complete)
  (ac-config-default)
  (setq ac-auto-start 0)
  (setq ac-delay 0.2)
  (setq ac-quick-help-delay 1.)
  (setq ac-use-fuzzy t)
  (setq ac-fuzzy-enable t)
  (setq ac-dwim t))

(use-package org
  :ensure t
  :config
  (require 'org)
  (setq org-default-notes-file "~/Google Drive/org/notes.org")
  (global-set-key (kbd "C-c c") 'org-capture)
  (global-set-key (kbd "C-c o")
                  (lambda () (interactive) (find-file "~/Google Drive/org/notes.org"))))

(use-package smartparens
  :ensure t
  :config
  (require 'smartparens-config))

(use-package sr-speedbar
  :ensure t
  :config
  (require 'sr-speedbar))

(require 'init-neotree)
(require 'init-js)
(require 'init-ruby)
(require 'init-theme)
(require 'init-css)
(require 'init-html)
(require 'init-evil)

(require 'navigate)
(require 'rvm)
(rvm-use-default)

(color-theme-approximate-on)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("7356632cebc6a11a87bc5fcffaa49bae528026a78637acd03cae57c091afd9b9" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "9f3a4edb56d094366afed2a9ba3311bbced0f32ca44a47a765d8ef4ce5b8e4ea" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" default)))
 '(evil-shift-width 2)
 '(scss-compile-at-save nil)
 '(slim-backspace-backdents-nesting nil)
 '(tab-width 2))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
