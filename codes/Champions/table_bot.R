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
  boti = a$participants$championId[which(grepl("DUO[:punct:]?",a$participants$timeline$role))]
  top = rbind(top,data.frame(uno=boti[1],dos=boti[2]))
  top = rbind(top,data.frame(uno=boti[3],dos=boti[4]))
}

top = top[complete.cases(top),]
top = as.data.frame(t(apply(top,1,sort,decreasing=F)))
top_agregado = data.frame(uno=top[,1],dos=top[,2],times=rep(1,length(top[,1])))
top_agregado = aggregate(top_agregado$times,list(top_agregado$uno,top_agregado$dos),sum)

top = data.frame(ids_uno=top_agregado[,1],ids_dos=top_agregado[,2],games=top_agregado[,3],win=rep(0,length(top_agregado[,1])),pick=top_agregado[,3],K1=rep(0,length(top_agregado[,1])),D1=rep(0,length(top_agregado[,1])),A1=rep(0,length(top_agregado[,1])),K2=rep(0,length(top_agregado[,1])),D2=rep(0,length(top_agregado[,1])),A2=rep(0,length(top_agregado[,1])),item01=rep(0,length(top_agregado[,1])),item11=rep(0,length(top_agregado[,1])),item02=rep(0,length(top_agregado[,1])),item12=rep(0,length(top_agregado[,1])))

items_top = as.data.frame(matrix(0,ncol=500,nrow=10000))
items_top_i = rep(1,500)

for(i in 1:max)
{
  name = sprintf("../matches/match_%.0f.json",ids[i])
  a = fromJSON(name)
  boti = which(grepl("DUO[:punct:]?",a$participants$timeline$role))
  bot_1 = c(boti[1],boti[2])
  bot_1 = bot_1[!is.na(bot_1)]
  bot_2 = c(boti[3],boti[4])
  bot_2 = bot_2[!is.na(bot_2)]

  if(length(bot_1)==2)
  {
    k = which(top[,1]==a$participants$championId[bot_1[1]]&top[,2]==a$participants$championId[bot_1[2]])
    top$K1[k] = top$K1[k] + a$participants$stats$kills[bot_1[1]]
    top$D1[k] = top$D1[k] + a$participants$stats$assists[bot_1[1]]
    top$A1[k] = top$A1[k] + a$participants$stats$deaths[bot_1[1]]

    top$K2[k] = top$K2[k] + a$participants$stats$kills[bot_1[2]]
    top$D2[k] = top$D2[k] + a$participants$stats$assists[bot_1[2]]
    top$A2[k] = top$A2[k] + a$participants$stats$deaths[bot_1[2]]

    top$win[k] = top$win[k] + a$participants$stats$winner[bot_1[1]]
   
    for(j in 1:2)
    {
      id = a$participants$championId[bot_1[j]]
      items_top[items_top_i[id],id] = a$participants$stats$item0[bot_1[j]]
      items_top[items_top_i[id]+1,id] = a$participants$stats$item1[bot_1[j]]
      items_top[items_top_i[id]+2,id] = a$participants$stats$item2[bot_1[j]]
      items_top[items_top_i[id]+3,id] = a$participants$stats$item3[bot_1[j]]
      items_top[items_top_i[id]+4,id] = a$participants$stats$item4[bot_1[j]]
      items_top[items_top_i[id]+5,id] = a$participants$stats$item5[bot_1[j]]
      items_top[items_top_i[id]+6,id] = a$participants$stats$item6[bot_1[j]]
      items_top_i[id] = items_top_i[id] + 7
    } 
  }

  if(length(bot_2)==2)
  {
    k = which(top[,1]==a$participants$championId[bot_2[1]]&top[,2]==a$participants$championId[bot_2[2]])
    top$K1[k] = top$K1[k] + a$participants$stats$kills[bot_2[1]]
    top$D1[k] = top$D1[k] + a$participants$stats$deaths[bot_2[1]]
    top$A1[k] = top$A1[k] + a$participants$stats$assists[bot_2[1]]

    top$K2[k] = top$K2[k] + a$participants$stats$kills[bot_2[2]]
    top$D2[k] = top$D2[k] + a$participants$stats$deaths[bot_2[2]]
    top$A2[k] = top$A2[k] + a$participants$stats$assists[bot_2[2]]

    top$win[k] = top$win[k] + a$participants$stats$winner[bot_2[1]]

    for(j in 1:2)
    {
      id = a$participants$championId[bot_2[j]]
      items_top[items_top_i[id],id] = a$participants$stats$item0[bot_2[j]]
      items_top[items_top_i[id]+1,id] = a$participants$stats$item1[bot_2[j]]
      items_top[items_top_i[id]+2,id] = a$participants$stats$item2[bot_2[j]]
      items_top[items_top_i[id]+3,id] = a$participants$stats$item3[bot_2[j]]
      items_top[items_top_i[id]+4,id] = a$participants$stats$item4[bot_2[j]]
      items_top[items_top_i[id]+5,id] = a$participants$stats$item5[bot_2[j]]
      items_top[items_top_i[id]+6,id] = a$participants$stats$item6[bot_2[j]]
      items_top_i[id] = items_top_i[id] + 7
    } 
  }
}

for(k in 1:length(top[,1]))
{
  top$win[k] = top$win[k]*100/top$games[k]
  top$pick[k] = top$pick[k]*100/10000
  top$K1[k] = top$K1[k]/top$games[k]
  top$D1[k] = top$D1[k]/top$games[k]
  top$A1[k] = top$A1[k]/top$games[k]
  top$K2[k] = top$K2[k]/top$games[k]
  top$D2[k] = top$D2[k]/top$games[k]
  top$A2[k] = top$A2[k]/top$games[k]
}

for(i in 1:length(top[,1]))
{
  id_1 = top[i,1]
  id_2 = top[i,2]

  e_1 = table(items_top[,id_1])
  e_1 = sort(e_1,decreasing=TRUE)
  e_1 = e_1[names(e_1)!=0]

  e_2 = table(items_top[,id_2])
  e_2 = sort(e_2,decreasing=TRUE)
  e_2 = e_2[names(e_2)!=0]

  if(length(e_1)>0)
  {
    b = data.frame(id=as.numeric(names(e_1)),times=e_1)
    b = subset(b, b[,1] %in% valid_item)
    k = which(top[,1]==id_1&top[,2]==id_2)
    if(length(b[,1])>0)
    {
      row.names(b) = c(1:length(b[,1]))
      top$item01[k] = b[1,1]
      top$item11[k] = b[2,1]
    } else {
      top$item01[k] = NA
      top$item11[k] = NA
    }
  }

  if(length(e_2)>0)
  {
    b = data.frame(id=as.numeric(names(e_2)),times=e_2)
    b = subset(b, b[,1] %in% valid_item)
    k = which(top[,1]==id_1&top[,2]==id_2)
    if(length(b[,1])>0)
    {
      row.names(b) = c(1:length(b[,1]))
      top$item02[k] = b[1,1]
      top$item12[k] = b[2,1]
    } else {
      top$item02[k] = NA
      top$item12[k] = NA
    }
  }
}


#b = c()
#b$cols = data.frame(label=c('Champion','Win Rate','Pick Rate','K','D','A','item0','item1','item2','item3','item4','item5','item6'),type=c('number','number','number','number','number','number','number','number','number','number','number','number','number'))

b = '"cols": [{"label": "Duo", "type":"string"},{"label": "Bot", "type":"string"},{"label": "Win Rate (%)", "type":"number"},{"label": "Pick Rate (%)", "type":"number"},{"label": "K", "type":"number"},{"label": "D", "type":"number"},{"label": "A", "type":"number"},{"label": "Items", "type":"number"},{"label": "", "type":"number"},{"label": "K", "type":"number"},{"label": "D", "type":"number"},{"label": "A", "type":"number"},{"label": "Items", "type":"number"},{"label": "", "type":"number"}],'

f = top[,1:2]
f = cbind(f,top[,4:15])
f[,3] = round(f[,3],1)
f[,4] = round(f[,4],2)
f[,5] = round(f[,5],1)
f[,6] = round(f[,6],1)
f[,7] = round(f[,7],1)
f[,8] = round(f[,8],1)
f[,9] = round(f[,9],1)
f[,10] = round(f[,10],1)
f[is.na(f)] = "null"

f = f[which(f[,4]>0.05),]
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
  c_2 = paste('{"v": "<img src=\\"roulette/personajes/',f[i,2],'.png\\" height=\\"32\\\" width=\\"32\\" title=\\"',champions[which(champions[,2]==f[i,2]),1],'\\" >"',sep='')
  c_2 = paste(c_2,'},',sep='')
  c_3 = paste('{"v":',as.character(f[i,3]))
  c_3 = paste(c_3,'},',sep='')
  c_4 = paste('{"v":',as.character(f[i,4]))
  c_4 = paste(c_4,'},',sep='')
  c_5 = paste('{"v":',as.character(f[i,5]))
  c_5 = paste(c_5,'},',sep='')
  c_6 = paste('{"v":',as.character(f[i,6]))
  c_6 = paste(c_6,'},',sep='')
  c_7 = paste('{"v":',as.character(f[i,7]))
  c_7 = paste(c_7,'},',sep='')
  if(f[i,11]=="null")
  {
    c_8 = '{"v": ""'
  } else {
    c_8 = paste('{"v": "<img src=\\"table/item/',f[i,11],'.png\\" height=\\"32\\\" width=\\"32\\" title=\\"',items[which(items[,2]==f[i,11]),1],'\\" >"',sep='')
  }
  c_8 = paste(c_8,'},',sep='')
  if(f[i,12]=="null")
  {
    c_9 = '{"v": ""'
  } else {
    c_9 = paste('{"v": "<img src=\\"table/item/',f[i,12],'.png\\" height=\\"32\\\" width=\\"32\\" title=\\"',items[which(items[,2]==f[i,12]),1],'\\" >"',sep='')
  }  
  c_9 = paste(c_9,'},',sep='')
  c_10 = paste('{"v":',as.character(f[i,8]))
  c_10 = paste(c_10,'},',sep='')
  c_11 = paste('{"v":',as.character(f[i,9]))
  c_11 = paste(c_11,'},',sep='')
  c_12 = paste('{"v":',as.character(f[i,10]))
  c_12 = paste(c_12,'},',sep='')
  if(f[i,13]=="null")
  {
    c_13 = '{"v": ""'
  } else {
    c_13 = paste('{"v": "<img src=\\"table/item/',f[i,13],'.png\\" height=\\"32\\\" width=\\"32\\" title=\\"',items[which(items[,2]==f[i,13]),1],'\\" >"',sep='')
  }
  c_13 = paste(c_13,'},',sep='')
  if(f[i,14]=="null")
  {
    c_14 = '{"v": ""'
  } else {
    c_14 = paste('{"v": "<img src=\\"table/item/',f[i,14],'.png\\" height=\\"32\\\" width=\\"32\\" title=\\"',items[which(items[,2]==f[i,14]),1],'\\" >"',sep='')
  }  
  c_14 = paste(c_14,'}]',sep='')
  col = paste('"c":[',c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14)
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

write(b,"table_boti.json")
  
