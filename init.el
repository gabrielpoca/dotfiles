;; Turn off mouse interface early in startup to avoid momentary display
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

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

(eval-when-compile
  (require 'use-package))
(require 'diminish)
(require 'bind-key)

;; Use different file for custom settings
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(unless (file-exists-p custom-file)
  (write-region "" nil custom-file))

(load custom-file)

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

(add-to-list 'load-path "~/.tern/emacs/")
(autoload 'tern-mode "tern.el" nil t)
(add-hook 'js2-mode-hook (lambda () (tern-mode t)))

(eval-after-load "undo-tree" '(diminish 'undo-tree-mode))


(use-package
  atom-dark-theme
  :ensure t
  :config
  (global-hl-line-mode 0)
  (load-theme 'sanityinc-tomorrow-night t)
  (custom-set-faces '(fringe ((t (:background "#1d1f21")))))
  (custom-set-faces '(linum ((t (:background "#1d1f21")))))
  (fringe-mode '(20 . 0))
  (setq-default line-spacing 2)
  (setq initial-frame-alist '((font . "Inconsolata-dz-15")))
  (setq default-frame-alist '((font . "Inconsolata-dz-15"))))


(use-package
  projectile-rails
  :diminish projectile-rails-mode ""
  :config
  (add-hook 'projectile-mode-hook 'projectile-rails-on))


(use-package
  rainbow-delimiters
  :ensure t
  :diminish rainbow-mode ""
  :config
  (add-hook 'js2-mode-hook #'rainbow-delimiters-mode))


(use-package
  scss-mode
  :ensure t
  :diminish scss-mode ""
  :config
  (setq css-indent-offset 2))


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
  smart-mode-line
  :ensure t
  :config
  (sml/setup)
  (sml/apply-theme 'dark)
  (setq sml/shorten-directory t)
  (setq sml/shorten-modes t))


(use-package
  neotree
  :ensure t
  :ensure evil
  :ensure projectile
  :ensure evil-leader
  :diminish neotree ""
  :config
  (setq projectile-switch-project-action 'neotree-projectile-action)
  (setq neo-hidden-files-regexp "^\\.\\|~$\\|^#.*#$\\|^target$\\|^pom\\.*")
  (setq neo-window-width 32
        neo-window-position 'left
        neo-create-file-auto-open t
        neo-banner-message nil
        neo-mode-line-type 'neotree
        neo-smart-open t
        neo-dont-be-alone t
        neo-persist-show nil
        neo-keymap-style 'concise
        neo-theme 'nerd
        neo-auto-indent-point t)

  (defun neotree-copy-file ()
    "Copy a file."
    (interactive)
    (let* ((current-path (neo-buffer--get-filename-current-line))
           (msg (format "Copy [%s] to: "
                        (neo-path--file-short-name current-path)))
           (to-path (read-file-name msg (file-name-directory current-path))))
      (dired-copy-file current-path to-path t))
    (neo-buffer--refresh t))

  (defun neotree-expand-or-open ()
    "Collapse a neotree node."
    (interactive)
    (let ((node (neo-buffer--get-filename-current-line)))
      (when node
        (if (file-directory-p node)
            (progn
              (neo-buffer--set-expand node t)
              (neo-buffer--refresh t)
              (when neo-auto-indent-point
                (next-line)
                (neo-point-auto-indent)))
          (call-interactively 'neotree-enter)))))

  (defun neotree-collapse ()
    "Collapse a neotree node."
    (interactive)
    (let ((node (neo-buffer--get-filename-current-line)))
      (when node
        (when (file-directory-p node)
          (neo-buffer--set-expand node nil)
          (neo-buffer--refresh t))
        (when neo-auto-indent-point
          (neo-point-auto-indent)))))

  (defun neotree-collapse-or-up ()
    "Collapse an expanded directory node or go to the parent node."
    (interactive)
    (let ((node (neo-buffer--get-filename-current-line)))
      (when node
        (if (file-directory-p node)
            (if (neo-buffer--expanded-node-p node)
                (neotree-collapse)
              (neotree-select-up-node))
          (neotree-select-up-node)))))

  (defun neotree-find-project-root ()
    (interactive)
    (if (neo-global--window-exists-p)
        (neotree-hide)
      (neotree-find (projectile-project-root))))

  (defun neotree-key-bindings ()
    "Set the key bindings for a neotree buffer."
    (define-key evil-normal-state-local-map (kbd "TAB") 'neotree-stretch-toggle)
    (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)
    (define-key evil-normal-state-local-map (kbd "o") 'neotree-enter)
    (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
    (define-key evil-normal-state-local-map (kbd "R") 'neotree-refresh)

    (define-key evil-normal-state-local-map (kbd "gg") 'evil-goto-first-line)
    (define-key evil-normal-state-local-map (kbd "?") 'evil-search-backward)
    (define-key evil-normal-state-local-map (kbd "n") 'evil-search-next)
    (define-key evil-normal-state-local-map (kbd "N") 'evil-search-previous)

    (define-key evil-normal-state-local-map (kbd "ma") 'neotree-create-node)
    (define-key evil-normal-state-local-map (kbd "mc") 'neotree-copy-file)
    (define-key evil-normal-state-local-map (kbd "md") 'neotree-delete-node)
    (define-key evil-normal-state-local-map (kbd "mm") 'neotree-rename-node)

    (define-key evil-normal-state-local-map (kbd "i") 'neotree-enter-horizontal-split)
    (define-key evil-normal-state-local-map (kbd "s") 'neotree-enter-vertical-split)
    (define-key evil-normal-state-local-map (kbd "C-l") 'evil-window-right))

  (evil-leader/set-key "n" 'neotree-find-project-root)
  (evil-leader/set-key "k" 'neotree-show)

  (add-hook 'neotree-mode-hook 'neotree-key-bindings)
  (add-hook 'neotree-mode-hook
            (lambda ()
              (visual-line-mode -1))))


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
  rainbow-mode
  :ensure t)


(use-package
  rainbow-delimiters
  :ensure t
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))


(use-package
  projectile
  :ensure t
  :ensure helm
  :diminish projectile-mode ""
  :config
  (projectile-global-mode)
  (setq projectile-completion-system 'helm)
  (helm-projectile-on))


(use-package
  helm
  :ensure t
  :ensure evil-leader
  :diminish helm ""
  :config
  (evil-leader/set-key
    "b" 'helm-buffers-list)
  (helm-mode 1))


(use-package
  helm-projectile
  :ensure t
  :diminish helm-projectile ""
  :config
  (global-set-key (kbd "M-x") 'helm-M-x)
  (define-key helm-map (kbd "C-j") 'helm-next-line)
  (define-key helm-map (kbd "C-k") 'helm-previous-line)
  (define-key helm-map (kbd "C-<SPC>") 'helm-toggle-visible-mark)
  (define-key helm-map (kbd "C-?") 'helm-help)
  (define-key helm-map (kbd "<escape>") 'keyboard-escape-quit)
  (helm-projectile-on))

(use-package
  evil-rails
  :ensure t
  :ensure evil
  :ensure projectile)

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

  (global-set-key (kbd "C-h") 'windmove-left)
  (global-set-key (kbd "C-l") 'windmove-right)
  (global-set-key (kbd "C-k") 'windmove-up)
  (global-set-key (kbd "C-j") 'windmove-down)
  (define-key evil-insert-state-map (kbd "C-s") 'save-and-normal)
  (define-key evil-normal-state-map (kbd "C-s") 'save-and-normal)
  (define-key evil-normal-state-map (kbd "RET") 'er/expand-region))

(use-package
  evil-jumper
  :ensure t
  :config
  (global-evil-jumper-mode t))

(use-package
  company
  :ensure t
  :diminish company ""
  :config
  (add-hook 'after-init-hook 'global-company-mode))

(use-package
  company-tern
  :ensure t
  :ensure company
  :diminish tern-mode ""
  :config
  (add-to-list 'company-backends 'company-tern))

(use-package
  evil-visualstar
  :ensure t
  :config
  (global-evil-visualstar-mode))

;; use web-mode for .jsx files
(use-package
  web-mode
  :ensure t
  :diminish web-mode ""
  :config
  (add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode)))

(use-package
  magit
  :ensure t
  :ensure evil-leader
  :diminish magit ""
  :config
  (evil-leader/set-key "gs" 'magit-status)
  (evil-leader/set-key "p" 'helm-projectile-find-file)
  (use-package
    evil-magit
    :ensure t))

(use-package
  magit-gh-pulls
  :ensure t
  :ensure magit
  :config
  (add-hook 'magit-mode-hook 'turn-on-magit-gh-pulls))

(use-package
  js2-mode
  :ensure t
  :diminish js2-mode ""
  :config
  (js2-mode-hide-warnings-and-errors)
  (setq js2-basic-offset 2)
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  (add-to-list 'auto-mode-alist '("\\.es6\\'" . js2-mode)))

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

;; http://www.flycheck.org/manual/latest/index.html
(use-package
  flycheck
  :ensure t
  :ensure js2-mode
  :ensure json-mode
  :ensure web-mode
  :ensure exec-path-from-shell
  :diminish flycheck-mode ""
  :config
  ;; turn on flychecking globally
  (add-hook 'after-init-hook #'global-flycheck-mode)
  ;; disable jshint since we prefer eslint checking
  (setq-default flycheck-disabled-checkers
    (append flycheck-disabled-checkers
      '(javascript-jshint html-tidy)))
  ;; use eslint with web-mode for jsx files
  (flycheck-add-mode 'javascript-eslint 'web-mode)
  ;; customize flycheck temp file prefix
  (setq-default flycheck-temp-prefix ".flycheck")
  ;; disable json-jsonlist checking for json files
  (setq-default flycheck-disabled-checkers
    (append flycheck-disabled-checkers
      '(json-jsonlist)))

  ;; https://github.com/purcell/exec-path-from-shell
  ;; only need exec-path-from-shell on OSX
  ;; this hopefully sets up path and other vars better
  (when (memq window-system '(mac ns))
    (exec-path-from-shell-initialize))

  (defadvice web-mode-highlight-part (around tweak-jsx activate)
    (if (equal web-mode-content-type "jsx")
      (let ((web-mode-enable-part-face nil))
        ad-do-it)
      ad-do-it)))
