# List of packages you want to ensure are installed
packages <- c("tidyverse", "camtrapR", "jsonlite", "shiny", "here")

# Loop through each package and install it if it's not already installed
for (pkg in packages) {
  if (!pkg %in% rownames(installed.packages())) {
    install.packages(pkg)
  }
}

library(tidyverse)
library(camtrapR)
library(jsonlite)
library(shiny)
library(here)
library(exiftoolr)




project_folder_path <- "Project_Folder"

image_directory <- "./Project_Folder/images"

# List all JPEG files in the directory and its subdirectories
image_files <- list.files(
                          path = image_directory,
                          pattern = "(?i)\\.(jpg|jpeg)$",
                          full.names = TRUE,
                          recursive = TRUE)

print(image_files)

# Read metadata from all JPEG files
metadata_list <- lapply(image_files, exif_read)

# Test with a smaller subset of image files
small_subset <- image_files[1:10]
metadata_list_test <- lapply(small_subset, exif_read)

print(small_subset)

write.csv(df, file = here("metatdata.csv"), row.names = FALSE)

print("a.")
# Extract specific metadata fields and create a data frame
metadata_summary <- lapply(metadata_list_test, function(metadata) {
  data.frame(
    FileName = metadata$SourceFile,
    DateTimeOriginal = metadata$DateTimeOriginal,
    stringsAsFactors = FALSE
  )
})

print("a.")
# Combine all individual data frames into one
metadata_df <- do.call(rbind, metadata_summary)

print("b")
# Display the first few rows of the data frame
print(head(metadata_df))
print("c.")
print(metadata_df)
Print("d is for dun :)")