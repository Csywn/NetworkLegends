library(jsonlite)

ids = fromJSON("../BILGEWATER/EUW.json")
bichos_id = read.table("brawlers_groups.txt",header=TRUE)
bichos_id = bichos_id[1:50,]

bichos = c(1:length(bichos_id[,1]))
bich = c()
for(i in 1:length(bichos))
{
  bich = c(bich,rep(bichos[i],length(bichos)))
}
duo = data.frame(uno=bich,dos=rep(bichos,length(bichos)))

duo = unique(as.data.frame(t(apply(duo,1,sort,decreasing=F))))
duo = duo[order(duo[,1]),]
duo = duo[which(duo[,1]!=duo[,2]),]

duo_win = data.frame(uno=duo[,1],dos=duo[,2],win_uno=rep(0,length(duo[,1])),win_dos=rep(0,length(duo[,2])))

for(i in 1:length(ids))
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

  id_1 = which(bichos_id[,1]==ra1&bichos_id[,2]==ir1&bichos_id[,3]==pl1&bichos_id[,4]==oc1)
  id_2 = which(bichos_id[,1]==ra2&bichos_id[,2]==ir2&bichos_id[,3]==pl2&bichos_id[,4]==oc2)

  if((length(id_1)+length(id_2))==2)
  {
    win = as.integer(a$team$winner)
    if(id_1 < id_2)
    {
      k = which(duo_win[,1]==id_1&duo_win[,2]==id_2)
      duo_win[k,3] = duo_win[k,3] + win[1]
      duo_win[k,4] = duo_win[k,4] + win[2]    
    } else {
      k = which(duo_win[,1]==id_2&duo_win[,2]==id_1)
      duo_win[k,3] = duo_win[k,3] + win[2]
      duo_win[k,4] = duo_win[k,4] + win[1]   

    }
  }
}

write.table(duo_win,"brawlers_win.txt",row.names=FALSE,col.names=FALSE)
