library(jsonlite)

ids = fromJSON("../BILGEWATER/EUW.json")
champ = read.table("champions_ids.txt",header=TRUE)

valid_item = c(3742,3744,3911,3924,3829,3433,3652,3150,3844,3431,3841,3434,3840,3745,3430,1335,1336,1337,1338,1339,1340,1341)

top = c()

#for(i in 1:length(ids))
max = length(ids)
for(i in 1:max)
{
  name = sprintf("../matches/match_%.0f.json",ids[i])
  a = fromJSON(name)
  top = c(top,a$participants$championId[which(a$participants$timeline$lane=="JUNGLE")])
}

top_agregado = data.frame(champ=top,times=rep(1,length(top)))
top_agregado = aggregate(top_agregado$times,list(top_agregado$champ),sum)

top = data.frame(ids=top_agregado[,1],games=top_agregado[,2],win=rep(0,length(top_agregado[,1])),pick=top_agregado[,2],K=rep(0,length(top_agregado[,1])),D=rep(0,length(top_agregado[,1])),A=rep(0,length(top_agregado[,1])),item0=rep(0,length(top_agregado[,1])),item1=rep(0,length(top_agregado[,1])))

items_top = as.data.frame(matrix(0,ncol=500,nrow=10000))
items_top_i = rep(1,500)

for(i in 1:max)
{
  name = sprintf("../matches/match_%.0f.json",ids[i])
  a = fromJSON(name)
  champions = which(a$participants$timeline$lane=="JUNGLE")

  if(length(champions)>0)
  {
    for(j in 1:length(champions))
    {
      k = which(top[,1]==a$participants$championId[champions[j]])
      top$win[k] = top$win[k] + a$participants$stats$winner[champions[j]]
      top$A[k] = top$A[k] + a$participants$stats$assists[champions[j]]
      top$D[k] = top$D[k] + a$participants$stats$deaths[champions[j]]
      top$K[k] = top$K[k] + a$participants$stats$kills[champions[j]]

      id = a$participants$championId[champions[j]]
      items_top[items_top_i[id],id] = a$participants$stats$item0[champions[j]]
      items_top[items_top_i[id]+1,id] = a$participants$stats$item1[champions[j]]
      items_top[items_top_i[id]+2,id] = a$participants$stats$item2[champions[j]]
      items_top[items_top_i[id]+3,id] = a$participants$stats$item3[champions[j]]
      items_top[items_top_i[id]+4,id] = a$participants$stats$item4[champions[j]]
      items_top[items_top_i[id]+5,id] = a$participants$stats$item5[champions[j]]
      items_top[items_top_i[id]+6,id] = a$participants$stats$item6[champions[j]]
      items_top_i[id] = items_top_i[id] + 7
    }
  }  
}

for(k in 1:length(top[,1]))
{
  top$win[k] = top$win[k]*100/top$games[k]
  top$pick[k] = top$pick[k]*100/10000
  top$K[k] = top$K[k]/top$games[k]
  top$D[k] = top$D[k]/top$games[k]
  top$A[k] = top$A[k]/top$games[k]
}

for(i in 1:length(colnames(items_top)))
{
  e = table(items_top[,i])
  e = sort(e,decreasing=TRUE)
  e = e[names(e)!=0]

  if(length(e)>0)
  {
    b = data.frame(id=as.numeric(names(e)),times=e)
    b = subset(b, b[,1] %in% valid_item)
    k = which(top$ids==i)
    if(length(b[,1])>0)
    {
      row.names(b) = c(1:length(b[,1]))
      top$item0[k] = b[1,1]
      top$item1[k] = b[2,1]
    } else {
      top$item0[k] = NA
      top$item1[k] = NA
    }
  }
}

#b = c()
#b$cols = data.frame(label=c('Champion','Win Rate','Pick Rate','K','D','A','item0','item1','item2','item3','item4','item5','item6'),type=c('number','number','number','number','number','number','number','number','number','number','number','number','number'))

b = '"cols": [{"label": "Champion", "type":"number"},{"label": "Win Rate (%)", "type":"number"},{"label": "Pick Rate (%)", "type":"number"},{"label": "K", "type":"number"},{"label": "D", "type":"number"},{"label": "A", "type":"number"},{"label": "Items", "type":"number"},{"label": "", "type":"number"}],'

f = top[,1]
f = cbind(f,top[,3:9])
f[,2] = round(f[,2],1)
f[,3] = round(f[,3],2)
f[,4] = round(f[,4],1)
f[,5] = round(f[,5],1)
f[,6] = round(f[,6],1)
f[is.na(f)] = "null"
#i = 1
#h = c()
#h$c = data.frame(v=list(f[i,1]),v=list(f[i,2]),v=list(f[i,3]),v=list(f[i,4]),v=list(f[i,5]),v=list(f[i,6]),v=list(f[i,7]),v=list(f[i,8]),v=list(f[i,9]),v=list(f[i,10]),v=list(f[i,11]),v=list(f[i,12]),v=list(f[i,13]))

champions = read.table("champions_ids.txt",header=TRUE)
items = read.table("items_ids.txt",header=TRUE)

cols = c()
for(i in 1:length(f[,1]))
{
  c_1 = paste('{"v": "<img src=\\"roulette/personajes/',f[i,1],'.png\\" height=\\"32\\\" width=\\"32\\" title=\\"',champions[which(champions[,2]==f[i,1]),1],'\\" >"',sep='')
  c_1 = paste(c_1,'},',sep='')
  c_2 = paste('{"v":',as.character(f[i,2]))
  c_2 = paste(c_2,'},',sep='')
  c_3 = paste('{"v":',as.character(f[i,3]))
  c_3 = paste(c_3,'},',sep='')
  c_4 = paste('{"v":',as.character(f[i,4]))
  c_4 = paste(c_4,'},',sep='')
  c_5 = paste('{"v":',as.character(f[i,5]))
  c_5 = paste(c_5,'},',sep='')
  c_6 = paste('{"v":',as.character(f[i,6]))
  c_6 = paste(c_6,'},',sep='')
  if(f[i,7]=="null")
  {
    c_7 = '{"v": ""'
  } else {
    c_7 = paste('{"v": "<img src=\\"table/item/',f[i,7],'.png\\" height=\\"32\\\" width=\\"32\\" title=\\"',items[which(items[,2]==f[i,7]),1],'\\" >"',sep='')
  }
  c_7 = paste(c_7,'},',sep='')
  if(f[i,8]=="null")
  {
    c_8 = '{"v": ""'
  } else {
    c_8 = paste('{"v": "<img src=\\"table/item/',f[i,8],'.png\\" height=\\"32\\\" width=\\"32\\" title=\\"',items[which(items[,2]==f[i,8]),1],'\\" >"',sep='')
  }  
  c_8 = paste(c_8,'}]',sep='')
  col = paste('"c":[',c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8)
  col = paste('{',col,'}',sep='')
  if(i==1)
  {
    cols = paste(cols,col,sep='')
  } else {
    cols = paste(cols,col,sep=',')
  }
}

cols = paste('"rows": [',cols,']',sep='')
b = paste("{",b,cols,"}",sep="")

write(b,"table_jungle.json")
  
