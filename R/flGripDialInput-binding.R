#' Highly configurable, touch-enabled grip dial knob input for Shiny
#'
#' @inheritParams touchKnobInput
#' @param color The color to use for the focus indicator and indicator dot. You can set any *hex* color (ex : '#0F1BC3') or named color, choices are 'purple', 'blue', 'green', 'yellow', 'red', 'orange' or 'transparent' to disable.
#' @param guideTicks Number of tick marks on the outer guide ring (default = 9)
#' @param gripBumps Number of grip bumps that appear when interacting with the dial (default = 5)
#' @param gripExtrusion The degree to which the grips 'cut' into the dial when the user interacts with it. (range 0 to 1, default = 0.5)
#' @param minRotation The angle (in degrees) of rotation corresponding to the min value, relative to pointing straight down (0 degree) (default = pointing to the first guide tick mark)
#' @param maxRotation The angle (in degrees) of rotation corresponding to the max value, relative to pointing straight down (0 degree) (default = pointing to the last guide tick mark)
#' 
#' @return Numeric value server-side.
#' @export
#'
#' @importFrom shiny addResourcePath singleton tagList
#' @importFrom htmltools tags
#' 
#' @examples 
#' if (interactive()) {
#'
#' library("shiny")
#' library("shinyKnobs")
#'
#' ui <- fluidPage(
#'   touchGripKnobInput(
#'     inputId = "myKnob",
#'     width = "25%",
#'     label = "A label...",
#'     color = "#428BCA"
#'   ),
#'   verbatimTextOutput(outputId = "res")
#' )
#'
#' server <- function(input, output, session) {
#'
#'   output$res <- renderPrint(input$myKnob)
#'
#' }
#'
#' shinyApp(ui = ui, server = server)
#'
#' }
touchGripKnobInput <- function(inputId,
                            label = NULL,
                            labelPosition = "top",
                            width = 'auto',
                            step = 'any',
                            min = 0,
                            max = 1,
                            initial = 0.5,
                            color = "orange",
                            guideTicks = 9,
                            gripBumps = 5,
                            gripExtrusion = 0.5,
                            minRotation = 20,
                            maxRotation = 340,
                            dragResistance = 100,
                            wheelResistance = 100,
                            globalRatePolicy = NULL,
                            globalRatePolicyDelay = 500) {

  addResourcePath("www", system.file("www/", package = "shinyKnobs"))

  tagList(
    singleton(tags$head(
      tags$script(inputIdsrc="www/precision-inputs/utils/color.js"),
      tags$script(src="www/precision-inputs/utils/svg.js"),
      tags$script(src="www/precision-inputs/utils/ui.js"),
      tags$link(rel="stylesheet", type="text/css", href="www/precision-inputs/fl-controls/fl-reactive-grip-dial.css"),
      tags$link(rel="stylesheet", type="text/css", href="www/precision-inputs/base/knob-input.css")
    )),
    singleton(tags$body(
      tags$script(src="www/precision-inputs/base/knob-input.js"),
      tags$script(src="www/precision-inputs/fl-controls/fl-colors.js"),
      tags$script(src="www/precision-inputs/fl-controls/fl-reactive-grip-dial.js"),
      tags$script(src="www/flGripDialInput-binding.js")
    )),
    tags$div(id = inputId,
             class = "fl-grip-dial",
             "data-label" = label,
             "data-labelposition" = labelPosition,
             "data-width" = width,
             "data-step" = step,
             "data-min" = min,
             "data-max" = max,
             "data-initial" = initial,
             "data-dragresistance" = dragResistance,
             "data-wheelresistance" = wheelResistance,
             "data-color" = color,
             "data-guideticks" = guideTicks,
             "data-gripbumps" = gripBumps,
             "data-gripextrusion" = gripExtrusion,
             "data-minrotation" = minRotation,
             "data-maxrotation" = maxRotation,
             "data-globalratepolicy" = globalRatePolicy,
             "data-globalratepolicydelay" = globalRatePolicyDelay)
  )
}
