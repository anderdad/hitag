promtandprint <- function(linea, lineb, output_to_print) {
    if(missing(linea)) {
        stop("First line compulsory")
        }
    if (missing(lineb)) {
        lineb <- " " #set default value if not selected
    }
    if (missing(output_to_print)){
            output_to_print <- " " #set default value if not selected
        }
    concat <- paste(linea, lineb)
    print(concat)
    readline(prompt = "Press <Enter> to continue...")
}



# Function to extract and standardize metadata
extract_metadata <- function(file) {
  metadata <- tryCatch({
    read_exif(file)
  }, error = function(e) {
    list(error = "Failed to read metadata")
  })
  
  # Convert to a named list with standardized fields if necessary
  # This is a placeholder; actual implementation depends on the structure of metadata
  # For example, you might only keep certain fields, or handle missing data in a specific way
  metadata_list <- list(
    FileName = file,
    # Assuming 'DateTimeOriginal' is a field you want; adjust as needed
    DateTaken = if("DateTimeOriginal" %in% names(metadata)) metadata$DateTimeOriginal else NA,
    # Add more fields as needed
  )
  
  return(metadata_list)
}


shes_so_meta <- function(image_file) {

        # Assuming image_files is a vector of image file paths
        metadata_list <- lapply(image_files, function(file) {
        tryCatch({
            read_exif(file)
        }, error = function(e) {
            # Return NA or an empty data frame in case of an error (e.g., file not found or format not supported)
            NA
        })
        })

        # Combine all metadata into a single data frame
        metadata_df <- do.call(rbind, metadata_list)
        return(metadata_df)

        # Write the metadata to a CSV file
        

}