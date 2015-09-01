# The Network of Legends

The purpose of this project is to study the game from a different point of view. Instead of focusing on the individuals we want to analyze the interactions between them, as well as the interactions between the different brawlers as we are using Black Market Brawlers data. In order to do this we have used statistical and network analysis techniques. 

The tools we have created help us to predict the most probable outcomes studying both our rivals and our own decisions.

##Description

The web page has the following sections:

- Champions:
  - There is a graph for each lane where the most played champions of that lane are linked together. If the source champion has a high probability of winning (see *methodology*) versus the target champion the link will be green and red otherwise (if there is no link between two champions it means that both probabilities are roughly the same). The thickness of the link is algo proportional to that probability.
  - A table with the win rate, pick rate, average K/D/A and the most common Black Market Brawlers items for each champion played on that lane.

- Brawlers:
  - There is a graph where the most common combinations of brawlers as nodes. The color and thickness of the links have the same meaning as above.
  - Also there is a table with the pick rate and win rate of each combination.

- Teams:
  - There is a graph showing the community structure obtained from the data. If a team is composed of the champions inside the same community (circle) they have a higher probability of winning according to statistics.

A live version can be found at

http://network-legends.herokuapp.com/

Due to heroku limits the web might be temporary disabled (unlikely) and you will see an error page. In that case please try again later. Some pictures of the web page can be found inside screenshots folder.


##Methodology

1.- ruletas champs

- Se ejecuta links_lane.txt (faltan los archivos de los matches con timeline en la carpeta codes) -> se crea archivo "lane_win.txt"

- Se ejecuta script_champions_lane.R -> champions_lane.json con la posicion adecuada para la ruleta

2.- tablas: se meustran los objetos del black market mas comprados por cada jugador

3.- Que combinaciones son mejores frente a otras.

- script brawlers groups -> brawlers_groups, the most used combinations



4.- En la tabla cuales son mejores en general.

5.- Comunidades, enrollarse con las comunidades... Esos personajes al jugar juntos tienen mas probabilidades de vencer.

##Tech


Scalpin1

