library(lme4)

linear_model_brainage <- lm(cole_diff ~ cole_brainage, data=cole_predictedAge)
plot(cole_diff ~ cole_brainage, data=cole_predictedAge)
abline(linear_model_brainage)


linear_model_chron <- lm(cole_diff ~ chronological_age , data=cole_predictedAge)
plot(cole_diff ~ chronological_age, data=cole_predictedAge)
abline(linear_model_chron)

linear_model_combined <- lm(cole_diff ~ chronological_age + cole_brainage , data=cole_predictedAge)
plot(cole_diff ~ chronological_age  + cole_brainage, data=cole_predictedAge)
abline(linear_model_combined)

