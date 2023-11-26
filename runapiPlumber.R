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

#name_of_function <- function(arg) {
  # Do something with the argument called `arg`
#}


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
