.First <- function() {
  options(prompt=" ", continue=">   ")
  cat(sprintf('%s -- "%s"\n', R.version[['version.string']], R.version[['nickname']]))
}

.Last <- function() {
  if(interactive()) try(savehistory("~/.local/state/history.r"))
}
