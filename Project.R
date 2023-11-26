### Step 1: Load the required packages ----


if (!is.element("languageserver", installed.packages()[, 1])) {
  install.packages("languageserver", dependencies = TRUE)
}
require("languageserver")



if (!is.element("readxl", installed.packages()[, 1])) {
  install.packages("readxl", dependencies = TRUE)
}
require("readxl")

if (!is.element("e1071", installed.packages()[, 1])) {
  install.packages("e1071", dependencies = TRUE)
}
require("e1071")

# Milestone 1 ----
## Issue 1: Descriptive Statistics ----

### Step 2: Load the dataset(s) ----
DonationsDataset <- read_excel("data/Donations.xlsx")
OrphanagesDataset <- read_excel("data/Orphanages.xlsx")


dim(DonationsDataset)
dim(OrphanagesDataset)

sapply(DonationsDataset, class)
sapply(OrphanagesDataset, class)

### Step 3: Measures of Frequency ----
donation_freq <- DonationsDataset$Donations
cbind(frequency = table(donation_freq),
      percentage = prop.table(table(donation_freq)) * 100)

orphanage_freq <- OrphanagesDataset$`Orphanage Needs`
cbind(frequency = table(orphanage_freq),
      percentage = prop.table(table(orphanage_freq)) * 100)

### Step 4: Measures of Central Tendency ----
donation_mode <- names(table(DonationsDataset$Donations))[
  which(table(DonationsDataset$Donations) == 
          max(table(DonationsDataset$Donations)))
]
print(donation_mode)

orphanage_mode <- names(table(OrphanagesDataset$`Orphanage Needs`))[
  which(table(OrphanagesDataset$`Orphanage Needs`) == 
          max(table(OrphanagesDataset$`Orphanage Needs`)))
]
print(orphanage_mode)

### Step 5: Measures of Distribution ----
summary(DonationsDataset)
summary(OrphanagesDataset)

### Step 6: Measures of Relationship
#### Measure the standard deviation of each variable ----
sapply(DonationsDataset[, 4], sd)

#### Measure the variance of each variable ----
sapply(DonationsDataset[, 4], var)

#### Measure the kurtosis of each variable ----
# The Kurtosis informs you of how often outliers occur in the results.
sapply(DonationsDataset[, 4],  kurtosis, type = 2)
