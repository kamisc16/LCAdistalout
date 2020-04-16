####################################
#Input file for first step of manual BCH
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
      fileA=paste("'/Users/christinakamis/Documents/DukeSociology/Dissertation")
      fileB=paste("/SimulationStudy/Results/Output/BCHoutMan/out-",data.cond,paste(".txt"),paste("'"),paste(";"), sep="")

      inputfile=paste("/Users/christinakamis/Documents/DukeSociology/Dissertation/SimulationStudy/Results/InputFiles/BCHinpMan/","inp-step3",data.cond,paste(".inp"), sep="")
      
      
      input=file(inputfile) 
      writeLines(c(
        paste("TITLE:'BCH-manual-step 3';"),
        paste("DATA:")  ,
        paste('file =',fileA, sep=" "),
        paste(fileB),
        
        paste("VARIABLE:"),
        paste("names are  I1 I2 I3 I4 distal BCHW1 BCHW2 BCHW3 id;"),
        paste("missing are .;"),
        paste("usevariables are BCHW1-BCHW3 distal;"),
        paste("training = BCHW1-BCHW3 (bch);"),
        paste("idvariable=id;"),
        paste("classes are c(3);"),
        
        
        paste("ANALYSIS:"),
        paste("type=mixture;"),
        paste("starts=100 50;"),
        paste("processor=4;"),
        paste("MODEL:"),
        paste("%OVERALL%")
      ), input)
      close(input)
      
 }}}



