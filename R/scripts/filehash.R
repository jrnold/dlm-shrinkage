for (k in dbList(RDATA)) {
  cat(sprintf("%s %s md5\n", k, digest(RDATA[[k]])))
}
