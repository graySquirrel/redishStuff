## event simulator


stock <- 100
numIters <- 1000
lossprob <- 0.1
numlost <- stock * lossprob
print(paste("number lost per iteration",numlost))
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

print(mean(dfUsing$numUses))
print(median(dfUsing$numUses))

