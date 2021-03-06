library(jsonlite)

ids = fromJSON("../BILGEWATER/EUW.json")
champ = read.table("champions_ids.txt",header=TRUE)
bots = read.table("champions_bot.txt",header=FALSE)

new_bots = c(1:length(bots[,1]))

bot = c()
for(i in 1:length(new_bots))
{
  bot = c(bot,rep(new_bots[i],length(new_bots)))
}
duo = data.frame(uno=bot,dos=rep(new_bots,length(new_bots)))

duo = unique(as.data.frame(t(apply(duo,1,sort,decreasing=F))))
duo = duo[order(duo[,1]),]
duo = duo[which(duo[,1]!=duo[,2]),]

duo_win = data.frame(uno=duo[,1],dos=duo[,2],win_uno=rep(0,length(duo[,1])),win_dos=rep(0,length(duo[,2])))

cont_1 = 0

for(i in 1:length(ids))
#for(i in 1:10)
{
  name = sprintf("../matches_timeline/match_%.0f.json",ids[i])
  a = fromJSON(name)

  top_n = which(grepl("DUO[:punct:]?",a$participants$timeline$role))
  top = a$participants$championId[which(grepl("DUO[:punct:]?",a$participants$timeline$role))]

  puntos = c(0,0)
  if(length(top)==4)
  {
    bot_1 = sort(c(top[1],top[2]))
    bot_2 = sort(c(top[3],top[4]))

    top = c(which(bots[,1]==bot_1[1]&bots[,2]==bot_1[2]),which(bots[,1]==bot_2[1]&bots[,2]==bot_2[2]))

    if(length(top)==2)
    {
      if(length(duo[which(duo[,1]==top[1]&duo[,2]==top[2]),])>0|length(duo[which(duo[,1]==top[2]&duo[,2]==top[1]),])>0)
      {
        #Se busca la primera torre que se ha roto
        for(j in 1:length(a$timeline$frames$events))
        {
          k = which(a$timeline$frames$events[[j]]$eventType=="BUILDING_KILL")
          if(length(k)>0)
          {
            k = k[1]
            time = a$timeline$frames$events[[j]]$timestamp[k]
            break
          }
        }
        killer = a$timeline$frames$events[[j]]$killerId[k]

        #Puntos torre
        if(killer==top_n[1]|killer==top_n[2])
        {
          puntos[1] = puntos[1] + 2
        } else if (killer==top_n[3]|killer==top_n[4]) {
          puntos[2] = puntos[2] + 2
        }

        #Puntos oro
        oro1 = a$participants$timeline$goldPerMinDeltas$zeroToTen[top_n[1]] + a$participants$timeline$goldPerMinDeltas$zeroToTen[top_n[2]]
        oro2 = a$participants$timeline$goldPerMinDeltas$zeroToTen[top_n[3]] + a$participants$timeline$goldPerMinDeltas$zeroToTen[top_n[4]]
        if(oro1>(oro2*1.2))
        {
          puntos[1] = puntos[1] + 1
        } else if(oro2>(oro1*1.2)) {
          puntos[2] = puntos[2] + 1
        }

        #Puntos kills
        for(j in 1:length(a$timeline$frames$events))
        {
          k = which(a$timeline$frames$events[[j]]$eventType=="CHAMPION_KILL"&a$timeline$frames$events[[j]]$timestamp<time)
          if(length(k)>0)
          {
            for(l in 1:length(k))
            {
              if(a$timeline$frames$events[[j]]$killerId[k[l]]==top_n[1]|a$timeline$frames$events[[j]]$killerId[k[l]]==top_n[2])
              {
                puntos[1] = puntos[1] + 1
              } else if (a$timeline$frames$events[[j]]$killerId[k[l]]==top_n[3]|a$timeline$frames$events[[j]]$killerId[k[l]]==top_n[4]) {
                puntos[2] = puntos[2] + 1
              }

              if(length(a$timeline$frames$events[[j]]$assistingParticipantIds)>0)
              {
                if(!is.null(a$timeline$frames$events[[j]]$assistingParticipantIds[[k[l]]]))
                {
                  for(m in 1:length(a$timeline$frames$events[[j]]$assistingParticipantIds[[k[l]]]))
                  {
                    if(a$timeline$frames$events[[j]]$assistingParticipantIds[[k[l]]][m]==top_n[1]|a$timeline$frames$events[[j]]$assistingParticipantIds[[k[l]]][m]==top_n[2])
                    {
                      puntos[1] = puntos[1] + 0.5
                    } else if (a$timeline$frames$events[[j]]$assistingParticipantIds[[k[l]]][m]==top_n[3]|a$timeline$frames$events[[j]]$assistingParticipantIds[[k[l]]][m]==top_n[4]) {
                      puntos[2] = puntos[2] + 0.5
                    }
                  }
                }
              }

              if(a$timeline$frames$events[[j]]$timestamp[length(a$timeline$frames$events[[j]]$timestamp)]>time)
              {
                break
              }
            }
          }
        }

        if(top[1]<top[2])
        {
          n = which(duo[,1]==top[1]&duo[,2]==top[2])
          if(puntos[1]>puntos[2])
          {
            duo_win[n,3] = duo_win[n,3] + 1
          } else if(puntos[1]<puntos[2]) {
            duo_win[n,4] = duo_win[n,4] + 1
          }
        } else {
          n = which(duo[,1]==top[2]&duo[,1]==top[2])
          if(puntos[1]>puntos[2])
          {
          duo_win[n,4] = duo_win[n,4] + 1
          } else if(puntos[1]<puntos[2]) {
            duo_win[n,3] = duo_win[n,3] + 1
          }
        }
      }
    }
  }
}

write.table(duo_win,"bot_win.txt",row.names=FALSE,col.names=FALSE)
