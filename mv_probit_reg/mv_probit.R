library(mvtnorm)
library(mvProbit)
N <- 1000
D <- 2
K <- 3
X <- matrix(rnorm(N * K), N, K)
beta <- matrix(c(1, 2, 3, 4, 5, 6), D, K)
Sigma <- diag(D)
mu <- X %*% t(beta) 
eps <- rmvnorm(n=N, sigma=Sigma)
z <- mu + eps
y <- ifelse(z >= 0, 1, 0)


library(rstan)
options(mc.cores = parallel::detectCores())
rstan_options(auto_write = TRUE)
dat <- list(K=K, D=D, N=N, y=y, x=X)

fit <- stan(file = 'mv_probit.stan', data = dat)
print(fit)
plot(fit)