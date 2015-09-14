#' Approval Ratings for President George W. Bush
#'
#' Approval ratings for George W. Bush.
#'
#' @format A \code{data.frame} object with \Sexpr{ncol(bsdlm::BushApproval)} variables and \Sexpr{nrow(bsdlm::BushApproval)}  observations.
#' \itemize{
#' \item start_date. Start date of the survey.
#' \item end_date. End date of the survey.
#' \item approve. Percent which approve of the president.
#' \item disapprove. Percent which disapprove of the president.
#' \item undecided. Percent undecided about the president.
#' }
"BushApproval"

#' CP6 Data
#'
#' Monthly total sales, in monetary terms, of tobacco and related products marketed by a U.K. company from January 1955 to December 1959.
#'
#' @references West, Mike and Harrison, Jeff. (1997) \emph{Bayesian Forecasting and Dynamic Models, 2nd ed.}. p. 369-370.
#' @format A \code{data.frame} with \Sexpr[stage=build]{ncol(bsdlm::CP6)} variables, and \Sexpr[stage=build]{nrow(bsdlm::CP6)} observations.
"CP6"

#' Exchange rate data for\Sexpr{ncol(bsdlm::divisas)} currencies
#'
#' Daily observations of exchage rates against the U.S. dollar (USD) for the period January 4, 1988 to August 15, 1997.
#'
#' @references Tusell, Fernando. (2011) Kalman Filtering in R. \emph{Journal of Statistical Software} \strong{39.2}. \url{http://www.jstatsoft.org/v39/i02}
#' @source \url{http://www.jstatsoft.org/v39/i02/supp/2}
#' @format A \code{\link[zoo]{zoo}} object with \Sexpr{ncol(bsdlm::divisas)} variables and \Sexpr{nrow(bsdlm::divisas)}  observations.
"divisas"

