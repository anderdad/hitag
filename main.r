install.packages(c("tidyverse", "camtrapR", "jsonlite", "shiny", "here"))
library(tidyverse)
library(camtrapR)
library(jsonlite)
library(shiny)
library(here)

project_folder_path <- "Project_Folder"

if (!dir.exists(project_folder_path)) {
  dir.create(project_folder_path)
}

