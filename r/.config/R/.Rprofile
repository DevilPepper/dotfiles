.First <- function() {
  options(prompt="\001\033[34m\002\001\033[0m\002 ", continue="├   ")
  cat(sprintf('%s -- "%s"\n', R.version[['version.string']], R.version[['nickname']]))
}

.Last <- function() {
  if(interactive()) try(savehistory("~/.local/state/history.r"))
}
