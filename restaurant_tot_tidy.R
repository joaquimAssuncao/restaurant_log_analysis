require(dplyr)
require(hflights)
require(ggplot2)

#Import data
sample_ldata <- readLines("sample.txt")   

#3547 is the number of products sold
#1635 is the number of transactions
DF_rest_trans <- data.frame(matrix(ncol = 6, nrow = 1635))
names(DF_rest_trans) <- c("valorTotal",	"cnpj",	"xLgr",	"timestamp", "infCpl",	"vToTrib")


#extract the total value of the transaction
txtspl <- regmatches(sample_ldata, gregexpr("(?<=\"valorTotal\": ).*", sample_ldata, perl=TRUE))
txtspl <- unlist(txtspl)
DF_rest_trans$valorTotal <- txtspl

#extract the transaction timestamp
txtspl <- regmatches(sample_ldata, gregexpr("(?<=date\": \").*?(?=\")", sample_ldata, perl=TRUE))
txtspl <- unlist(txtspl)
DF_rest_trans$timestamp <- txtspl

#...CNPJ
txtspl <- regmatches(sample_ldata, gregexpr("(?<=\"cnpj\": \").*?(?=\")", sample_ldata, perl=TRUE))
txtspl <- unlist(txtspl)
DF_rest_trans$cnpj <- txtspl
 
#...xLgr
txtspl <- regmatches(sample_ldata, gregexpr("(?<=xLgr\": \").*?(?=\")", sample_ldata, perl=TRUE))
txtspl <- unlist(txtspl)
DF_rest_trans$xLgr <- txtspl 
#...unique(DF_rest_trans$xLgr) ... Ok, just one place

#...wich place/table?
txtspl <- regmatches(sample_ldata, gregexpr("(?<=infCpl\": \").*?(?=\")", sample_ldata, perl=TRUE))
txtspl <- unlist(txtspl)
DF_rest_trans$infCpl <- txtspl 

#...taxes
txtspl <- regmatches(sample_ldata, gregexpr("(?<=vTotTrib\": ).*?(?=,)", sample_ldata, perl=TRUE))
txtspl <- unlist(txtspl)
DF_rest_trans$vToTrib <- txtspl 

#split the timeStamp into date and weekday
DF_rest_trans$date <- as.Date(DF_rest_tot$timestamp,'%Y-%m-%d') 
DF_rest_trans$week_day <-  weekdays(as.Date(DF_rest_tot$date,'%Y-%m-%d'))

#save a tidy DS
write.csv(DF_rest_trans, "DF_rest_tot.csv")


## ----- Notes -------
# There are many other important variables which I am not considering here.
# As a demonstration code, only few fields will be considered.
