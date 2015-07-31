(defun init-neotree ()
  "Neotree setup function with dependencies"
  (add-to-list 'evil-motion-state-modes 'neotree-mode)

  (setq neo-hidden-files-regexp "^\\.\\|~$\\|^#.*#$\\|^target$\\|^pom\\.*")
  (setq neo-window-width 32
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
    (define-key evil-motion-state-local-map (kbd "TAB") 'neotree-stretch-toggle)
    (define-key evil-motion-state-local-map (kbd "RET") 'neotree-enter)
    (define-key evil-motion-state-local-map (kbd "o") 'neotree-enter)
    (define-key evil-motion-state-local-map (kbd "q") 'neotree-hide)
    (define-key evil-motion-state-local-map (kbd "R") 'neotree-refresh)

    (define-key evil-motion-state-local-map (kbd "gg") 'evil-goto-first-line)
    (define-key evil-motion-state-local-map (kbd "?") 'evil-search-backward)
    (define-key evil-motion-state-local-map (kbd "n") 'evil-search-next)
    (define-key evil-motion-state-local-map (kbd "N") 'evil-search-previous)

    (define-key evil-motion-state-local-map (kbd "ma") 'neotree-create-node)
    (define-key evil-motion-state-local-map (kbd "mc") 'neotree-copy-file)
    (define-key evil-motion-state-local-map (kbd "md") 'neotree-delete-node)
    (define-key evil-motion-state-local-map (kbd "mm") 'neotree-rename-node)

    (define-key evil-motion-state-local-map (kbd "i") 'neotree-enter-horizontal-split)
    (define-key evil-motion-state-local-map (kbd "s") 'neotree-enter-vertical-split)
    (define-key evil-motion-state-local-map (kbd "C-l") 'evil-window-right))

  (evil-leader/set-key "n" 'neotree-find-project-root)
  (evil-leader/set-key "k" 'neotree-show)

  (add-hook 'neotree-mode-hook 'neotree-key-bindings)
  (add-hook 'neotree-mode-hook
            (lambda ()
              (visual-line-mode -1)))
  )

(use-package neotree
  :ensure t
  :config
  (use-package evil
    :ensure t
    :config
    (use-package evil-leader
      :ensure t
      :config
      (init-neotree))))

(provide 'init-neotree)
