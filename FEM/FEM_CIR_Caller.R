source('C:/Users/Glenwood/OneDrive/Desktop/Le Mans University/CIR.FEM.r')

CIR=matrix(nrow = 1001, ncol=5)

curr_t = c(1, 2, 3, 4)
CIR[1:1001,1] = CIR.FEM(0.5, c(0.03, 0.03, 0.02),curr_t[1])$x
for (i in 1:4){
  CIR[1:1001,i+1] = CIR.FEM(0.5, c(0.03, 0.03, 0.02),curr_t[i])$density
}


x=CIR[,1]
par(mfrow=c(2,2))
plot(x, CIR[,2], type="l",xlab = "x",ylab = "PDF", main = "PDF of the CIR process at t=1")
abline(v=0.5)
plot(x, CIR[,3], type="l",xlab = "x",ylab = "PDF", main = "PDF of the CIR process at t=2")
abline(v=0.5)
plot(x, CIR[,4], type="l",xlab = "x",ylab = "PDF", main = "PDF of the CIR process at t=3")
abline(v=0.5)
plot(x, CIR[,5], type="l",xlab = "x",ylab = "PDF", main = "PDF of the CIR process at t=4")
abline(v=0.5)
write.csv(data.frame(CIR),"CIR_FEM.csv")