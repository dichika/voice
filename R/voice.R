getKoebuNum <- function(url=NULL, output=NULL){
  if(is.null(url)){
    stop("url required")
  }
  require(XML)
  require(httr)
  res <- GET(url)
  parsed <- htmlParse(res, encoding="utf-8")
  num <- xpathSApply(parsed, "//dd[@class='postNumber number']",xmlValue)
  now <- Sys.time()
  res <- data.frame(time=now, num=num, url=url)
  if(is.null(output)){
  return(res)
  }else{
    write.table(res, output, append=TRUE, sep=",", 
                row.names=FALSE,
                col.names=FALSE)
  }
}
