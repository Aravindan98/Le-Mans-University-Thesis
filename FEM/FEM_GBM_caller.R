source('C:/Users/Glenwood/OneDrive/Desktop/Le Mans University/GBM.FEM.r')

GBM=matrix(nrow = 1001, ncol=5)

curr_t = c(0.1, 0.3, 0.6, 1)
for (i in 1:4){
  GBM[1:1001,1] = GBM.FEM(1.5,c(0,1),curr_t[i])$x
  GBM[1:1001,i+1] = GBM.FEM(1.5,c(0,1),curr_t[i])$density
}
#OU_out = OU.FEM(1,c(0.5,0,2),0.1)

#GBM_out = GBM.FEM(1.5,c(0,1),0.7)
#CIR_out = CIR.FEM(0.5, c(0.03, 0.03, 0.02), 4)
x=GBM[,1]
par(mfrow=c(2,2))
plot(x, GBM[,2], type="l",xlab = "x",ylab = "PDF", main = "PDF of the GBM process at t=0.1")
plot(x, GBM[,3], type="l",xlab = "x",ylab = "PDF", main = "PDF of the GBM process at t=0.3")
plot(x, GBM[,4], type="l",xlab = "x",ylab = "PDF", main = "PDF of the GBM process at t=0.6")
plot(x, GBM[,5], type="l",xlab = "x",ylab = "PDF", main = "PDF of the GBM process at t=1")
write.csv(data.frame(GBM),"GBM_FEM.csv")