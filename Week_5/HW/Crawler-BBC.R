library(rvest)

id = c(1, 11, 21)
URL = paste0("https://www.bbc.com/zhongwen/trad/search/?q=Elon+Musk&start=", id)

Titles <- function(URL)
{
  html  = read_html(URL)
  title = html_nodes(html, ".hard-news-unit__headline-link")
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
  write.table(getContent, "Crawler-BBC.txt", append=TRUE)
  #Take a break for 3 to 5 sec to prevent blocking from the target website.
  Sys.sleep(sample(3:5, 1))
}

mapply(Titles, URL = URL)


