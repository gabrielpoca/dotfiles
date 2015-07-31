(use-package smart-mode-line
  :ensure t
  :config
  (require 'smart-mode-line)
  (add-to-list 'sml/replacer-regexp-list '("^~/groupbuddies/" ":GB:") t)
  (add-to-list 'sml/replacer-regexp-list '("^~/projects/" ":PRJ:") t)
  (setq sml/no-confirm-load-theme t)
  (setq sml/extra-filler -10)
  (setq sml/name-width 40)
  (setq sml/mode-width 'full)
  (setq sml/shorten-directory t)
  (setq sml/shorten-modes t)
  (setq sml/show-frame-identification nil)
  (setq sml/show-client nil)
  (setq sml/mule-info nil)
  (sml/apply-theme 'dark)
  (sml/setup))

;; (use-package powerline
;;   :config
;;   (powerline-default-theme)
;;   (setq powerline-default-separator 'slant))

(set-face-attribute 'default nil :font "Inconsolata-dz-14")
(setq-default frame-title-format '("%b - %F"))
(global-visual-line-mode 1)
(setq require-final-newline t)
(load-theme 'base16-default-dark t)

;; node scrollbar, toolbar, menu
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; signal whitespace
(use-package whitespace
  :ensure t
  :config
  (require 'whitespace)
  (setq whitespace-style '(face empty tabs lines-tail trailing))
  (global-whitespace-mode t))

;; show relative numbers in prog-mode
(use-package linum-relative
  :ensure t
  :config
  (require 'linum-relative)
  (add-hook 'prog-mode-hook 'linum-mode)
  (linum-mode 1)
  (setq linum-relative-format "%3s "))

;; set the fringe to whatever the background color is
(defun my-tone-down-fringes ()
  (set-face-attribute 'fringe nil
                      :foreground (face-foreground 'default)
                      :background (face-background 'default)))
(my-tone-down-fringes)

(use-package evil
  :ensure t
  :config
  (require 'evil)
  (setq evil-emacs-state-cursor '("red" box))
  (setq evil-visual-state-cursor '("orange" box))
  (setq evil-normal-state-cursor '("white" box))
  (setq evil-insert-state-cursor '("red" bar))
  (setq evil-replace-state-cursor '("red" bar))
  (setq evil-operator-state-cursor '("red" hollow)))

(provide  'init-theme)
