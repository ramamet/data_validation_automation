now_asia <- function() {
   now <- Sys.time()
   attr(now, "tzone") <- "Asia/Calcutta"
   now
}