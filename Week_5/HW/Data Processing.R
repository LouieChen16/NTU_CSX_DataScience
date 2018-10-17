library(NLP)
library(tm)
library(stats)
library(proxy)
library(dplyr)
library(readtext)
library(jiebaRD)
library(jiebaR)
library(slam)
library(Matrix)
library(tidytext)
library(wordcloud)

#Set Language as traditional Chinese
Sys.setlocale(category = "LC_ALL", locale = "cht")

rawData = readtext("*.txt")
docs = Corpus(VectorSource(rawData$text))
# data clean
toSpace <- content_transformer(function(x, pattern) {
  return (gsub(pattern, " ", x))
})
docs <- tm_map(docs, removePunctuation)
docs <- tm_map(docs, removeNumbers)
docs <- tm_map(docs, stripWhitespace)
docs <- tm_map(docs, toSpace, "分享平台")
docs <- tm_map(docs, toSpace, "人人網")
docs <- tm_map(docs, toSpace, "開心網")
docs <- tm_map(docs, toSpace, "微博")
docs <- tm_map(docs, toSpace, "豆瓣")
#docs <- tm_map(docs, toSpace, "Facebook")
#docs <- tm_map(docs, toSpace, "Messenger")
#docs <- tm_map(docs, toSpace, "Twitter")
#docs <- tm_map(docs, toSpace, "Plurk")
#docs <- tm_map(docs, toSpace, "QQ")
#docs <- tm_map(docs, toSpace, "Google+")
#docs <- tm_map(docs, toSpace, "LinkedIn")
#docs <- tm_map(docs, toSpace, "WhatsApp")
docs <- tm_map(docs, toSpace, "複製鏈接")
docs <- tm_map(docs, toSpace, "這是外部鏈接，瀏覽器將打開另一個窗口")
docs <- tm_map(docs, toSpace, "大紀元")
docs <- tm_map(docs, toSpace, "年")
docs <- tm_map(docs, toSpace, "月")
docs <- tm_map(docs, toSpace, "日")
docs <- tm_map(docs, toSpace, "訊")
docs <- tm_map(docs, toSpace, "【")
docs <- tm_map(docs, toSpace, "】")
docs <- tm_map(docs, toSpace, "（")
docs <- tm_map(docs, toSpace, "）")
docs <- tm_map(docs, toSpace, "綜合")
docs <- tm_map(docs, toSpace, "報導")
docs <- tm_map(docs, toSpace, "影音")
docs <- tm_map(docs, toSpace, "評論")
docs <- tm_map(docs, toSpace, "健康")
docs <- tm_map(docs, toSpace, "責任編輯")
docs <- tm_map(docs, toSpace, "<")
docs <- tm_map(docs, toSpace, ">")
docs <- tm_map(docs, toSpace, "維基百科")
docs <- tm_map(docs, toSpace, "隨時關注最新創業、科技、網路、工作訊息。")
docs <- tm_map(docs, toSpace, "延伸閱讀與參考：")
docs <- tm_map(docs, toSpace, "分享文章或觀看評論")
docs <- tm_map(docs, toSpace, "硬塞的網路趨勢觀察")
docs <- tm_map(docs, toSpace, "記者")
docs <- tm_map(docs, toSpace, "我們為什麼挑選這篇文章")
docs <- tm_map(docs, toSpace, "本文經合作夥伴")
docs <- tm_map(docs, toSpace, "授權轉載")
docs <- tm_map(docs, toSpace, "並同意 TechOrange 編寫導讀與修訂標題")
docs <- tm_map(docs, toSpace, "原文標題為")
docs <- tm_map(docs, toSpace, "1. 高度關注國際科技趨勢、台灣產業新聞 
2. 根據月度編輯台企劃，執行編輯、採訪與撰稿工作 
3. 進行線上、線下媒體策展 
4. 根據不同策展專案進行跨部門溝通 
5. 針對網站數據做解讀與優化分析 
6. 具有 2~3 年工作經驗的媒體工作者 
7. 習慣閱讀《彭博社》、《財富雜誌》、《金融時報》、《Fast Company》者更佳 
8. 目標導向思考，對準目標、彈性工作")
docs <- tm_map(docs, toSpace, "意者請提供履歷自傳以及「相關文字作品」，寄至  [email<U+00A0>protected]。來信主旨請註明：【應徵】TechOrange 社群編輯：您的大名")
docs <- tm_map(docs, toSpace, "的")
docs <- tm_map(docs, toSpace, "在")
docs <- tm_map(docs, toSpace, "馬斯克")
docs <- tm_map(docs, toSpace, "了")
docs <- tm_map(docs, toSpace, "是")
docs <- tm_map(docs, toSpace, "他")
docs <- tm_map(docs, toSpace, "為")
docs <- tm_map(docs, toSpace, "和")
docs <- tm_map(docs, toSpace, "但")
docs <- tm_map(docs, toSpace, "對")
docs <- tm_map(docs, toSpace, "與")
docs <- tm_map(docs, toSpace, "就")
docs <- tm_map(docs, toSpace, "慎")
docs <- tm_map(docs, toSpace, "已經")
docs <- tm_map(docs, toSpace, "五")
docs <- tm_map(docs, toSpace, "我")
docs <- tm_map(docs, toSpace, "可能")
docs <- tm_map(docs, toSpace, "可以")
docs <- tm_map(docs, toSpace, "而")
docs <- tm_map(docs, toSpace, "讓")
docs <- tm_map(docs, toSpace, "這")
docs <- tm_map(docs, toSpace, "個")
docs <- tm_map(docs, toSpace, "你")
docs <- tm_map(docs, toSpace, "他們")
docs <- tm_map(docs, toSpace, "我")
docs <- tm_map(docs, toSpace, "以")
docs <- tm_map(docs, toSpace, "後")
docs <- tm_map(docs, toSpace, "被")
docs <- tm_map(docs, toSpace, "們")
docs <- tm_map(docs, toSpace, "有")
docs <- tm_map(docs, toSpace, "說")
docs <- tm_map(docs, toSpace, "都")
docs <- tm_map(docs, toSpace, "有")
docs <- tm_map(docs, toSpace, "進行")
docs <- tm_map(docs, toSpace, "㸱")
docs <- tm_map(docs, toSpace, "忖")
docs <- tm_map(docs, toSpace, "丹")
docs <- tm_map(docs, toSpace, "其")
docs <- tm_map(docs, toSpace, "及")


docs <- tm_map(docs, toSpace, "[a-zA-Z]")

# words cut
#keywords = read.csv("keywords.csv")
mixseg = worker()
#keys = as.matrix(keywords)
#new_user_word(mixseg, keys)
new_user_word(mixseg, "公布", "宣布", "發布", "特斯拉", "伊隆", "馬斯克", "降低", "相互", "互聯網", "互動", "中國", "獵鷹重型", "私有化")

jieba_tokenizer = function(d){
  unlist(segment(d[[1]], mixseg))
}
seg = lapply(docs, jieba_tokenizer)

#詞頻矩陣
freqFrame = as.data.frame(table(unlist(seg)))
freqFrame = freqFrame[order(freqFrame$Freq,decreasing=TRUE), ]
library(knitr)
kable(head(freqFrame, 30), format = "markdown")

#Word Cloud
wordcloud(freqFrame$Var1,freqFrame$Freq,
          scale=c(5,0.1),min.freq=49,max.words=1000,
          random.order=TRUE, random.color=FALSE, 
          rot.per=.1, colors=brewer.pal(8, "Dark2"),
          ordered.colors=FALSE,use.r.layout=FALSE,
          fixed.asp=TRUE)


d.corpus <- Corpus(VectorSource(seg))
tdm <- TermDocumentMatrix(d.corpus)
#print( tf <- as.matrix(tdm) )
DF <- tidy(tf)

# tf-idf computation
N = tdm$ncol
tf <- apply(tdm, 2, sum)
idfCal <- function(word_doc)
{ 
  log2( N / nnzero(word_doc) ) 
}
idf <- apply(tdm, 1, idfCal)

doc.tfidf <- as.matrix(tdm)
for(x in 1:nrow(tdm))
{
  for(y in 1:ncol(tdm))
  {
    doc.tfidf[x,y] <- (doc.tfidf[x,y] / tf[y]) * idf[x]
  }
}

findZeroId = as.matrix(apply(doc.tfidf, 1, sum))
tfidfnn = doc.tfidf[-which(findZeroId == 0),]


#Outout File
write.table(tfidfnn, 'show.txt')
write.csv(tfidfnn, "show.csv")