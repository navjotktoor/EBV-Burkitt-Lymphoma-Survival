# 1. Load the packages you just installed
library(glmnet)
library(survival)

# 2. Simulate the Burkitt Lymphoma clinical and mutation dataset
set.seed(123)
n_patients <- 130 # Total EBV-positive patients in the study

# Create mock features: Country Income, LMP1 variants, Driver genes (0 = No, 1 = Yes)
data <- data.frame(
  Survival_Time = runif(n_patients, 0.5, 5.0), # Years survived
  Status = sample(c(0, 1), n_patients, replace = TRUE), # 1 = dead, 0 = censored
  Low_Middle_Income = sample(c(0, 1), n_patients, replace = TRUE),
  LMP1_G331Q = sample(c(0, 1), n_patients, prob = c(0.9, 0.1), replace = TRUE),
  LMP1_H101Q = sample(c(0, 1), n_patients, prob = c(0.9, 0.1), replace = TRUE),
  TP53_Mutation = sample(c(0, 1), n_patients, prob = c(0.8, 0.2), replace = TRUE)
)

# 3. Prepare data for the LASSO model
# x is the matrix of features; y is the survival object (time and status)
x <- as.matrix(data[, 3:6])
y <- Surv(data\(Survival_Time, data\)Status)

# 4. Run LASSO Cox Regression
# alpha = 1 means LASSO, family = "cox" is for survival data
lasso_model <- cv.glmnet(x, y, family = "cox", alpha = 1)

# 5. Extract and view the results
coefficients <- coef(lasso_model, s = "lambda.min")
print("Top features associated with patient survival:")
print(coefficients)