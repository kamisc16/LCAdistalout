####################################
#Input file for first step of two-step
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
      fileA=paste("'/Users/christinakamis/Documents/DukeSociology/Dissertation/")
      fileB=paste("SimulationStudy/SimulatedData/",data.cond,paste(".txt"),paste("'"),paste(";"), sep="")

      
      inputfile=paste("/Users/christinakamis/Documents/DukeSociology/Dissertation/SimulationStudy/Results/InputFiles/TwoStepinp/","inp-",data.cond,paste(".inp"), sep="")
      
      
      input=file(inputfile) 
      writeLines(c(
        paste("TITLE:'Two-step';"),
        paste("DATA:")  ,
        paste('file =',fileA, sep=" "),
        paste(fileB),
        
        paste("VARIABLE:"),
        paste("names are id distal I1 I2 I3 I4 trueclass;"),
        paste("missing are .;"),
        paste("usevariables are I1 I2 I3 I4;"),
        paste("categorical are I1 I2 I3 I4;"),
        paste("idvariable=id;"),
        paste("auxiliary = distal;"),
        paste("classes are c(3);"),
        
        
        paste("ANALYSIS:"),
        paste("type=mixture;"),
        paste("starts=0;"),
        paste("processor=4;"),
        paste("MODEL:"),
        paste("%OVERALL%"),
        paste("%c#1%"),
        paste("[I1$1-I4$1*1"),
        paste("%c#2%"),
        paste("[I1$1-I4$1*-1"),
        paste("%c#3%"),
        paste("[I1$1-I2$1*-1"),
        paste("[I3$1-I4$1*1")

      ), input)
      close(input)
      
    }}}    
