#' Creates the standard set of subdirectories for a typical R project
#'
#' Creates the standard set of subdirectories for a typical R project
#' @param style string value indicating the style of subdirectories to create (c("default", "learning", "minimal"))
#' @param vignette a boolean value indicating whether "analysis" directory should be named "vignette"
#' @keywords organization workflow eda
#' @export
#' @examples
#' create_project_directories()

create_project_directories <- function(style = "default", license = "none", vignette = FALSE, add_makefile = TRUE, ...){
  # extract project name for labeling cloud directory
  project_name <- basename( rstudioapi::getActiveProject() )

  # define directories
  default_template <-
    c("data", "script", "analysis", "R", "presentations", "support_files",
      fs::path("script", "R_script"),
      fs::path("script", "stata_do"),
      fs::path("script", "python"),
      fs::path("analysis", "tables"),
      fs::path("analysis", "figures"),
      fs::path("analysis", "pdfs"),
      fs::path("analysis", "reports"),
      fs::path("data", "raw")
    )

  # populate project directory with files and subdirectories
  if (style == "default") {
    purrr::walk(default_template, dir.create)
    breadcrumbs::add_file_paths()
    breadcrumbs::add_readme(style = style)
    breadcrumbs::add_gitignore()
    file.create("README.md")
  }

  if (vignette == TRUE) {file.rename("analysis", "vignette")}

  if (license == "MIT") {usethis::use_mit_license()}

  if (add_makefile == TRUE) {breadcrumbs::add_makefile()}
}
