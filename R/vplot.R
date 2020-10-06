#' Return a vplot matrix
#'
#' @param region GRanges object of the region in which to build the matrix
#' @param bam bam file to collect signal from (must have bam index in same location)
#'
#' @return a matrix where rows correspond to fragment size, and columns are
#'   genomic position. Row 1 is the 700 bp fragment size (max fragment size
#'   currently allowed).
#' @export
#'
#' @importFrom GenomicRanges granges
#' @importFrom magrittr %>%
#' @examples
vplot_matrix <- function(region, bam, vplot_path = NULL){
  if (length(region) > 1) {
    stop("region can only be 1 range at at time")
  }

  region_bed <- tempfile()
  granges(region) %>%
    rtracklayer::export.bed(con = region_bed)

  v_matrix_path <- tempfile("vplot", fileext = ".csv")

  vplot_path <- vplot_path_search(path = vplot_path)
  system2(vplot_path, paste(bam, region_bed, ">", v_matrix_path))

  mat <- vroom::vroom(v_matrix_path, col_names = FALSE) %>%
    as.matrix() %>%
    apply(., 2, rev)
  colnames(mat) <- NULL
  return(mat)
}

#' Find path to vplot rust binary
#'
#' @return path to vplot binary
#' @noRd
vplot_path_search <- cmdfun::cmd_path_search(option_name = "vplot_bin",
                          default_path = "~/.cargo/bin/vplot")
