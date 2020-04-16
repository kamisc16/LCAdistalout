####################################
#Input file for third step of manual ML 
####################################

numsim=10


for(class.size in c("equal","Sunequal","unequal")) {
  for(class.sep in c("low","medium","high")){
    for(n in 1:numsim){
      
      data.cond <- paste(paste("sim-data",
                               class.size,
                               class.sep,
                               n,
                               sep="-"),sep="") 
      datafile=paste("/Users/christinakamis/Documents/DukeSociology/Dissertation/SimulationStudy/Results/InputFiles/MLinpMan/inp-",data.cond,paste(".out"), sep="")
      fileA=paste("'/Users/christinakamis/Documents/DukeSociology/Dissertation")
      fileB=paste("/SimulationStudy/Results/Output/MLoutMan/out-",data.cond,paste(".txt"),paste("'"),paste(";"), sep="")



####################################
#reading in logit information from output 
Results=readModels(datafile)
logits=Results$class_counts$logitProbs.mostLikely

####################################

inputfile=paste("/Users/christinakamis/Documents/DukeSociology/Dissertation/SimulationStudy/Results/InputFiles/MLinpMan/Step3/","inp-step3-",data.cond,paste(".inp"), sep="")

input=file(inputfile) 
writeLines(c(
  paste("TITLE:'ML-manual-step3';"),
  paste("DATA:")  ,
  paste('file =',fileA, sep=" "),
  paste(fileB),
  
  paste("VARIABLE:"),
  paste("names are I1 I2 I3 I4 distal cprob1 cprob2 cprob3 cmod id;"),
  paste("missing are .;"),
  paste("usevariables are cmod distal;"),
  paste("nominal=cmod;"),
  paste("idvariable=id;"),
  paste("classes are c(3);"),
  
  paste("ANALYSIS:"),
  paste("type=mixture;"),
  paste("starts=100 50;"),
  paste("processor=4;"),
  paste("MODEL:"),
  paste("%OVERALL%"),
  paste("%c#1%"),
  paste("[cmod#1@", logits[1,1],paste(""), paste("cmod#2@"),logits[1,2],paste("];")),
  paste("%c#2%"),
  paste("[cmod#1@", logits[2,1],paste(""), paste("cmod#2@"),logits[2,2],paste("];")),
  paste("%c#3%"),
  paste("[cmod#1@", logits[3,1],paste(""), paste("cmod#2@"),logits[3,2],paste("];"))

), input)
close(input)

    }}}    


