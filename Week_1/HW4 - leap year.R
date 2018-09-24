readinteger <- function()
{ 
  n <- readline(prompt="Enter an integer: ")
  return(as.integer(n))
}

print(readinteger())

if (readinteger() %% 100 != 0 && readinteger() %% 4 == 0 || readinteger() %% 400 == 0){
  cat('??????')
}
else{
  cat('?????????')
}
