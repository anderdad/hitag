#start
packages <- c("tidyverse", "camtrapR", "jsonlite", "shiny", "here", "base64enc")

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
library(conflicted)
library(base64enc)

#deal with conflicts
conflict_prefer("filter", "dplyr")
conflict_prefer("lag", "dplyr")

#load library files
source(here("lib", "anderdad_functions.r"))


project_folder_path <- "Project_Folder"
image_directory <- "./Project_Folder/images"

promtandprint(project_folder_path, image_directory)
promtandprint("print what will go into the list now")

# List all JPEG files in the directory and its subdirectories
image_files <- list.files(
                          path = image_directory,
                          pattern = "(?i)\\.(jpg|jpeg)$",
                          full.names = TRUE,
                          recursive = TRUE)

write.csv(image_files, here("file_list.csv"), row.names = FALSE)

# Read metadata from the first 10 images
small_subset <- image_files[1:10]
metadata_list <- lapply(small_subset, exif_read)


# Extract specific metadata fields and create a data frame
metadata_summary <- lapply(metadata_list, function(metadata) {
  data.frame(
    FileName = metadata$SourceFile,
    DateTimeOriginal = metadata$DateTimeOriginal,
    stringsAsFactors = FALSE
  )
})

write.csv(shes_so_meta(metadata_summary), here("metadata_summary.csv"), row.names = FALSE)


promtandprint("a.")
# Combine all individual data frames into one
metadata_df <- do.call(rbind, metadata_summary)
write.csv(shes_so_meta(metadata_df), here("metadata_DF.csv"), row.names = FALSE)

print("b")
# Apply the function to each file and combine into a data frame
metadata_list <- lapply(image_files, extract_metadata)
metadata_df <- do.call(rbind, lapply(metadata_list, function(x) as.data.frame(t(x), stringsAsFactors = FALSE)))

# Write to CSV
write.csv(metadata_df, "image_metadata.csv", row.names = FALSE)

print("done")