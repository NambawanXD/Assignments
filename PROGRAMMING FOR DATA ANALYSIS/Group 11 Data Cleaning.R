#ADAM JEROME JOSEPH, TP071194
#HEMANTHRAJAH A/L N KRISHNARAJAH, TP070844
#SAILESS RAJ A/L RAJENDRAN, TP070996
#JOSHUA EMMANUEL KC SATHASIVAM, TP070067


#IMPORT
#Read the File
# Load the dataset
data <- read_csv("C:/Users/Adam JJ/Desktop/SEM 1/PFDA/hackingData.csv", locale = locale(encoding = "latin1"))

#INSTALL LIBRARY
#install.packages("dplyr")
#install.packages("readr")
#install.packages("stringr")

# Load necessary packages
library(dplyr)
library(readr)
library(stringr)

#DATA CLEANING
# Ensure column names are clean
colnames(data) <- make.names(colnames(data), unique = TRUE)

# Trim whitespace, remove duplicates
data <- data %>%
  mutate(across(where(is.character), str_trim)) %>%
  distinct()

# Convert Date column to Date type
data$Date <- as.Date(data$Date, format = "%m/%d/%Y")

# Convert numeric columns and filter invalid values
data <- data %>%
  mutate(
    Ransom = as.numeric(Ransom),
    Loss = as.numeric(Loss),
    DownTime = as.numeric(DownTime)
  ) %>%
  filter(if_else(!is.na(DownTime), DownTime >= 0, TRUE)) %>%
  filter(if_else(!is.na(Loss), Loss >= 0, TRUE)) %>%
  filter(if_else(!is.na(Ransom), Ransom >= 0, TRUE))

# Standardize country names and remove "Unknown" as NA
data <- data %>%
  mutate(
    Country = str_trim(Country),
    Country = str_to_title(Country),
    Country = case_when(
      Country == "United State" ~ "United States",
      Country == "United Kingd" ~ "United Kingdom",
      Country == "Viet Nam" ~ "Vietnam",
      Country == "Unknown" ~ NA_character_,
      TRUE ~ Country
    )
  )

#DATA VALIDATION
#DATASET INFORMATION
str(data)

#SUMMARY OF ENTIRE DATA
summary(data)

#SUMMARY OF A PARTICULAR COLUMN
summary(data$Date)
summary(data$Notify)
summary(data$URL)
summary(data$IP)
summary(data$Country)
summary(data$OS)
summary(data$WebServer)
summary(data$Encoding)
summary(data$Lang)
summary(data$Ransom)
summary(data$DownTime)
summary(data$Loss)

#MAX VALUES
max(data$Ransom)
max(data$DownTime)
max(data$Loss)

#MIN VALUES
min(data$Ransom)
min(data$DownTime)
min(data$Loss)

# Debugging: Check if changes were applied before saving
print(unique(data$Country)) # See if country names updated
sum(is.na(data$Country)) # Count NA values

# Save the cleaned dataset
write_csv(data, "C:/Users/Adam JJ/Desktop/SEM 1/PFDA/cleaned_hackingData.csv", col_names = TRUE)
