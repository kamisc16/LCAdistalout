####################################
#Input file for second step of Two Step
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
      datafile=paste("/Users/christinakamis/Documents/DukeSociology/Dissertation/SimulationStudy/Results/InputFiles/TwoStepinp/inp-",data.cond,paste(".out"), sep="")
      fileA=paste("'/Users/christinakamis/Documents/DukeSociology/Dissertation")
      fileB=paste("/SimulationStudy/Results/Output/TwoStepout/out-",data.cond,paste(".txt"),paste("'"),paste(";"), sep="")
      
####################################
#reading in logit information from output 
Results=readModels(datafile)
param=Results$parameters$unstandardized
      
####################################

inputfile=paste("/Users/christinakamis/Documents/DukeSociology/Dissertation/SimulationStudy/Results/InputFiles/TwoStepinp/Step2/","inp-step2-",data.cond,paste(".inp"), sep="")


input=file(inputfile) 
writeLines(c(
  paste("TITLE:'Two-Step(2)';"),
  paste("DATA:")  ,
  paste('file =',fileA, sep=" "),
  paste(fileB),
  paste("VARIABLE:"),
  paste("names are id distal I1 I2 I3 I4 trueclass;"),
  paste("missing are .;"),
  paste("usevariables are I1 I2 I3 I4 distal ;"),
  paste("categorical are I1 I2 I3 I4;"),
  paste("classes are c(3);"),
  
  
  paste("ANALYSIS:"),
  paste("type=mixture;"),
  paste("starts=0;"),
  paste("processor=4;"),
  paste("MODEL:"),
  paste("%OVERALL%"),
  paste("[c#1@",param[13,3],"];", sep=""),
  paste("[c#2@",param[14,3],"];", sep=""),
  paste("%c#1%"),
  paste("[i1$1@",param[1,3],"];", sep=""),
  paste("[i2$1@",param[2,3],"];", sep=""),
  paste("[i3$1@",param[3,3],"];", sep=""),
  paste("[i4$1@",param[4,3],"];", sep=""),
  
  paste("%c#2%"),
  paste("[i1$1@",param[5,3],"];", sep=""),
  paste("[i2$1@",param[6,3],"];", sep=""),
  paste("[i3$1@",param[7,3],"];", sep=""),
  paste("[i4$1@",param[8,3],"];", sep=""),
  
  paste("%c#3%"),
  paste("[i1$1@",param[9,3],"];", sep=""),
  paste("[i2$1@",param[10,3],"];", sep=""),
  paste("[i3$1@",param[11,3],"];", sep=""),
  paste("[i4$1@",param[12,3],"];", sep="")
  
  

), input)
close(input)


    }}}
      