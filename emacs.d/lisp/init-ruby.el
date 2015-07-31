(dolist (exp '("Rakefile\\'" "\\.rake\\'"))
  (add-to-list 'auto-mode-alist
               (cons exp 'ruby-mode)))

(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))

(provide 'init-ruby)
