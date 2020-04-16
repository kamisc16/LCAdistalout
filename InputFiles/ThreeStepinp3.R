####################################
#Input file for third step of Three Step
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
        fileB=paste("/SimulationStudy/Results/Output/3Stepout/","out-",data.cond,paste(".txt"),paste("'"),paste(";"), sep="")

        
        inputfile=paste("/Users/christinakamis/Documents/DukeSociology/Dissertation/SimulationStudy/Results/InputFiles/3Stepinp/","inp-step3-",data.cond,paste(".inp"), sep="")
        
        
        input=file(inputfile) 
        writeLines(c(
          paste("TITLE:'Three-Step-step 3';"),
          paste("DATA:")  ,
          paste('file =',fileA, sep=" "),
          paste(fileB),
          paste("VARIABLE:"),
          paste("names are  I1 I2 I3 I4 distal cprob1"),
          paste("cprob2 cprob3 cmod id;"),
          paste("idvariable=id;"),
          paste("missing are .;"),
          paste("usevariables are distal class1 class2 ;"),
          paste("DEFINE:"),
          paste("class1=0;class2=0;class3=0;"),
          paste("if(cmod eq 1) then class1=1;"),
          paste("if(cmod eq 2) then class2=1;"),
          paste("if(cmod eq 3) then class3=1;"),
          
          paste("ANALYSIS:"),
    
          paste("MODEL:"),
          paste("distal on class1 class2")

        ), input)
        close(input)
        
}}}


