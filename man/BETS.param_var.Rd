% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/BETS.param_var.R
\name{BETS.param_var}
\alias{BETS.param_var}
\title{BETS.param_var}
\usage{
BETS.param_var(x , volume, conf.level )
}
\arguments{
\item{x}{a GARCH model}

\item{volume}{that will be invested}

\item{conf.level}{confidence level of the interval}
}
\description{
O Value at Risk (VaR) representa uma medida de perda potencial de um ativo
ou carteira de ativos sujeita a riscos de mercado como, por exemplo, 
flutuacoes de precos, de taxas de juros e de taxas de cambio. A metodologia
continua relevante no cenario financeiro, principalmente pela facil 
interpretacao do seu resultado e pela nao dependencia de uma distribuicao 
especifica para sua aplicacao. Como se trata de um metodo parametrico, pois 
envolve a estimacao de parametros. Com o objetivo de facilitar o calculo do 
valor em risco, assume-se que a serie de retornos assume uma distribuicao
conhecida, como a distribuicao normal. 

Resumidamente, VaR pode ser a pior perda esperada para certo volume 
investido, sob condicoes normais de mercado e dentro de pequeno e 
determinado nível de confianca.
}
\details{
Suponha que se tenha aplicados $1.000.000,00 numa carteira que 
se espelha , exatamente, no IBOVESPA.

Pergunta-se: Qual e o VaR diario de 95%?

formulando a hipotese : 
\deqn{r_{t} = u_{t} + h^{\frac{1}{2}}_{t_{\frac{1}{2}}}e_{t}}
    
 onde , tipicamente: 
  \itemize{
   \item \eqn{u_{t}} é um processo AR(1)
   \item \eqn{h_{t_{\frac{1}{2}}}} é um processo GARCH(1,1) 
  }
  
  assim, temos: 
  
 \eqn{r_{t}\mid r_{t-1}~ N(u_{t},h_{t}^{*})}
 
 \eqn{e_{t} = \frac{(r_{t}-u_{t})}{h^{\frac{1}{2}}_{t}}~N(0,1)}
 
 Calculando o VaR condicional a 95% (fixado pelo pesquisador por exemplo):
 
\deqn{Pr(r_{t}\leq \fgrac{r_{t}^{*}}{r_{t-1}}) = 5\% },  padronizando, temos:
 
 
\deqn{Pr[(\frca{r_{t}-u_{t}}{h^{\frac{1}{2}_{t}}}) \leq \frac{(r_{t}^{*}-u_{t})}{h^{\frac{1}{2}}_{t}}] = 5\%}
}
\examples{

require(quantmod)

getSymbols('PETR4.SA',src='yahoo')
PETR4.SA.Close <- PETR4.SA$PETR4.SA.Close
r_PETR4 <- dailyReturn(PETR4.SA.Close,type = "log")
r_PETR4_pos2010 <- window(r_PETR4, start = "2010-01-01")

garch11.spec = ugarchspec(mean.model = list(armaOrder = c(1,0),include.mean=TRUE), 
variance.model = list(garchOrder = c(1,1), model = "sGARCH"))

garch.fit = ugarchfit(garch11.spec, data = r_PETR4_pos2010*100,fit.control=list(scale=TRUE), 
distribution.model = "norm")

BETS.param_var(garch.fit,volume = 30000,conf.level=0.90)
BETS.param_var(garch.fit,volume = 30000,conf.level=0.95)
BETS.param_var(garch.fit,volume = 30000,conf.level=0.99)
 
}
\keyword{Econometria}
\keyword{Series}
\keyword{Temporais}
\keyword{de}

