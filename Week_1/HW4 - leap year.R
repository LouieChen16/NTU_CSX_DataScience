n <- readline(prompt="Enter an integer: ")
a <- as.integer(n)

if (a %% 100 != 0 && a %% 4 == 0){
  cat('是閏年')
} else if (a %% 3200 != 0 && a %% 400 == 0){
  cat('是閏年')
} else{
  cat('是平年')
}