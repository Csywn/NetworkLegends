library(jsonlite)

ids = fromJSON("../BILGEWATER/EUW.json")

razorfin_id = 3611
ironback_id = 3612
plundercrab_id = 3613
ocklepod_id = 3614

bichos = data.frame(razorfin=c(),ironback=c(),plundercrab=c(),ocklepod=c(),times=c())

#for(i in 1:length(ids))
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

  bichos = rbind(bichos,data.frame(razorfin=ra1,ironback=ir1,plundercrab=pl1,ocklepod=oc1,times=1))
  bichos = rbind(bichos,data.frame(razorfin=ra2,ironback=ir2,plundercrab=pl2,ocklepod=oc2,times=1))
}


bichos_agregado = aggregate(bichos$times,list(razorfin=bichos[,1],ironback=bichos[,2],plundercrab=bichos[,3],ocklepod=bichos[,4]),sum)
bichos_agregado = cbind(bichos_agregado,c(1:length(bichos_agregado[,1])))
write.table(bichos_agregado[order(-bichos_agregado$x),],"brawlers_groups.txt",row.names=FALSE)
