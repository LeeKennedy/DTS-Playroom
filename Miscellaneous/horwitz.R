horwitz <- function(x, ppm){
  if(ppm == TRUE)
  y <- x/1000000 else
    y <- x/100
  MU <- 2*x*2^(1-0.5*log10(y))/100
  return(MU)
}

# If result is in mg/kg, set ppm = TRUE; if %, set ppm = FALSE
# Returns the MU
horwitz(0.0237, ppm=TRUE)
