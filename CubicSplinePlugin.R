#Cubic splines


require(graphics)

input <- function(inputfile) {
  parameters <<- read.table(inputfile, as.is=T);
  rownames(parameters) <<- parameters[,1]
  t1 <<- read.csv(toString(parameters["training",2]), sep = "\t", header = FALSE, nrow = 100)
  t2 <<- read.csv(toString(parameters["clinical",2]), sep="\t", header = TRUE) 
  joincol <<- toString(parameters["joinby", 2])
  id <<- toString(parameters["id", 2])
  xcoor <<- toString(parameters["x", 2])
}


run <- function() {
  t1 <<- as.data.frame(t(t1))
  colnames(t1)[1] <<- joincol
  x <<- merge(t1, t2, by = joincol)
  subID <<- unique(as.character(unlist(x[id])))
}

output <- function(outputfile) { 
   for(y in subID){
    pat = x[x[,id]==y,]
    pat = pat[order(as.numeric(unlist(pat[xcoor]))),]
    v1 = as.vector(pat[,2])
    plot(as.vector(as.numeric(unlist(pat[xcoor]))), v1)
    v.spl = smooth.spline(as.numeric(unlist(pat[xcoor])), v1)
    plot(v.spl$x, v.spl$y)
    write.table(v.spl$x, file = outputfile, sep = ",", append=TRUE, row.names = TRUE, col.names = TRUE)
    write.table(v.spl$y, file = outputfile, sep = ",", append=TRUE, row.names = TRUE, col.names = TRUE)
  }
}


