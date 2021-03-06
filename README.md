# The Network of Legends

The purpose of this project is to study the game from a different point of view. Instead of focusing on the individuals we want to analyze the interactions between them, as well as the interactions between the different brawlers as we are using Black Market Brawlers data. In order to do this we have used statistical and network analysis techniques. 

The tools we have created help us to predict the most probable outcomes studying both our rivals and our own decisions.

##Description

The web page has the following sections:

- Champions:
  - There is a graph, for each lane, in which the most played champions of that lane are linked together. If the source champion has a high probability of winning (see *methodology*) versus the target champion the link will be green and red otherwise (if there is no link between two champions it means that both probabilities are roughly the same). The thickness of the link is proportional to that probability.

  - A table with the win rate, pick rate, average K/D/A and the most common Black Market Brawlers items for each champion played on that lane.

- Brawlers:
  - In this graph the most common combinations of brawlers are the nodes. The color and thickness of the links have the same meaning as above.
  - Also there is a table with the pick rate and win rate of each combination.

- Teams:
  - There is a graph showing the community structure obtained from the data. If a team is composed of the champions inside the same community (circle) they have a higher probability of winning according to statistics.

A live version (tested on Chrome and Firefox) can be found at

http://network-legends.herokuapp.com/

Due to heroku limits the web might be temporary disabled (unlikely) and you will see an error page. In that case please try again later. Some screen shots of the web page can be found inside screenshots folder.


##Methodology

We have used the set of Black Market Brawlers match IDs corresponding to EUW server.

**1.Champion graphs:** for each match we determine which champion (or champions in the case of bot lane) have won their lane using the following criteria:

  - 2 points are added to the champion who breaks the first tower in the game.
  - 1 point its added to those champions who have obtained at least 1.2 times the gold his counterpart has in the first 10 minutes.
  - 1 point its added to those champions who kill their counterpart before the first tower is broken.
  - 0.5 points are added to those champions who assist in killing their counterparts before the first tower is broken.

Once the first tower is broken we consider that the lane phase is over and compare the points of each pair. We consider that the one with more points has won the lane. If we repeat this process for all the matches we get the probability of winning each lane for each pair of champions. For the purpose of visualization only the most picked champions are shown.

The code is inside /codes/Champions/. For each lane first it is necessary to execute "link\_*lane*.R" and then "script\_champions_*lane*.R", although the raw data is missing (due to the rules of the contest) and it should be provided by the user.

**2.Champion tables:** essentially we have just calculated the win rate, pick rate and average KDA of the champions played in each lane. The most popular items of the black market for each champion are also shown.

The code is inside /codes/Champions/. Raw data should be provided.

**3.Brawlers graph:** first we record the combination of brawlers bought by each team and then we consider that the best one is the one of the winner team. Averaging over all matches we obtain the winning probability of each combination versus the rest.

The code is inside /codes/Brawlers/. First it is necessary to execute "script\_brawlers\_groups.R", then "links\_brawlers.R" and finally "script\_brawlers\_roulette.R".

**4.Brawlers table:** see 2.

**5.Teams graph:** in this last section we have created a network of champions and then we have measured its structure using modularity.

To create our network we have regarded each champion as a node of the network. Then, a link is added between two nodes if they have won a game while playing in the same team. After normalizing the weight of the links we have our network.

The next step is to calculate and maximize the modularity of our network. If we group the nodes in *communities* and calculate the fraction of links that fall within the given groups minus the expected such fraction if they were distributed at random we obtain the modularity of our network. Now, if we maximize this quantity by changing the community of each node we will obtain the community structure of our network. 

The nodes of each community will have more links between each other than with the rest of nodes. In our context this means that champions inside the same community have a higher probability of winning a match if they play together than if they play with champions from other communities. Another way of seeing this is that a team composed by members of the same community is more likely to win than one composed by champions of different communities. 

We have used Gephi's implementation of the algorithm suggested by Blondel et al. (*Fast unfolding of communities in large networks*) for this process.

##Tech

As physicists our knowledge of web development is quite limited so we have spent a lot of time in that aspect of the project. To build the web we have used:

- Heroku
- Bootstrap and the template created by [@mdo](https://twitter.com/mdo).
- D3.js
- Node.js
- Google Charts
- jQuery

While for the data obtaining and analysis we have used:

- Riot Games API
- Python
- R
- Gephi

##Disclaimer
The Network of Legends isn’t endorsed by Riot Games and doesn’t reflect the views or opinions of Riot Games or anyone officially involved in producing or managing League of Legends. League of Legends and Riot Games are trademarks or registered trademarks of Riot Games, Inc. League of Legends © Riot Games, Inc.



