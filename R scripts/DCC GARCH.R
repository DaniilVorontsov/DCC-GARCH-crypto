library("rmgarch")
library('dplyr')
library("GGally")
library("psych")
library("ConnectednessApproach")
library('zoo')
library('xts')
library('ggplot2')

#short interval
t<-read.csv('all_coins_short.csv',header = TRUE)
head(t)

idx<-as.Date(t$date_hour)
zoo_t <- zoo(t %>% select(2:9), order.by = idx )

#DCC GARCH
uspec = ugarchspec(mean.model = list(armaOrder = c(0,0)),
                   variance.model = list(garchOrder = c(1,1),
                                         model = "sGARCH",
                                         variance.targeting=FALSE),
                   distribution.model = "norm")

spec = cgarchspec(uspec = multispec( replicate(8, uspec) ),
                   asymmetric = TRUE,
                   distribution.model = list(copula = "mvnorm",
                                             method = "Kendall",
                                             time.varying = TRUE,
                                             transformation = "parametric"))


fit = cgarchfit(spec, 
                 data = t %>% select(2:9),
                 cluster = NULL, 
                 solver.control=list(trace=1))



#long interval
t<-read.csv('all_coins_long.csv',header = TRUE)
head(t)
#DCC GARCH
uspec = ugarchspec(mean.model = list(armaOrder = c(0,0)), 
                   variance.model = list(garchOrder = c(1,1), 
                   model = "sGARCH"), distribution.model = "norm")
spec = dccspec(uspec = multispec( replicate(8, uspec)), 
               dccOrder = c(1,1), distribution = "mvnorm")
fit_dcc = dccfit(spec = spec, data = t %>% select(2:5), 
                 out.sample = 100, fit.control = list(eval.se=T))
print(fit_dcc)


uspec1 = ugarchspec(mean.model = list(armaOrder = c(1,0)), variance.model = list(model = "apARCH"), 
                    distribution.model = "norm")
uspec2 = ugarchspec(mean.model = list(armaOrder = c(2,0)), variance.model = list(model = "gjrGARCH"), 
                    distribution.model = "norm")
uspec3 = ugarchspec(mean.model = list(armaOrder = c(0,0)), variance.model = list(model = "sGARCH"), 
                    distribution.model = "norm")
uspec4 = ugarchspec(mean.model = list(armaOrder = c(1,0)), variance.model = list(model = "sGARCH",
                                                                                 garchOrder = c(2, 1)), 
                    distribution.model = "norm")
uspec = c( uspec1, uspec2, uspec3, uspec4 )
spec = dccspec(uspec = multispec( uspec ), dccOrder = c(1,1), distribution = "mvlaplace")

fit = dccfit(data = t %>% select(2:5), spec = spec, out.sample = 100, solver = "solnp", 
             fit.control = list(scale = TRUE, eval.se = TRUE))
print(fit)


glimpse(fit_dcc@mfit$R)

for(i in 1:1206) {
  fit_dcc@mfit$R[[i]][,1]
}

fit_dcc@mfit$R[[1]][,1]

library(zoo)
library(rugarch)
library(rmgarch)


# DCC timecopula MVN

uspec = ugarchspec(mean.model = list(armaOrder = c(0,0)),
                   variance.model = list(garchOrder = c(1,1),
                   model = "sGARCH", 
                   variance.targeting=FALSE), 
                   distribution.model = "norm")

spec1 = cgarchspec(uspec = multispec( replicate(3, uspec) ),
                   asymmetric = TRUE,
                   distribution.model = list(copula = "mvnorm",
                                             method = "Kendall",
                                             time.varying = TRUE,
                                             transformation = "parametric"))

fit1 = cgarchfit(spec1, 
                 data = EuStockRet, 
                 cluster = NULL, 
                 solver.control=list(trace=1))

fit.copula = cgarchfit(spec1, 
                         data = EuStockRet, 
                         out.sample = 120, 
                         solver = "solnp",
                         solver.control =list(),
                         fit.control = list(eval.se = TRUE, 
                                            stationarity = TRUE, 
                                            scale = FALSE),
                         cluster = NULL,
                         fit =NULL,
                         VAR.fit = NULL)


