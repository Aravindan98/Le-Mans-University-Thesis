#################################################################
#######    Risk Analysis for Wind Turbine Toolkit        ########
#################################################################

## FEM.mean.R  (2014-2020)
##
## Copyright 2014-2020 Alexandre Brouste 

##    INPUT VARIABLES
#################################################################
##  x    : 
## theta :
## Delta :
#################################################################


##    OUTPUT VARIABLES
#################################################################
##  forecast
#################################################################

# parameters = (kappa,theta,sigma) --> theta[1,2,3] respectively

af<-function(x,theta){return(theta[1]*x)}

bf<-function(x,theta){return((theta[2]*x)^2)}

bfprime<-function(x,theta){return(2*theta[2]^2*x)}

GBM.FEM<-function(x0,theta,DeltaTime,param=list(Minf=0,Msup=10,N=200),R=10){
  
  Minf<-param$Minf
  Msup<-param$Msup
  N<-param$N
  
  space<-seq(Minf,Msup,length=N+1)
  Delta<-(Msup-Minf)/N
  
  # Elements finis
  
  phi<-function(x,n){
    (1-1/Delta*abs(x-space[n+1]))*(x>space[n])*(x<space[n+2])
  }
  
  # Matrice C
  
  res1th<-2/3*Delta
  res2th<-Delta/6
  
  ##- Fill the matrix C
  
  C<-diag(rep(res1th,N-1))
  C[1,2]<-res2th
  
  for (i in 1:(N-2)){
    C[i,i+1]<-res2th
    C[i+1,i]<-res2th
  }
  
  # Matrice K
  
  phiprime<-function(x,n){
    ((x<space[n+1])*(x>space[n]) - (x>space[n+1])*(x<space[n+2]))/Delta
  }
  
  
  ## fill matrix K
  
  K<-C
  
  for (i in 2:(N-2)){
    
    
    j<-0
    functmp<-function(x){ (af(x,theta)-1/2*bfprime(x,theta))*phiprime(x,i)*phi(x,i+j) -1/2*bf(x,theta)*phiprime(x,i)*phiprime(x,i+j)}
    K[i,i]<-integrate(functmp,space[i],space[i+2],stop.on.error = FALSE)$value
    
    j<-1
    functmp<-function(x){ (af(x,theta)-1/2*bfprime(x,theta))*phiprime(x,i)*phi(x,i+j) -1/2*bf(x,theta)*phiprime(x,i)*phiprime(x,i+j)}
    K[i,i+1]<-integrate(functmp,space[i+1],space[i+2],stop.on.error = FALSE)$value
    
    j<--1
    functmp<-function(x){ (af(x,theta)-1/2*bfprime(x,theta))*phiprime(x,i)*phi(x,i+j) -1/2*bf(x,theta)*phiprime(x,i)*phiprime(x,i+j)}
    K[i,i-1]<-integrate(functmp,space[i],space[i+1],stop.on.error = FALSE)$value	
  }
  
  #i==1
  i<-1;
  
  j<-0
  functmp<-function(x){ (af(x,theta)-1/2*bfprime(x,theta))*phiprime(x,i)*phi(x,i+j) -1/2*bf(x,theta)*phiprime(x,i)*phiprime(x,i+j) }
  K[1,1]<-integrate(functmp,space[1],space[3],stop.on.error = FALSE)$value
  
  j<-1
  functmp<-function(x){ (af(x,theta)-1/2*bfprime(x,theta))*phiprime(x,i)*phi(x,i+j) -1/2*bf(x,theta)*phiprime(x,i)*phiprime(x,i+j) }
  K[1,2]<-integrate(functmp,space[2],space[3],stop.on.error = FALSE)$value
  
  #i==N-1
  
  i<-N-1;
  
  j<-0
  functmp<-function(x){ (af(x,theta)-1/2*bfprime(x,theta))*phiprime(x,i)*phi(x,i+j) -1/2*bf(x,theta)*phiprime(x,i)*phiprime(x,i+j) }
  K[N-1,N-1]<-integrate(functmp,space[N-1],space[N+1],stop.on.error = FALSE)$value
  
  j<--1
  functmp<-function(x){ (af(x,theta)-1/2*bfprime(x,theta))*phiprime(x,i)*phi(x,i+j) -1/2*bf(x,theta)*phiprime(x,i)*phiprime(x,i+j) }
  K[N-1,N-2]<-integrate(functmp,space[N-1],space[N],stop.on.error = FALSE)$value
  
  
  
  # Resolution du schema numerique
  
  T<-DeltaTime
  
  Deltat<-T/R
  lambda<-matrix(0,N-1,R+1)
  
  ##### Condition initiale
  psi<-0
  
  for (i in 1:(N-1)){
    psi[i]<-phi(x0,i) 
  }
  
  lambda[1:(N-1),1]<-solve(C)%*%psi
  
  
  
  for (ti in 2:(R+1)){
    
    ### Schéma implicite
    lambda[,ti]<-1/Deltat*solve(C/Deltat-K)%*%C%*%lambda[,ti-1,drop=FALSE]
    
  }
  
  densf<-function(x,R){
    S<-0
    
    for (i in 1:(N-1)){
      S<-S+lambda[i,R]*phi(x,i)
    }
    
    return(S)
  }
  
  x<-seq(Minf,Msup,length=1001)
  EW<-sum(x*densf(x,R+1))*(Msup-Minf)/1000
  
  return(list(m=EW,density=densf(x,R+1),x=x))
}
