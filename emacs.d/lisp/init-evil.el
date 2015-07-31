(require 'evil-leader)
(require 'expand-region)
(require 'evil-matchit)
(require 'evil)

(global-evil-matchit-mode 1)

(global-evil-leader-mode 1)

(defun normal-and-save ()
  (interactive)
  (evil-normal-state)
  (save-buffer))

(evil-leader/set-leader "<SPC>")
(evil-leader/set-key "e" 'find-file)
(evil-leader/set-key "p" 'helm-projectile-find-file)
(evil-leader/set-key "s" 'save-buffer)
(evil-leader/set-key "m" 'evilmi-jump-items)
(evil-leader/set-key "g" 'magit-status)

(require 'org)
(evil-leader/set-key "i" 'org-capture)
(evil-leader/set-key "o"
              (lambda () (interactive) (find-file "~/Google Drive/org/notes.org")))

(define-key evil-normal-state-map (kbd "RET") 'er/expand-region)
(define-key evil-normal-state-map (kbd ",f") 'helm-projectile-find-file)
(define-key evil-normal-state-map (kbd ",,") 'evil-buffer)
(define-key evil-normal-state-map (kbd "q") nil)
(define-key evil-normal-state-map (kbd "Q") 'helm-projectile-ag)
(define-key evil-normal-state-map (kbd "C-s") 'save-buffer)

(define-key evil-visual-state-map (kbd "C-c") 'evil-normal-state)

(define-key evil-insert-state-map (kbd "C-d") nil)
(define-key evil-insert-state-map (kbd "C-k") nil)
(define-key evil-insert-state-map (kbd "C-c") 'evil-normal-state)
(define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
(define-key evil-insert-state-map (kbd "C-s") 'normal-and-save)

(require 'evil-nerd-commenter)
(evil-leader/set-key
  "ci" 'evilnc-comment-or-uncomment-lines
  "cl" 'evilnc-quick-comment-or-uncomment-to-the-line
  "ll" 'evilnc-quick-comment-or-uncomment-to-the-line
  "cc" 'evilnc-copy-and-comment-lines
  "cp" 'evilnc-comment-or-uncomment-paragraphs
  "cr" 'comment-or-uncomment-region
  "cv" 'evilnc-toggle-invert-comment-line-by-line
  "\\" 'evilnc-comment-operator ; if you prefer backslash key
)

(require 'magit)
(setq magit-last-seen-setup-instructions "1.4.0")
(evil-set-initial-state 'magit-mode 'normal)
(evil-set-initial-state 'magit-status-mode 'normal)
(evil-set-initial-state 'magit-diff-mode 'normal)
(evil-set-initial-state 'magit-log-mode 'normal)
(evil-define-key 'normal magit-mode-map
                 "j" 'magit-goto-next-section
                 "k" 'magit-goto-previous-section)
(evil-define-key 'normal magit-log-mode-map
                 "j" 'magit-goto-next-section
                 "k" 'magit-goto-previous-section)
(evil-define-key 'normal magit-diff-mode-map
                 "j" 'magit-goto-next-section
                 "k" 'magit-goto-previous-section)

(require 'evil-easymotion)
(evilem-default-keybindings "SPC")

(require 'evil-jumper)
(global-evil-jumper-mode 1)

(require 'evil)
(require 'dired)

(evil-mode 1)

(custom-set-variables
 '(evil-shift-width 2)
 '(tab-width 2)
 )
(provide 'init-evil)
