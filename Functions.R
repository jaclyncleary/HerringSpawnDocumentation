# Function to import and convert markdown to latex
LoadMarkdown <- function( file ) {
  # Grab the markdown text
  mdText <- readLines( con=file )
  # Remove empty lines
  mdText <- mdText[mdText != ""]
  # Identify lines that start with # (i.e., section headers)
  commentLines <- grep( pattern="^[#]", x=mdText )
  # Remove header lines
  mdText <- mdText[-commentLines]
  # Replace * with $ (for italics)
  texText <- gsub( pattern="\\*", replacement="$", x=mdText )
  # Replace predecing quote with directional quote
  texText <- gsub( pattern=" \\'", replacement=" `", x=texText )
  # Combine the results into one string
  res <- paste( x=texText, collapse=" " )
  # Return the string without quotes
  return( noquote(res) )
}  # End LoadMarkdown function
