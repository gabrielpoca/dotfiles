;; Turn off mouse interface early in startup to avoid momentary display
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

;; Disable line wrap
(setq-default truncate-lines 0)

;; Hide splash screen
(setq inhibit-startup-message t)

(require 'cl)
(require 'package)

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))

(package-initialize)

(defvar prelude-packages
  '(use-package))

(defun prelude-packages-installed-p ()
  (loop for p in prelude-packages
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))

(unless (prelude-packages-installed-p)
  ;; check for new packages (package versions)
  (message "%s" "Emacs Prelude is now refreshing its package database...")
  (package-refresh-contents)
  (message "%s" " done.")
  ;; install the missing packages
  (dolist (p prelude-packages)
    (when (not (package-installed-p p))
      (package-install p))))

(provide 'prelude-packages)

(eval-when-compile (require 'use-package))
(require 'diminish)
(require 'bind-key)

;; Use different file for custom settings
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(unless (file-exists-p custom-file)
  (write-region "" nil custom-file))

(load custom-file)

;; enable gpg
(require 'epa-file)
(add-to-list 'exec-path "/usr/local/bin")
(epa-file-enable)

(setq-default indent-tabs-mode nil)
(setq ring-bell-function 'ignore)
(setq backup-directory-alist `(("." . "~/.emacs.d/.saves")))
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))
(setq require-final-newline t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq scroll-margin 3
      scroll-conservatively 0
      scroll-up-aggressively 0.01
      scroll-down-aggressively 0.01)

(setq-default scroll-up-aggressively 0.01
	      scroll-down-aggressively 0.01)

(eval-after-load "undo-tree" '(diminish 'undo-tree-mode))

(use-package
  color-theme-sanityinc-tomorrow
  :ensure t
  :config
  (global-hl-line-mode 0)
  (load-theme 'sanityinc-tomorrow-night t)
  (custom-set-faces '(fringe ((t (:background "#1d1f21")))))
  (custom-set-faces '(linum ((t (:background "#1d1f21")))))
  (fringe-mode '(20 . 0))
  (setq-default line-spacing 2)
  (set-face-attribute 'default nil :family "Source Code Pro for Powerline")
  (set-face-attribute 'default nil :height 150))

(use-package undo-tree
  :config
  (setq undo-tree-auto-save-history t)
  (setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/.undo/")))
  (global-undo-tree-mode))

(use-package
  paren
  :config
  (setq show-paren-delay 0)
  (add-hook 'prog-mode-hook 'show-paren-mode))

(use-package
  linum-relative
  :ensure linum-relative
  :config
  (add-hook 'jade-mode-hook 'linum-relative-mode)
  (add-hook 'jade-mode-hook 'line-number-mode t)
  (add-hook 'jade-mode-hook 'column-number-mode t)
  (add-hook 'prog-mode-hook 'linum-relative-mode)
  (add-hook 'prog-mode-hook 'line-number-mode t)
  (add-hook 'prog-mode-hook 'column-number-mode t))

(use-package
  langtool
  :ensure t
  :config
  (setq langtool-language-tool-jar "/usr/local/Cellar/languagetool/3.6/libexec/languagetool-commandline.jar"
        langtool-java-bin "/usr/bin/java"
        langtool-mother-tongue "nl"
        langtool-disabled-rules '("WHITESPACE_RULE"
                                  "EN_UNPAIRED_BRACKETS"
                                  "COMMA_PARENTHESIS_WHITESPACE"
                                  "EN_QUOTES")))

(use-package
  spaceline
  :ensure t
  :config
  (require 'spaceline-config)
  (spaceline-toggle-evil-state-on)
  (spaceline-toggle-minor-modes-off)
  (spaceline-spacemacs-theme))

(use-package
  evil-leader
  :ensure t
  :config
  (evil-leader/set-leader "<SPC>")
  (global-evil-leader-mode))

(use-package
  evil-mc
  :ensure t
  :config
  (global-evil-mc-mode  1))

(use-package
  markdown-mode
  :diminish markdown-mode ""
  :ensure t)

(use-package
  ivy
  :ensure t
  :diminish (ivy-mode . "")
  :init (ivy-mode 1)
  :bind (:map ivy-mode-map
              ("C-j" . ivy-next-line)
              ("C-k" . ivy-previous-line)
              ("C-?" . ivy-help)
              ("<escape>" . keyboard-escape-quit))
  :config
  (setq ivy-use-virtual-buffers t)   ; extend searching to bookmarks and …
  (setq ivy-height 20)               ; set height of the ivy window
  (setq ivy-count-format "(%d/%d) ") ; count format, from the ivy help page
  )

(use-package
  counsel
  :ensure t
  :bind*                           ; load counsel when pressed
  (("M-x"     . counsel-M-x)       ; M-x use counsel
   ("C-x C-f" . counsel-find-file) ; C-x C-f use counsel-find-file
   ("C-x C-r" . counsel-recentf)   ; search recently edited files
   ("C-c f"   . counsel-git)       ; search for files in git repo
   ("C-c s"   . counsel-git-grep)  ; search for regexp in git repo
   ("C-c /"   . counsel-ag)        ; search for regexp in git repo using ag
   ("C-c l"   . counsel-locate))   ; search for files or else using locate
  )

(use-package
  projectile
  :ensure t
  :diminish projectile-mode ""
  :config
  (projectile-global-mode))

(use-package
  counsel-projectile
  :ensure t
  :ensure counsel
  :ensure projectile
  :config
  (counsel-projectile-on))

(use-package
  evil-escape
  :ensure evil
  :ensure t
  :config
  (evil-escape-mode)
  (global-set-key (kbd "C-c C-g") 'evil-escape)
  (setq-default evil-escape-key-sequence "jk"))

(use-package
  evil
  :ensure t
  :ensure expand-region
  :diminish evil ""
  :config
  (evil-mode 1)

  (defun save-and-normal ()
    "Save buffer and go to normal mode"
    (interactive)
    (save-buffer)
    (evil-normal-state))

  (define-key evil-normal-state-map (kbd "C-h") 'windmove-left)
  (define-key evil-normal-state-map (kbd "C-l") 'windmove-right)
  (define-key evil-normal-state-map (kbd "C-k") 'windmove-up)
  (define-key evil-normal-state-map (kbd "C-j") 'windmove-down)
  (define-key evil-insert-state-map (kbd "C-s") 'save-and-normal)
  (define-key evil-normal-state-map (kbd "C-s") 'save-and-normal)
  (define-key evil-normal-state-map (kbd "RET") 'er/expand-region))

(use-package
  company
  :ensure t
  :diminish company ""
  :config
  (add-hook 'after-init-hook 'global-company-mode))

(use-package
  evil-visualstar
  :ensure t
  :config
  (global-evil-visualstar-mode))

(use-package
  magit
  :ensure t
  :ensure evil-leader
  :diminish magit ""
  :config
  (evil-leader/set-key "gs" 'magit-status)
  (use-package
    evil-magit
    :ensure t))

(use-package
  evil-nerd-commenter
  :ensure t
  :ensure evil-leader
  :config
  (evil-leader/set-key
    "cc" 'evilnc-comment-or-uncomment-lines
    "cl" 'evilnc-quick-comment-or-uncomment-to-the-line
    "ll" 'evilnc-quick-comment-or-uncomment-to-the-line
    "cc" 'evilnc-copy-and-comment-lines
    "cp" 'evilnc-comment-or-uncomment-paragraphs
    "cr" 'comment-or-uncomment-region
    "cv" 'evilnc-toggle-invert-comment-line-by-line
    "\\" 'evilnc-comment-operator))

(use-package
  evil-matchit
  :ensure t
  :config
  (global-evil-matchit-mode 1))
