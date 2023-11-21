library("rmgarch")
library('dplyr')
library("GGally")
library("psych")
library("ConnectednessApproach")
library('zoo')
library('xts')
#library('vars')

#short timeframe weekly
weekly_short<-read.csv('weekly_short.csv',header = TRUE)
weekly_idx<-as.Date(weekly_short$date)
zoo_weekly_short <- zoo(weekly_short %>% dplyr::select(2:9), order.by = weekly_idx )

dca_weekly_short = ConnectednessApproach(diff(zoo_weekly_short), 
                            nlag=1, 
                            nfore=12,
                            model="TVP-VAR",
                            connectedness="Time",
                            VAR_config=list(TVPVAR=list(kappa1=0.99, kappa2=0.96,
                            prior="MinnesotaPrior", gamma=0.1)))

write.csv(dca_weekly_short$TABLE,file = 'dca_weekly_short.csv')

write.csv(dca_weekly_short$TCI,file = 'TCI_weekly_short.csv')
#write.csv(dca_weekly_short$TCI,file = 'TCI_weekly_short_no_UCRY.csv')




#long timeframe weekly
weekly_long<-read.csv('weekly_long.csv',header = TRUE)
weekly_idx<-as.Date(weekly_long$date)
zoo_weekly_long <- zoo(weekly_long %>% dplyr::select(2:7), order.by = weekly_idx )

dca_weekly_long = ConnectednessApproach(diff(zoo_weekly_long), 
                                         nlag=1, 
                                         nfore=12,
                                         model="TVP-VAR",
                                         connectedness="Time",
                                         VAR_config=list(TVPVAR=list(kappa1=0.99, kappa2=0.96,
                                                                     prior="MinnesotaPrior", gamma=0.1)))
dca_weekly_long$TABLE

write.csv(dca_weekly_long$TABLE,file = 'dca_weekly_long.csv')


crypto_ucry = AggregatedConnectedness(dca_weekly_short, 
                                      groups=list("Crypto"=c(1:4),"UCRY"=c(5,6)))

write.csv(crypto_ucry$TABLE,file = 'dca_UCRY_weekly_long.csv')





#short timeframe monthly
monthly_short<-read.csv('monthly_short.csv',header = TRUE)
monthly_short_idx<-as.Date(monthly_short$X)
zoo_monthly_short <- zoo(monthly_short %>% dplyr::select(2:11), order.by = monthly_short_idx )
dca_monthly_short = ConnectednessApproach(diff(zoo_monthly_short), 
                                        nlag=1, 
                                        nfore=12,
                                        model="TVP-VAR",
                                        connectedness="Time",
                                        VAR_config=list(TVPVAR=list(kappa1=0.99, kappa2=0.96,
                                        prior="MinnesotaPrior", gamma=0.1)))
dca_monthly_short$TABLE
write.csv(dca_monthly_short$TABLE,file = 'dca_monthly_short.csv')
write.csv(dca_monthly_short$TCI,file = 'TCI_monthly_short.csv')


#long timeframe monthly
monthly_long<-read.csv('monthly_long.csv',header = TRUE)
monthly_long_idx<-as.Date(monthly_long$X)
zoo_monthly_long <- zoo(monthly_long %>% dplyr::select(2:7), order.by = monthly_long_idx )
dca_monthly_long = ConnectednessApproach(diff(zoo_monthly_long), 
                                          nlag=1, 
                                          nfore=12,
                                          model="TVP-VAR",
                                          connectedness="Time",
                                          VAR_config=list(TVPVAR=list(kappa1=0.99, kappa2=0.96,
                                                                      prior="MinnesotaPrior", gamma=0.1)))
dca_monthly_long$TABLE
write.csv(dca_monthly_long$TABLE,file = 'dca_monthly_long.csv')


#short time daily
daily_short<-read.csv('UCRY_daily_short.csv',header = TRUE)
daily_short_idx<-as.Date(daily_short$date)
zoo_daily_short <- zoo(daily_short %>% dplyr::select(2:11), order.by = daily_short_idx )
dca_daily_short = ConnectednessApproach(diff(zoo_daily_short), 
                                         nlag=1, 
                                         nfore=12,
                                         model="TVP-VAR",
                                         connectedness="Time",
                                         VAR_config=list(TVPVAR=list(kappa1=0.99, kappa2=0.96,
                                                                     prior="MinnesotaPrior", gamma=0.1)))
dca_daily_short$TABLE
write.csv(dca_daily_short$TABLE,file = 'dca_daily_short.csv')
write.csv(dca_daily_short$TCI,file = 'TCI_daily_short.csv')

