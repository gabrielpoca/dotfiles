(require 'css-mode)
(require 'scss-mode)

(autoload 'scss-mode "scss-mode")
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))

(custom-set-variables '(scss-compile-at-save nil))
(setq css-indent-offset 2)

(provide 'init-css)
