function gb() {
 git checkout "$(git branch --all | fzf| tr -d '[:space:]')"
}
