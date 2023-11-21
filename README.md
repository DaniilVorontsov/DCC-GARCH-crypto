The course project as part of first year at MSc Stochastic Modeling in Economics and Finance in HSE university, Russia.

The study examined the largest cryptocurrencies by market capitalization as of February 2023, as well as uncertainty indices in the crypto markets (UCRY). As shown, the major cryptocurrencies exhibited significant dynamic correlations throughout the entire period under consideration. The calculated hedging coefficient for Bitcoin with altcoins was lower during the post '24-02-2022' period than in the 'pandemic' and preceding periods, indicating that the relationship between Bitcoin and major altcoins is not constant and diminishes over time.

The constructed VAR regression showed that discussing regulatory issues of cryptocurrencies in the news has a positive impact on the price, while discussing prices has a negative impact. This phenomenon can be explained by the fact that discussing the legislative status of cryptocurrencies enhances their legitimacy in the eyes of investors, leading to price increases. News of evaluative nature regarding the value of cryptocurrencies scares investors, leading to price declines.

The full report attached and available in Russian. The order of running files is following:

1) Binance currencies.ipynb //data downloading from binance
2) descriptive stats.ipynb //desriptive statistics for downloaded dataset
3) DCC Model.ipynb //DCC GARCH implementation in python notebook
 
4) DCC GARCH //implementation of DCC GARCH from rmgarch
5) VAR and TVP VAR.R //connectedness approach, author:
Antonakakis, N., Chatziantoniou, I., & Gabauer, D. (2020). Refined measures of dynamic connectedness based on time-varying parameter vector autoregressions. Journal of Risk and Financial Management, 13(4), 84.

6) preprocessing and VAR.ipynb //
7) connectedness plots.ipynb //visualized results of network analysis
