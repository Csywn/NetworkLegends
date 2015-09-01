library(jsonlite)

ids = fromJSON("../BILGEWATER/EUW.json")

razorfin_id = 3611
ironback_id = 3612
plundercrab_id = 3613
ocklepod_id = 3614

bichos = data.frame(razorfin=c(),ironback=c(),plundercrab=c(),ocklepod=c(),times=c())

for(i in 1:10000)
{
  name = sprintf("../matches_timeline/match_%.0f.json",ids[i])
  a = fromJSON(name)
  b = a$timeline$frames$events
  ra1=ir1=pl1=oc1=0
  ra2=ir2=pl2=oc2=0
  for(j in 1:length(b))
  {
    ra1 = ra1 + length(which(b[[j]]$itemId==razorfin_id&b[[j]]$participantId<=5))/2
    ir1 = ir1 + length(which(b[[j]]$itemId==ironback_id&b[[j]]$participantId<=5))/2
    pl1 = pl1 + length(which(b[[j]]$itemId==plundercrab_id&b[[j]]$participantId<=5))/2
    oc1 = oc1 + length(which(b[[j]]$itemId==ocklepod_id&b[[j]]$participantId<=5))/2

    ra2 = ra2 + length(which(b[[j]]$itemId==razorfin_id&b[[j]]$participantId>5))/2
    ir2 = ir2 + length(which(b[[j]]$itemId==ironback_id&b[[j]]$participantId>5))/2
    pl2 = pl2 + length(which(b[[j]]$itemId==plundercrab_id&b[[j]]$participantId>5))/2
    oc2 = oc2 + length(which(b[[j]]$itemId==ocklepod_id&b[[j]]$participantId>5))/2
  }

  win = as.integer(a$team$winner)
  bichos = rbind(bichos,data.frame(razorfin=ra1,ironback=ir1,plundercrab=pl1,ocklepod=oc1,times=1,win=win[1]))
  bichos = rbind(bichos,data.frame(razorfin=ra2,ironback=ir2,plundercrab=pl2,ocklepod=oc2,times=1,win=win[2]))
}

times = aggregate(times ~ razorfin + ironback + plundercrab + ocklepod, data = bichos, sum)
win = aggregate(win ~ razorfin + ironback + plundercrab + ocklepod, data = bichos, sum)
bichos = merge(times,win,by=c("razorfin","ironback","plundercrab","ocklepod"))

bichos[,6] = bichos[,6]*100/bichos[,5]
bichos[,5] = bichos[,5]*100/10000

bichos[,5] = round(bichos[,5],2)
bichos[,6] = round(bichos[,6],1)

b = '"cols": [{"label": "", "type":"string"},{"label": "", "type":"string"},{"label": "Brawlers", "type":"string"},{"label": "", "type":"string"},{"label": "", "type":"string"},{"label": "Pick Rate (%)", "type":"number"},{"label": "Win Rate (%)", "type":"number"}],'

cols = c()
column = data.frame(bicho1=0,bicho2=0,bicho3=0,bicho4=0,bicho5=0,win=0,pick=0)
for(i in 1:length(bichos[,1]))
{
  j = 0
  k = 1
  while(j < bichos[i,1])
  {
    column[1,k] = paste('{"v": "<img src=\\"bichos/brawlers/',1,'.png\\" height=\\"32\\\" width=\\"32\\" title=\\"',"Razorfin",'\\" >"',sep='')
    column[1,k] = paste(column[1,k],'},',sep='')
    k = k + 1
    j = j + 1
  }

  j = 0
  while(j < bichos[i,2])
  {
    column[1,k] = paste('{"v": "<img src=\\"bichos/brawlers/',2,'.png\\" height=\\"32\\\" width=\\"32\\" title=\\"',"Ironback",'\\" >"',sep='')
    column[1,k] = paste(column[1,k],'},',sep='')
    k = k + 1
    j = j + 1
  }

  j = 0
  while(j < bichos[i,3])
  {
    column[1,k] = paste('{"v": "<img src=\\"bichos/brawlers/',3,'.png\\" height=\\"32\\\" width=\\"32\\" title=\\"',"Plundercrab",'\\" >"',sep='')
    column[1,k] = paste(column[1,k],'},',sep='')
    k = k + 1
    j = j + 1
  }

  j = 0
  while(j < bichos[i,4])
  {
    column[1,k] = paste('{"v": "<img src=\\"bichos/brawlers/',4,'.png\\" height=\\"32\\\" width=\\"32\\" title=\\"',"Ocklepod",'\\" >"',sep='')
    column[1,k] = paste(column[1,k],'},',sep='')
    k = k + 1
    j = j + 1
  }

  while(k < 6)
  {
    column[1,k] = paste('{"v": ""',sep='')
    column[1,k] = paste(column[1,k],'},',sep='')
    k = k + 1
  }

  column[1,k] = paste('{"v":',as.character(bichos[i,5]))
  column[1,k] = paste(column[1,k],'},',sep='')
  k = k + 1
  column[1,k] = paste('{"v":',as.character(bichos[i,6]))
  column[1,k] = paste(column[1,k],'}]',sep='')

  col = paste('"c":[',column[1,1],column[1,2],column[1,3],column[1,4],column[1,5],column[1,6],column[1,7])
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

write(b,"table_brawlers.json")
  
