


ReadCB_h5 <- function (filename){
  #### load data
  h5_data <- hdf5r::H5File$new(filename, mode = 'r')
  
  #### create sparse matrix
  feature_matrix <- Matrix::sparseMatrix(
    i = h5_data[['matrix/indices']][],
    p = h5_data[['matrix/indptr']][],
    x = h5_data[['matrix/data']][],
    dimnames = list(
      h5_data[['matrix/features/name']][],
      h5_data[['matrix/barcodes']][]
    ),
    dims = h5_data[['matrix/shape']][],
    index1 = FALSE
  )  
  print(dim(feature_matrix))
  ### Identify and Handle Duplicate Row Names
  duplicated_rows <- duplicated(rownames(feature_matrix))
  duplicated_rows_indices <- which(duplicated_rows)
  duplicated_rows_names <- rownames(feature_matrix)[duplicated_rows]
  ### Resolve Duplicate Row Names
  unique_row_names <- make.unique(rownames(feature_matrix))
  rownames(feature_matrix) <- unique_row_names
  
  return(feature_matrix)
} 
