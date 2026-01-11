


# paste your lua file here as a single string
txt <- paste(readLines("core/control.lua"), collapse = "\n")

INDENT <- "\t"

# --- helpers ---------------------------------------------------------------

count_kw <- function(s, pattern) {
  m <- gregexpr(pattern, s, perl = TRUE)[[1]]
  if (length(m) == 1 && m[1] == -1) 0 else length(m)
}

# Track long comment/string delimiters like [[...]] or [=[...]=]
state <- list(mode = "none", eq = "")

sanitize_line <- function(line, state) {
  # Returns: list(code = <string used for keyword detection>, state = <updated state>)
  out <- character()
  i <- 1
  n <- nchar(line)
  
  substr1 <- function(s, a, b) substr(s, a, b)
  
  find_long_close <- function(s, eq) {
    # close token is ]=*=]
    pat <- paste0("]", eq, "]")
    regexpr(pat, s, fixed = TRUE)[1]
  }
  
  while (i <= n) {
    rest <- substr1(line, i, n)
    
    # If we're inside a long comment or long string, look for the closing delimiter
    if (state$mode %in% c("long_comment", "long_string")) {
      closer <- paste0("]", state$eq, "]")
      pos <- regexpr(closer, rest, fixed = TRUE)[1]
      if (pos == -1) {
        # everything left is inside the long block
        i <- n + 1
        break
      } else {
        # skip through the closer and resume parsing
        i <- i + pos - 1 + nchar(closer)
        state$mode <- "none"
        state$eq <- ""
        next
      }
    }
    
    # Not in long blocks: handle line comments "--" (including long comments), strings, long strings
    if (nchar(rest) >= 2 && substr1(rest, 1, 2) == "--") {
      # check for long comment opener: --[=*[[
      m <- regexpr("^--\\[(=*)\\[", rest, perl = TRUE)
      if (m[1] != -1) {
        eq <- sub("^--\\[(=*)\\[.*$", "\\1", regmatches(rest, m))
        state$mode <- "long_comment"
        state$eq <- eq
        # skip opener
        i <- i + attr(m, "match.length")
        next
      } else {
        # regular line comment: ignore rest of line for keyword analysis
        break
      }
    }
    
    # long string opener: [=*[[
    m2 <- regexpr("^\\[(=*)\\[", rest, perl = TRUE)
    if (m2[1] != -1) {
      eq <- sub("^\\[(=*)\\[.*$", "\\1", regmatches(rest, m2))
      state$mode <- "long_string"
      state$eq <- eq
      i <- i + attr(m2, "match.length")
      next
    }
    
    ch <- substr1(line, i, i)
    
    # short strings: "..." or '...'
    if (ch %in% c("\"", "'")) {
      q <- ch
      i <- i + 1
      while (i <= n) {
        ch2 <- substr1(line, i, i)
        if (ch2 == "\\") {
          i <- i + 2
          next
        }
        if (ch2 == q) {
          i <- i + 1
          break
        }
        i <- i + 1
      }
      # replace string contents with a space so keywords inside strings don't count
      out <- c(out, " ")
      next
    }
    
    # normal character
    out <- c(out, ch)
    i <- i + 1
  }
  
  list(code = paste0(out, collapse = ""), state = state)
}

# --- main ------------------------------------------------------------------

lines <- strsplit(txt, "\n", fixed = TRUE)[[1]]

indent <- 0
out_lines <- character()

for (line in lines) {
  # keep the original text, only re-indent it
  line <- sub("[ \t]+$", "", line)      # trim trailing whitespace
  stripped <- sub("^\\s+", "", line)    # remove leading whitespace
  
  # Create a sanitized version used ONLY for detecting keywords
  s <- sanitize_line(stripped, state)
  code <- s$code
  state <- s$state
  
  trimmed_code <- sub("^\\s+", "", code)
  
  # Identify whether the *code* (not comment) starts with these keywords
  starts_end   <- grepl("^end\\b", trimmed_code, perl = TRUE)
  starts_until <- grepl("^until\\b", trimmed_code, perl = TRUE)
  starts_else  <- grepl("^else\\b", trimmed_code, perl = TRUE)
  starts_elseif<- grepl("^elseif\\b", trimmed_code, perl = TRUE)
  
  leading_close <- as.integer(starts_end || starts_until)
  leading_else  <- as.integer(starts_else || starts_elseif)
  
  # Dedent before printing for end/until/else/elseif
  indent_before <- max(indent - leading_close - leading_else, 0)
  
  # Output line with tab indent (even comment lines, but comments never affect nesting)
  out_lines <- c(out_lines, paste0(strrep(INDENT, indent_before), stripped))
  
  # Count open/close keywords in sanitized code (keywords inside comments/strings are gone)
  open_total  <- 0
  close_total <- 0
  
  open_total  <- open_total  + count_kw(code, "\\bfunction\\b")
  open_total  <- open_total  + count_kw(code, "\\brepeat\\b")
  open_total  <- open_total  + count_kw(code, "\\bthen\\b")
  open_total  <- open_total  + count_kw(code, "\\bdo\\b")
  
  close_total <- close_total + count_kw(code, "\\bend\\b")
  close_total <- close_total + count_kw(code, "\\buntil\\b")
  
  # We've already applied the leading close (end/until) via dedent-before
  remaining_closes <- close_total - leading_close
  if (remaining_closes < 0) remaining_closes <- 0
  
  # Update indent after the line
  indent <- indent_before + open_total - remaining_closes
  
  # "else" opens a new body level but does not contain "then"
  # "elseif" already has "then" and is handled by open_total, so only add for "else"
  if (starts_else) indent <- indent + 1
  
  if (indent < 0) indent <- 0
}

out <- paste(out_lines, collapse = "\n")


writeLines(out, "dummy.lua")
