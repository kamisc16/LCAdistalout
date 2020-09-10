####################################
#Gathering and storing results from simulation study 
####################################
#Using MplusAutomation I can run a batch of input files all at once 
require(MplusAutomation)
####################################

#function source() runs R script that creates input files based off of conditions of data 
#function runModels() runs through all input files in a subdirectory one by one. 
#Specifying no log file to be created 


#One Step
source("/Users/christinakamis/Documents/DukeSociology/Dissertation/SimulationStudy/InputFileGenerate/OneStepinp.R")
runModels("/Users/christinakamis/Documents/DukeSociology/Dissertation/SimulationStudy/Results/InputFiles/OneStepinp/", 
          recursive=T, logFile=NULL)

#Three Step (Step 1 & 3)
source("/Users/christinakamis/Documents/DukeSociology/Dissertation/SimulationStudy/InputFileGenerate/ThreeStepinp1.R")
source("/Users/christinakamis/Documents/DukeSociology/Dissertation/SimulationStudy/InputFileGenerate/ThreeStepinp3.R")
runModels("/Users/christinakamis/Documents/DukeSociology/Dissertation/SimulationStudy/Results/InputFiles/3Stepinp/", 
          recursive=T, logFile=NULL)

#ML manual (Step 1)
#To do this we have to run the first batch of step-one files 
source("/Users/christinakamis/Documents/DukeSociology/Dissertation/SimulationStudy/InputFileGenerate/MLinp_manual.R")
runModels("/Users/christinakamis/Documents/DukeSociology/Dissertation/SimulationStudy/Results/InputFiles/MLinpMan/", 
          recursive=T, logFile=NULL)

#ML manual (Step 3)
#first run R-script to get batch of new input files 
source("/Users/christinakamis/Documents/DukeSociology/Dissertation/SimulationStudy/InputFileGenerate/MLinp_manual_step3.R")
runModels("/Users/christinakamis/Documents/DukeSociology/Dissertation/SimulationStudy/Results/InputFiles/MLinpMan/Step3/", 
          recursive=T, logFile=NULL)

#BCH manual (Step 1 & 3)
source("/Users/christinakamis/Documents/DukeSociology/Dissertation/SimulationStudy/InputFileGenerate/BCHinp_manual.R")
source("/Users/christinakamis/Documents/DukeSociology/Dissertation/SimulationStudy/InputFileGenerate/BCHinp_manual_step3.R")
runModels("/Users/christinakamis/Documents/DukeSociology/Dissertation/SimulationStudy/Results/InputFiles/BCHinpMan/", 
          recursive=T, logFile=NULL)

#Two Step (Step 1)
source("/Users/christinakamis/Documents/DukeSociology/Dissertation/SimulationStudy/InputFileGenerate/TwoStepinp1.R")
runModels("/Users/christinakamis/Documents/DukeSociology/Dissertation/SimulationStudy/Results/InputFiles/TwoStepinp/", 
          recursive=T, logFile=NULL)

#Two Step (Step 2)
source("/Users/christinakamis/Documents/DukeSociology/Dissertation/SimulationStudy/InputFileGenerate/TwoStepinp2.R")
runModels("/Users/christinakamis/Documents/DukeSociology/Dissertation/SimulationStudy/Results/InputFiles/TwoStepinp/Step2/", 
          recursive=T, logFile=NULL)

source("/Users/christinakamis/Documents/DukeSociology/Dissertation/SimulationStudy/InputFileGenerate/TwoStepinp2B.R")
runModels("/Users/christinakamis/Documents/DukeSociology/Dissertation/SimulationStudy/Results/InputFiles/TwoStepinp/Step2B/", 
          recursive=T, logFile=NULL)
####################################

#now I can read all of those output files using the same MplusAutomation package
#outputs are stored in the same file that inputs were stored in**

#OneStep
numsim=100


for(class.size in c("equal","Sunequal","unequal")) {
  for(class.sep in c("low")){
    Distalmeans=matrix(NA,numsim,5)   
      for(n in 1:numsim){
        data.cond <- paste(paste("sim-data",
                                 class.size,
                                 class.sep,
                                 n,
                                 sep="-"),sep="")  
  
           
Output=paste("/Users/christinakamis/Documents/DukeSociology/Dissertation/SimulationStudy/Results/InputFiles/OneStepinp/inp-",data.cond,paste(".out"), sep="")

#This is reading in the results
Results=readModels(Output)

#Pulling out the parameters (unstandardized)
Parameters=Results$parameters$unstandardized
#storing the distal means in a matrix
Distalmeans[n,1]=Parameters[1,3]
Distalmeans[n,2]=Parameters[7,3]
Distalmeans[n,3]=Parameters[13,3]
Distalmeans[n,4]=Parameters[6,3]
Distalmeans[n,5]=data.cond


#outfiling the distal means matrix once all replications are stored 
if(n==numsim){
  
Filename=paste("/Users/christinakamis/Documents/DukeSociology/Dissertation/SimulationStudy/Results/Full_Results/OneStep/",data.cond,paste(".txt"), sep="")
write.table(Distalmeans, Filename)
}
      }}}

####################################
#Three Step 

for(class.size in c("equal","Sunequal","unequal")) {
  for(class.sep in c("low","medium","high")){
    Distalmeans=matrix(NA,numsim,5)   
    for(n in 1:numsim){
      data.cond <- paste(paste("sim-data",
                               class.size,
                               class.sep,
                               n,
                               sep="-"),sep="")  
      
      
      Output=paste("/Users/christinakamis/Documents/DukeSociology/Dissertation/SimulationStudy/Results/InputFiles/3stepinp/inp-step3-",data.cond,paste(".out"), sep="")
      
      #This is reading in the results
      Results=readModels(Output)
      
      #Pulling out the parameters (unstandardized)
      Parameters=Results$parameters$unstandardized
      #storing the distal means in a matrix
      Distalmeans[n,1]=Parameters[1,3]+Parameters[3,3]
      Distalmeans[n,2]=Parameters[2,3]+Parameters[3,3]
      Distalmeans[n,3]=Parameters[3,3]
      Distalmeans[n,4]=Parameters[4,3]
      Distalmeans[n,5]=data.cond
      
      
      #outfiling the distal means matrix once all replications are stored 
      if(n==numsim){
        
        Filename=paste("/Users/christinakamis/Documents/DukeSociology/Dissertation/SimulationStudy/Results/Full_Results/3Step/",data.cond,paste(".txt"), sep="")
        write.table(Distalmeans, Filename)
      }
    }}}

####################################
#ML (manual)
numsim=10
for(class.size in c("equal","Sunequal","unequal")) {
  for(class.sep in c("low","medium","high")){
    Distalmeans=matrix(NA,numsim,5)   
    for(n in 1:numsim){
      data.cond <- paste(paste("sim-data",
                               class.size,
                               class.sep,
                               n,
                               sep="-"),sep="")  
      
      
      Output=paste("/Users/christinakamis/Documents/DukeSociology/Dissertation/SimulationStudy/Results/InputFiles/MLinpMan/Step3/inp-step3-",data.cond,paste(".out"), sep="")
      
      #This is reading in the results
      Results=readModels(Output)


#Pulling out the parameters (unstandardized)
Parameters=Results$parameters$unstandardized
if(!is.null(Parameters)){
#storing the distal means in a matrix
Distalmeans[n,1]=Parameters[1,3]
Distalmeans[n,2]=Parameters[5,3]
Distalmeans[n,3]=Parameters[9,3]
Distalmeans[n,4]=Parameters[4,3]
Distalmeans[n,5]=data.cond
}

#outfiling the distal means matrix once all replications are stored 
if(n==numsim){
  
  Filename=paste("/Users/christinakamis/Documents/DukeSociology/Dissertation/SimulationStudy/Results/Full_Results/MLman/",data.cond,paste(".txt"), sep="")
  write.table(Distalmeans, Filename)
}
    }}}


####################################
#BCH manual

for(class.size in c("equal","Sunequal","unequal")) {
  for(class.sep in c("low","medium","high")){
    Distalmeans=matrix(NA,numsim,5)   
    for(n in 1:numsim){
      data.cond <- paste(paste("sim-data",
                               class.size,
                               class.sep,
                               n,
                               sep="-"),sep="")  
      
      
      Output=paste("/Users/christinakamis/Documents/DukeSociology/Dissertation/SimulationStudy/Results/InputFiles/BCHinpMan/inp-step3",data.cond,paste(".out"), sep="")
      
      #This is reading in the results
      Results=readModels(Output)
   
    

#Pulling out the parameters (unstandardized)
Parameters=Results$parameters$unstandardized
if(!is.null(Parameters)){
  #storing the distal means in a matrix
  Distalmeans[n,1]=Parameters[1,3]
  Distalmeans[n,2]=Parameters[3,3]
  Distalmeans[n,3]=Parameters[5,3]
  Distalmeans[n,4]=Parameters[4,3]
  Distalmeans[n,5]=data.cond
}

#outfiling the distal means matrix once all replications are stored 
if(n==numsim){
  
  Filename=paste("/Users/christinakamis/Documents/DukeSociology/Dissertation/SimulationStudy/Results/Full_Results/BCHman/",data.cond,paste(".txt"), sep="")
  write.table(Distalmeans, Filename)
}
    }}}


####################################
#Two Step

for(class.size in c("equal","Sunequal","unequal")) {
  for(class.sep in c("low","medium","high")){
    Distalmeans=matrix(NA,numsim,5)   
    for(n in 1:numsim){
      
class.size="equal"
class.sep="high"
n=1
      data.cond <- paste(paste("sim-data",
                               class.size,
                               class.sep,
                               n,
                               sep="-"),sep="")  
      
      Output1=paste("/Users/christinakamis/Documents/DukeSociology/Dissertation/SimulationStudy/Results/InputFiles/TwoStepinp/inp-",data.cond,paste(".out"), sep="")
      Output2=paste("/Users/christinakamis/Documents/DukeSociology/Dissertation/SimulationStudy/Results/InputFiles/TwoStepinp/Step2/inp-step2-",data.cond,paste(".out"), sep="")
      Output2b=paste("/Users/christinakamis/Documents/DukeSociology/Dissertation/SimulationStudy/Results/InputFiles/TwoStepinp/Step2B/inp-step2-",data.cond,paste(".out"), sep="")
      
      #This is reading in the results
      Results1=readModels(Output1)
      Results2=readModels(Output2)
      Results2B=readModels(Output2b)
      
#Pulling out the parameters (unstandardized)
Parameters1=Results1$parameters$unstandardized 
Parameters2=Results2$parameters$unstandardized  
Parameters2B=Results2B$parameters$unstandardized  

sigma11=as.matrix(Parameters1[,4]) ## SE estimates from step 1
I22=as.matrix(c(Parameters2B[1,3],Parameters2B[7,3],Parameters2B[13,3]))
