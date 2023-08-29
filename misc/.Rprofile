setHook("rstudio.sessionInit", function(newSession) {
  if (newSession) {
    update_prefs <- function(...) {
      list_updated_prefs <- rlang::dots_list(...)
      purrr::iwalk(list_updated_prefs, ~rstudioapi::writeRStudioPreference(name = .y, value = .x))
      return(invisible(list_updated_prefs))
    }
    
    update_prefs(
      save_workspace = "never",
      insert_native_pipe_operator = TRUE,
      soft_wrap_r_files = TRUE,
      show_margin = FALSE,
      rainbow_parentheses = TRUE
    )
    message("RStudio global preferences have been set.")
    rm(update_prefs)
  }
}, action = "append")