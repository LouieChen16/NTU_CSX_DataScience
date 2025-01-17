#https://rstudio-pubs-static.s3.amazonaws.com/265713_cbef910aee7642dc8b62996e38d2825d.html

#Solve Chinese problem: https://psmethods.postach.io/post/ru-he-geng-gai-rde-yu-she-yu-xi

#Set Language as traditional Chinese
Sys.setlocale(category = "LC_ALL", locale = "cht")

rm(list=ls(all.names = TRUE))
library(NLP)        # install.packages("NLP")
library(tm)         # install.packages("tm")
library(RColorBrewer)
library(wordcloud)  #install.packages("wordcloud")
library(jiebaRD)    # install.packages("jiebaRD")
library(jiebaR)     # install.packages("jiebaR") 中文文字斷詞

#Read all txt files
'filenames <- list.files(getwd(), pattern="*.txt")
files <- lapply(filenames, readLines)'

file <- readLines("D:/NTU_DataScience (R)/NTU_CSX_DataScience/Week_4/HW/Chinese_downloaded_txt/Chiang's Dairy.txt") 
#file

#Cleanning data, online source: http://www.sthda.com/english/wiki/text-mining-and-word-cloud-fundamentals-in-r-5-simple-steps-you-should-know
docs <- Corpus(VectorSource(file))

toSpace <- content_transformer(function(x, pattern) {
  return (gsub(pattern, " ", x))
}
)
docs <- tm_map(docs, removePunctuation)  #remove space
docs <- tm_map(docs, removeNumbers)
docs <- tm_map(docs, toSpace, "日")
docs <- tm_map(docs, toSpace, "月")
docs <- tm_map(docs, toSpace, "之")
docs <- tm_map(docs, toSpace, "與")
docs <- tm_map(docs, toSpace, "而")
docs <- tm_map(docs, toSpace, "其")
docs <- tm_map(docs, toSpace, "在")
docs <- tm_map(docs, toSpace, "以")
docs <- tm_map(docs, toSpace, "今")
docs <- tm_map(docs, toSpace, "亦")
docs <- tm_map(docs, toSpace, "有")
docs <- tm_map(docs, toSpace, "則")
docs <- tm_map(docs, toSpace, "於")
docs <- tm_map(docs, toSpace, "二")
docs <- tm_map(docs, toSpace, "丑")
docs <- tm_map(docs, toSpace, "為")
docs <- tm_map(docs, toSpace, "我")
docs <- tm_map(docs, toSpace, "矣")
docs <- tm_map(docs, toSpace, "此")
docs <- tm_map(docs, toSpace, "㸶")
docs <- tm_map(docs, toSpace, "後")
docs <- tm_map(docs, toSpace, "已")
docs <- tm_map(docs, toSpace, "薔")
docs <- tm_map(docs, toSpace, "乃")
docs <- tm_map(docs, toSpace, "是")
docs <- tm_map(docs, toSpace, "皆")
docs <- tm_map(docs, toSpace, "胤")
docs <- tm_map(docs, toSpace, "螻")
docs <- tm_map(docs, toSpace, "的")
docs <- tm_map(docs, toSpace, "但")
docs <- tm_map(docs, toSpace, "㸴")
docs <- tm_map(docs, toSpace, "即")
docs <- tm_map(docs, toSpace, "由")

docs <- tm_map(docs, toSpace, "[a-zA-Z]")
docs <- tm_map(docs, stripWhitespace)
#docs <- tm_map(docs, PlainTextDocument)
docs

mixseg = worker()
#Cutter online source: https://www.jianshu.com/p/260c20c7e334
new_user_word(mixseg,c("中國", "中華", "司令", "中央", "對手", "對華", "不可", "不能", "不敵", "不如", "不料", "日本", "本軍", "根本"))
#segment(file,mixseg) 

jieba_tokenizer=function(d){
  unlist(segment(d[[1]],mixseg))
}


seg = lapply(docs, jieba_tokenizer)
freqFrame = as.data.frame(table(unlist(seg)))
freqFrame = freqFrame[order(freqFrame$Freq,decreasing=TRUE), ]
library(knitr)
kable(head(freqFrame, 50), format = "markdown")

wordcloud(freqFrame$Var1,freqFrame$Freq,
          scale=c(5,0.1),min.freq=26,max.words=150,
          random.order=TRUE, random.color=FALSE, 
          rot.per=.1, colors=brewer.pal(8, "Dark2"),
          ordered.colors=FALSE,use.r.layout=FALSE,
          fixed.asp=TRUE)

