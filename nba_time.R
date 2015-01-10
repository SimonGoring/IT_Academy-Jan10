nba <- read.csv(file = 'data/nba_1953_2015.csv')

nba$x3p[is.na(nba$x3p)] <- 0

points <- data.frame(ppg = (nba$x2p + nba$x3p)/nba$g,
                     rule = nba$season_end<1979,
                     year = nba$season_end)

boxplot(ppg ~ rule, data=points)

plot(ppg ~ year, data = points)
