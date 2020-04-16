#03/17/2020
################################
#LCA simulation design
#inspired from Dziak files--if I need to look back at those
#avail on github
################################
#3 classes; 4 binary indicators 
#continuous distal outcome
#consistent effect size (1,0,-1)
################################
##things that change:
#equal/slightly unequal/unequal membership
#low, medium, high class separation


#right now keeping it to those two things while getting simulation set up.
#will decide how to deviate further moving forward 

################################
#DEVIATIONS FOR STUDY CONDITIONS:
#not currently implemented (03/17/2020)!!

#if I want to do non-normality the following code would produce that dist. for 
#the distal outcomes:

# N <- 100000
# 
# components <- sample(1:3,prob=c(0.3,0.5,0.2),size=N,replace=TRUE)
# mus <- c(0,10,3)
# sds <- sqrt(c(1,1,0.1))
# 
# samples <- rnorm(n=N,mean=mus[components],sd=sds[components])

################################
################################
#load pacakages
require(mice)
require(MASS)
require(norm)
require(VIM)
################################
N=5000
#number of cases per data set
nsim=1
#number of simulations of each type of data set 

class.means=c(1,0,-1)
#fixed effect size. means are the mean on the distal outcome
class.sd=c(1,1,1)
#equal resid. variance across classes
a=c(1,1,0,1,1,1,1)
b=c(1,1,1,0,1,1,1)
c=c(1,1,1,1,0,1,1)
d=c(1,1,1,1,1,0,1)
pattern=rbind(a,b,c,d)
#missing data pattern possibilities 

################################
for(class.size in c("equal","Sunequal","unequal")) {
  for(class.sep in c("low","medium","high")){
      
      if(class.size=="equal"){
        sim.class.size=c(1/3,1/3,1/3)
      }
      if(class.size=="Sunequal"){
        sim.class.size=c(.2,.3,.5)
      }
      if(class.size=="unequal"){
        sim.class.size=c(.1,.3,.6)
      }
      
      if(class.sep=="low"){
        item.means=matrix(c(0.7,	0.7,	0.7,	0.7,
                            0.7,	0.7,	0.3,	0.3,
                            0.3,	0.3,	0.3,	0.3), nrow=4, byrow=F)
      }
      
      if(class.sep=="medium"){
        item.means=matrix(c(0.8,	0.8,	0.8,	0.8,
                            0.8,	0.8,	0.2	,0.2,
                            0.2,	0.2,	0.2,	0.2), nrow=4, byrow=F)
      }
      
      if(class.sep=="high"){
        item.means=matrix(c(0.9,	0.9	,0.9,	0.9,
                            0.9,	0.9	,0.1,	0.1,
                            0.1,	0.1	,0.1,	0.1), nrow=4, byrow=F)
      }
      

      
      true.dis.mean=sim.class.size%*%class.means
      #true mean based on proportions in each class
      ################################
      #creating data set 
      for (numsim in 1:nsim){
        id=1:N
        #giving each person an id number 1-N
        items=matrix(NA,nrow=N,ncol=4)
        #empty matrix of length N, with 4 columns for the 4 indicators
        distal=as.matrix(rep(NA,N))
        #empty vector of length N to store the distal means 
        classpull=rmultinom(N,1,prob=sim.class.size)
        #this produces a 3 by N matrix. There are 3 rows for the three possible
        #classes. Each column has only one "1" to represent the class they are in
        
        class=as.matrix(rep(NA,N))
        for (j in 1:N){
          for(i in 1:3){
            if (classpull[i,j]==1)
              class[j]=i
          }
        }
        
        #randomly assigning true class membership based on proportion in each class
        #object 'class' is a N length vector that includes the true class membership
        #for each person based on the random draw 
        
        for(n in 1:N){
          #looping over all individuals 
          for(i in 1:3){
            #three classes
            if(class[n,1]==i){
              for (j in 1:4){
                #four items
                items[n,j]=
                  rbinom(1,1,prob=item.means[j,i])
                #random drawl from bernoulli trial with p=item mean for 
                #that specific class and item
              }
              distal[n,]=round(rnorm(1,
                                     mean=class.means[i],
                                     sd=class.sd[i]),3)
              #random normal drawl from class specific mean and var=1
              #should be same draw across all sim conditions. 
              #rounding to the 3rd decimal place (may change) 
            }
            
          }
        }
        simdat = data.frame(cbind(id,distal,items,class))
        names(simdat)=c("id","distal","item1","item2","item3","item4","trueclass")
################################
        
        data.cond <- paste(paste("sim-data",
                                 class.size,
                                 class.sep,
                                 numsim,
                                 sep="-"),".txt",sep="")
        write.table(x=simdat,
                    quote=FALSE,
                    sep="\t",
                    col.names=FALSE,
                    row.names=FALSE, 
                    na =".",
                    file=paste("/Users/christinakamis/Documents/DukeSociology/Dissertation/SimulationStudy/SimulatedData/",data.cond, sep=""))
        
      }
    }
}

################################
#NOTE:
#this is the order of variables in all simulated data sets:
#"id","distal","item1","item2","item3","item4","trueclass"
################################

