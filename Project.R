### Step 1: Load the required packages ----
#### languageserver ----
if (!is.element("languageserver", installed.packages()[, 1])) {
  install.packages("languageserver", dependencies = TRUE)
}
require("languageserver")

####readxl ----

if (!is.element("readxl", installed.packages()[, 1])) {
  install.packages("readxl", dependencies = TRUE)
}
require("readxl")

#### plumber ----
if (require("plumber")) {
  require("plumber")
} else {
  install.packages("plumber", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

####e1071----

if (!is.element("e1071", installed.packages()[, 1])) {
  install.packages("e1071", dependencies = TRUE)
}
require("e1071")

#### caretEnsemble ----

if (!is.element("caretEnsemble", installed.packages()[, 1])) {
  install.packages("caretEnsemble", dependencies = TRUE)
}
require("caretEnsemble")

####moments----

if (!is.element("moments", installed.packages()[, 1])) {
  install.packages("moments", dependencies = TRUE)
}
require("moments")

#### klaR ----
if (require("klaR")) {
  require("klaR")
} else {
  install.packages("klaR", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

#### LiblineaR ----
if (require("LiblineaR")) {
  require("LiblineaR")
} else {
  install.packages("LiblineaR", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

#### naivebayes ----
if (require("naivebayes")) {
  require("naivebayes")
} else {
  install.packages("naivebayes", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

#### readr ----
if (require("readr")) {
  require("readr")
} else {
  install.packages("readr", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

#### RRF ----
if (require("RRF")) {
  require("RRF")
} else {
  install.packages("RRF", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

#### naniar ----
if (require("naniar")) {
  require("naniar")
} else {
  install.packages("naniar", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

#### ggplot2 ----
if (require("ggplot2")) {
  require("ggplot2")
} else {
  install.packages("ggplot2", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

#### corrplot ----
if (require("corrplot")) {
  require("corrplot")
} else {
  install.packages("corrplot", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

#### ggcorrplot ----
if (require("ggcorrplot")) {
  require("ggcorrplot")
} else {
  install.packages("ggcorrplot", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

#### mlbench ----
if (require("mlbench")) {
  require("mlbench")
} else {
  install.packages("mlbench", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

#### stringi ----
if (require("stringi")) {
  require("stringi")
} else {
  install.packages("stringi", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

#### caret ----
if (require("caret")) {
  require("caret")
} else {
  install.packages("caret", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

#### dplyr ----
if (require("dplyr")) {
  require("dplyr")
} else {
  install.packages("dplyr", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

# Milestone 1 ----
## Issue 1: Descriptive Statistics ----

### Step 2: Load the dataset(s) ----
DonationsDataset <- read.csv("data/Food Bank of Southeastern Virginia.csv")
testing <- read.csv("data/testing.csv")


dim(DonationsDataset)
sapply(DonationsDataset, class)
any_miss(DonationsDataset)


### Step 3: Measures of Frequency ----
donation_freq <- DonationsDataset$Locality
cbind(frequency = table(donation_freq),
      percentage = prop.table(table(donation_freq)) * 100)


### Step 4: Measures of Central Tendency ----
donation_mode <- names(table(DonationsDataset$Locality))[
  which(table(DonationsDataset$Locality) == 
          max(table(DonationsDataset$Locality)))
]
print(donation_mode)


### Step 5: Measures of Distribution ----
summary(DonationsDataset)

### Step 6: Measures of Relationship
#### Measure the standard deviation ----
std_dev<- sd(DonationsDataset$Households.Served, na.rm = TRUE)
View(std_dev)

#### Measure the variance ----
variance<- var(DonationsDataset$Households.Served, na.rm = TRUE)
View(variance)

#### Measure the kurtosis ----
# The Kurtosis informs you of how often outliers occur in the results.
DonationsKurtosis <- kurtosis(DonationsDataset$Households.Served, 
                              na.rm = TRUE)
View(DonationsKurtosis)


#### Measure the skewness ----
DonationsSkewness <- skewness(DonationsDataset$Households.Served, 
                              na.rm = TRUE)
View(DonationsSkewness)

#### Measure the covariance between variables ----
donation_dataset_cov <- cov(DonationsDataset[, 6:8])
View(donation_dataset_cov)

#### Measure the correlation between variables ----
donation_dataset_cor <- cor(DonationsDataset[, 6:8])
View(donation_dataset_cor)


## Issue 2: Inferential Statistics ----
### Step 7: Perform ANOVA ----
Donation_one_way_anova <- aov(Pounds.of.Food.Distributed ~ 
                                Locality, data = DonationsDataset)
summary(Donation_one_way_anova)

## Issue 3 and 4: Basic Visualization and Preprocessing and Data Transformation ----
### Step 8: Apply a Scale Data Transform ----
# BEFORE
summary(DonationsDataset)

# Create histograms for specific columns
hist(DonationsDataset$Households.Served, main = "Histogram for Households Served")
hist(DonationsDataset$Individuals.Served, main = "Histogram for Individuals Served")
hist(DonationsDataset$Pounds.of.Food.Distributed, main = "Histogram for Pounds.of.Food.Distributed")

# Apply the scale transform
model_of_the_transform <- preProcess(DonationsDataset[c("Individuals.Served", "Pounds.of.Food.Distributed", "Households.Served")], method = c("scale"))
print(model_of_the_transform)
Donations_scale_transform <- predict(model_of_the_transform, DonationsDataset[c("Individuals.Served", "Pounds.of.Food.Distributed", "Households.Served")])

# AFTER
summary(Donations_scale_transform)

# Create histograms for specific columns after scaling
hist(Donations_scale_transform$Households.Served, main = "Histogram for Households Served")
hist(Donations_scale_transform$Individuals.Served, main = "Histogram for Individuals Served")
hist(Donations_scale_transform$Pounds.of.Food.Distributed, main = "Histogram for Pounds.of.Food.Distributed")
## Issue 5: Training the Model ----
### kNN and SVM for a classification problem with CARET's train function ----
### Step 9: Splitting the Dataset ----
str(DonationsDataset)
str(Donations_scale_transform)

train_index <- createDataPartition(DonationsDataset$Pounds.of.Food.Distributed,
                                   p = 0.75,
                                   list = FALSE)
donation_dataset_train <- DonationsDataset[train_index, ]
donation_dataset_test <- DonationsDataset[-train_index, ]

### Step 10: Train the model ----
# We apply the 10-fold cross validation resampling method
# We also apply the standardize data transform
 #KNN
set.seed(7)
train_control_knn <- trainControl(method = "cv", number = 5)
donations_caret_model_knn <- train(Locality ~ ., data = donation_dataset_train,
                                  method = "knn", metric = "Accuracy",
                                  preProcess = c("center", "scale"),
                                  trControl = train_control_knn)

 #SVM
set.seed(7)
train_control_svm <- trainControl(method = "cv", number = 5)
donations_caret_model_svm_radial <- # nolint: object_length_linter.
  train(Locality ~ ., data = donation_dataset_train, method = "svmRadial",
        metric = "Accuracy", trControl = train_control_svm)
#### Display the model's details ----
print(donations_caret_model_knn)
print(donations_caret_model_svm_radial)

#### Make predictions ----
 #KNN
predictions1 <- predict(donations_caret_model_knn,
                       donation_dataset_test[, c(1,2,4,5,6,7,8)])

 #SVM
predictions2 <- predict(donations_caret_model_svm_radial,
                       donation_dataset_test[, c(1,2,4,5,6,7,8)])

#### Display the model's evaluation metrics ----
all_levels <- union(levels(predictions1), levels(donation_dataset_test$Locality))
all_levels <- union(levels(predictions2), levels(donation_dataset_test$Locality))
donation_dataset_test$Locality <- factor(donation_dataset_test$Locality, levels = all_levels)
predictions1 <- factor(predictions1, levels = all_levels)
predictions2 <- factor(predictions2, levels = all_levels)

 #KNN
confusion_matrix1 <-
  caret::confusionMatrix(predictions1,
                         donation_dataset_test$Locality)
print(confusion_matrix1)

heatmap(confusion_matrix1$table, col = c("grey", "lightblue"),
        main = "Confusion Matrix")

 #SVM
table(predictions2, donation_dataset_test$Locality)
confusion_matrix2 <-
  caret::confusionMatrix(predictions2,
                         donation_dataset_test$Locality)
print(confusion_matrix2)

heatmap(confusion_matrix2$table, col = c("grey", "lightblue"),
        main = "Confusion Matrix")


### Step 11: Call the `resamples` Function ----
results <- resamples(list(KNN = donations_caret_model_knn, 
                          SVM = donations_caret_model_svm_radial))

### Step 12: Display the comparison ----
  #### 1. Table Summary ----
summary(results)

  #### 2. Box and Whisker Plot ----
scales <- list(x = list(relation = "free"), y = list(relation = "free"))
bwplot(results, scales = scales)

  #### 3. Dot Plots ----
# They show both the mean estimated accuracy as well as the 95% confidence
# interval (e.g. the range in which 95% of observed scores fell).

scales <- list(x = list(relation = "free"), y = list(relation = "free"))
dotplot(results, scales = scales)



## Issue 6: Hyper-Parameter Tuning and Ensembles ----
donations_independent_variables <- DonationsDataset[, c(1,2,3,4,5,7,8)]
donations_dependent_variables <- DonationsDataset[, 6]

### Step 13: Random Search ----

set.seed(7)

# Define the tuning grid for SVM (Radial Kernel)
tunegrid_svm <- expand.grid(
  sigma = runif(12, 0.01, 1), 
  C = runif(12, 0.1, 10)    
)

# Set up train control for cross-validation
train_control_svm <- trainControl(method = "cv", number = 5)

# Train the SVM model with random search
donations_caret_model_svm_radial_random_search <- train(
  Locality ~ ., 
  data = donation_dataset_train, 
  method = "svmRadial",
  metric = "Accuracy",
  tuneGrid = tunegrid_svm,
  trControl = train_control_svm
)

# Print and plot the results
print(donations_caret_model_svm_radial_random_search)
plot(donations_caret_model_svm_radial_random_search)

### Step 14. Saving The Model

#### Print the details of the model that has been created ----
print(donations_caret_model_svm_radial$finalModel)

#### Saving the model ----
saveRDS(donations_caret_model_svm_radial, 
        "./models/saved_donations_model_svm.rds")

#### Load the model ----
loaded_donations_model_svm <- readRDS("./models/saved_donations_model_svm.rds")
print(loaded_donations_model_svm)


predictions_with_loaded_model <-
  predict(loaded_donations_model_svm, newdata = donation_dataset_test)

all_levels <- union(levels(predictions_with_loaded_model), levels(donation_dataset_test$Locality))
donation_dataset_test$Locality <- factor(donation_dataset_test$Locality, levels = all_levels)
predictions_with_loaded_model <- factor(predictions_with_loaded_model, levels = all_levels)

confusionMatrix(predictions_with_loaded_model, donation_dataset_test$Locality)


### Step 15. Creating a function in R ----

name_of_function <- function(arg) {
  # Do something with the argument called `arg`
}


### Step 16. Make Predictions on New Data using the Saved Model ----

to_be_predicted <-
  data.frame( Year = 2023, Month ="Feb",
             Households.Served = 85, 
             Individuals.Served = 35,
             Pounds.of.Food.Distributed = 865, 
             Children.Served.via.non.federal.child.nutrition.programs = 987, 
             Pounds.of.food.distributed.via.non.federal.child.nutrition.progr = 1000) 

predict(loaded_donations_model_svm, newdata = to_be_predicted)


### Step 17. Make predictions using the model through a function ----

predict_svm_model <-
  function(arg_Year, arg_Month,
           arg_Households.Served, 
           arg_Individuals.Served,
           arg_Pounds.of.Food.Distributed, 
           arg_Children.Served.via.non.federal.child.nutrition.programs, 
           arg_Pounds.of.food.distributed.via.non.federal.child.nutrition.progr) {
    
    # Create a data frame using the arguments
    to_be_predicted <-
      data.frame(Year=arg_Year, Month=arg_Month,
                 Households.Served=arg_Households.Served, 
                 Individuals.Served=arg_Individuals.Served,
                 Pounds.of.Food.Distributed=arg_Pounds.of.Food.Distributed, 
                 Children.Served.via.non.federal.child.nutrition.programs=
                   arg_Children.Served.via.non.federal.child.nutrition.programs, 
                 Pounds.of.food.distributed.via.non.federal.child.nutrition.progr=
                   arg_Pounds.of.food.distributed.via.non.federal.child.nutrition.progr)
    
    # Make a prediction based on the data frame
    predict(loaded_donations_model_svm, to_be_predicted)
  }

# We can now call the function to predict

#predict_svm_model(2022, "Dec", 72, 35, 100, 344, 627)

#predict_svm_model(2034, "Apr", 66, 29, 90, 102, 351)

### Step 18. Process a Plumber API ----
# This allows us to process a plumber API
api <- plumber::plumb("runapiPlumber.R")

### Step 19. Run the API on a specific port ----

api$run(host = "127.0.0.1", port = 5022)

# Test the API
predict_svm_model(2022, "Dec", 72, 35, 100, 344, 627)

