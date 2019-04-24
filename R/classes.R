.baseURL="http://bigrna.cancerdatasci.org/"

#' @importFrom rappdirs user_cache_dir
#' @importFrom BiocFileCache BiocFileCache
.get_cache <- function()
  {
    cache <- rappdirs::user_cache_dir(appname="BigRNA")
    x = BiocFileCache::BiocFileCache(cache)
    x
  }


#' A connection to BigRNA
#'
#' @slot url url bigRNA
#' @slot bfc The BiocFileCache
#'
#' @exportClass BigRNAConnection
setClass("BigRNAConnection",
         representation(url = "character",
                        bfc = "BiocFileCache"),
         prototype(url = .baseURL,
                   bfc = .get_cache() ))

#' @export
setGeneric("datafile", function(object, path) {
  standardGeneric("datafile")
})


#' @importFrom dplyr filter
#' @importFrom magrittr %>%
#' @export
setMethod('datafile',
          c('BigRNAConnection', 'character'),
          function(object, path) {
            urlbaseHere = 'http://graphql-omicidx.cancerdatasci.org/'
            #url = paste0(object@url,'data/', path)
            url = paste0(urlbaseHere,'data/', path)
            res = bfcinfo(object@bfc) %>% dplyr::filter(fpath==url)
            if(nrow(res)==1)
              return(res$rpath[1])
            #bfcrpath(object@bfc,paste0(object@url,'data/', path))
            bfcrpath(object@bfc,paste0(urlbaseHere,'data/', path))
          }
)

#' @export
setGeneric('getCache', function(object){
  standardGeneric("getCache")
})

#' @export
setMethod('getCache', "BigRNAConnection", function(object){
  object@bfc
})


#' @importFrom httr POST modify_url
.query = function(query, variables = NULL, handler = dataframe_handler, url=.baseURL) {
  res = httr::content(
    httr::POST(
      paste0(url, 'graphql'),
      body=list(query=query, variables = variables),
      encode = 'json'),
    as='text'
  )
  return(handler(res))
}

#' @export
setGeneric('gqlQuery', function(object, query, ...) {
  standardGeneric("gqlQuery")
})

#' @export
setMethod('gqlQuery', c('BigRNAConnection', 'character'), function(object, query, ...) {
  .query(query, ..., url=object@url)
})

