library(rvest)

id = c(1:2)
URL = paste0("http://www.epochtimes.com/b5/tag/%E9%A6%AC%E6%96%AF%E5%85%8B.", id, ".html")

Titles <- function(URL)
{
  html  = read_html(URL)
  title = html_nodes(html, ".clear .info a")
  href  = html_attr(title, "href")
  #getTitle = html_text(title)
  #data = data.frame(title = getTitle, href = href)  
  #View(data)
  #write.table(getTitle, "techorange.txt", fileEncoding = "UTF-8", append=TRUE)
  
  mapply(Download_every_text, href=href)
}

Download_every_text <- function(href)
{
  link  = read_html(href)
  cont = html_nodes(link, "p")  
  getContent = html_text(cont)
  write.table(getContent, "Crawler-Epochtimes.txt", append=TRUE)
  #Take a break for 3 to 5 sec to prevent blocking from the target website.
  Sys.sleep(sample(3:5, 1))
}

mapply(Titles, URL = URL)


