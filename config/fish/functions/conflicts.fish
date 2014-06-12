function conflicts
  vim +/"<<<<<<<" ( git diff --name-only --diff-filter=U | xargs )
end
