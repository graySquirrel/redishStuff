## event simulator
## simulate number of uses for some amount of stock with a fixed probability
## of loss at every iteration (every 'use' of the container.)
## corroborates the theoretical reuse using geom dist.

stock <- 100
numIters <- 1000
lossprob <- 0.05
numlost <- stock * lossprob
#print(paste("number lost per iteration",numlost))
if (numlost < 1) {
  print(paste("increase number of iterations"))
  stop()
}

dfUsing <- data.frame(numUses = rep(1,stock))
dfLost <- data.frame(numUses = c())
for (i in 1:numIters) {
  #print(paste("iter",i))
  lostones <- sample(1:stock,numlost)
  dfLost <- rbind(dfLost,data.frame(numUses=dfUsing[lostones,]))
  # initialize the lost ones to 1 (the restock event)
  dfUsing[lostones,"numUses"] <- 0
  # increment all uses
  dfUsing$numUses <- dfUsing$numUses + 1
}

print(paste("loss probability",lossprob))
print(paste("mean number uses",mean(dfUsing$numUses)))
print(paste("median number uses",median(dfUsing$numUses)))

hist(c(dfLost$numUses,dfUsing$numUses), breaks = 40, main = "Histogram of number of uses for all stock lost and current at 5% loss rate",xlab = "Number of uses")