#Cubic splines


require(graphics)

input <- function(inputfile) {
  parameters <<- read.table(inputfile, as.is=T);
  rownames(parameters) <<- parameters[,1]
  t1 <<- read.csv(toString(parameters["training",2]), sep = "\t", header = FALSE, nrow = 100)
  t2 <<- read.csv(toString(parameters["clinical",2]), sep="\t", header = TRUE) 
  #pc <<- read.csv(inputfile, header = TRUE);
}


run <- function() {
  t1 <<- as.data.frame(t(t1))
  colnames(t1)[1] <<- "CEL"
  x <<- merge(t1, t2, by = "CEL")
  subID <<- unique(x$SUBJECTID)
}

output <- function(outputfile) {
   for(y in subID){
    pat = x[x[,"SUBJECTID"]==y,]
    pat = pat[order(pat$TIMEHOURS),]
    v1 = as.vector(pat[,2])
    plot(as.vector(pat$TIMEHOURS), v1)
    v.spl = smooth.spline(pat$TIMEHOURS, v1)
    plot(v.spl$x, v.spl$y)
    write.table(v.spl$x, file = outputfile, sep = ",", append=TRUE, row.names = TRUE, col.names = TRUE)
    write.table(v.spl$y, file = outputfile, sep = ",", append=TRUE, row.names = TRUE, col.names = TRUE)
  }
}


#setwd("appData/Res_Challenge/Data")
#t1 = read.table("ViralChallenge_training_EXPRESSION_RMA.tsv", sep = "\t", header = FALSE, nrow = 100)
#t2 <- read.table("ViralChallenge_training_CLINICAL.tsv", sep="\t", header = TRUE)


# t1 = apply(t1, 1, as.vector)
# t2 = apply(t2, 1, as.vector)
#t1 = as.data.frame(t(t1))
#colnames(t1)[1] <- "CEL"
#x = merge(t1, t2, by = "CEL")
#subID = unique(x$SUBJECTID)

#for(y in subID){
#  pat = x[x[,"SUBJECTID"]==y,]
#  pat = pat[order(pat$TIMEHOURS),]
  # pat[23, 15] = 172
#  v1 = as.vector(pat[,2])
#  plot(as.vector(pat$TIMEHOURS), v1)
#  v.spl = smooth.spline(pat$TIMEHOURS, v1)
  # v.spl = apply(as.vector(pat$TIMEHOURS), 2, smooth.spline, x = as.vector(v1[,1]))
#  plot(v.spl$x, v.spl$y)
#  write.table(v.spl$x, file = "dataCheck.csv", sep = ",", append=TRUE, row.names = TRUE, col.names = TRUE)
#  write.table(v.spl$y, file = "dataCheck.csv", sep = ",", append=TRUE, row.names = TRUE, col.names = TRUE)
#}


