(require 'js2-mode)
(require 'ac-js2)
(require 'json-mode)

(use-package auto-complete
  :ensure t
  :config
  (require 'auto-complete)
  (use-package tern
    :ensure t
    :config
    (require 'tern)
    (add-hook 'js2-mode-hook (lambda () (tern-mode t)))
    (use-package tern-auto-complete
      :ensure t
      :config
      (require 'tern-auto-complete)
      (tern-ac-setup))))

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.es6\\'" . js2-mode))

(setq js2-highlight-level 4)
(setq js-indent-level 2)

(setq-default js2-basic-offset 2
              js2-bounce-indent-p nil)

(setq-default js2-mode-show-parse-errors nil
              js2-mode-show-strict-warnings nil)

(add-hook 'js2-mode-hook (lambda () (setq mode-name "JS2")))
(add-hook 'js2-mode-hook 'js2-imenu-extras-mode)

; RAINBOW
(require 'rainbow-delimiters)
(dolist (hook '(js2-mode-hook js-mode-hook json-mode-hook))
  (add-hook hook 'rainbow-delimiters-mode))

(provide 'init-js)
;;; init-js.el ends here
