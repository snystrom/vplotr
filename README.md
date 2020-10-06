
<!-- README.md is generated from README.Rmd. Please edit that file -->

# vplotr

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

vplotr is a tiny tool for making V-plot matrices ([Henikoff, et.
al. 2011](https://www.pnas.org/content/108/45/18318)). It requires a
small rust binary which can be found
[here](https://github.com/snystrom/vplot).

## Installation

You can install the development version of vplotr using:

``` r
if (!requireNamespace("remotes"))
  install.packages("remotes")

remotes::install_github("snystrom/vplotr")
```

## Example

vplotr only has 1 function: `vplot_matrix` which takes genomic
coordinates and a bam file, returning a matrix where columns are genomic
coordinates, and rows correspond to the fragment size of the read
(larger fragments are at the top of the matrix). Points on the plot
represent the midpoint of the sequenced fragment.

``` r
library(vplotr)
library(GenomicRanges)

myRegion <- GRanges("chr3R:16699979-16706691")
vmatrix <- vplot_matrix(myRegion, "path/to/bam.bam")
```
