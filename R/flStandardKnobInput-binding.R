#' Highly configurable, touch-enabled knob input for Shiny
#' 
#' @param inputId The input slot that will be used to access the value.
#' @param label Optional label for knob
#' @param labelPosition Position of label ('top' or 'bottom')
#' @param width Width of the knob as a percentage of the container element
#' @param step The step amount for value changes, usually used with min and max parameters. Can be 'any' (no step)
#' @param min The minimum input value.
#' @param max The maximum input value.
#' @param initial Initial value of the knob. Knob resets to this value when double-clicked.
#' @param color The color to use for the indicator ring fill, focus indicator, and indicator dot (if present). You can set any *hex* color (ex : '#0F1BC3') or named color, choices are 'purple', 'blue', 'green', 'yellow', 'red', 'orange' or 'transparent' to disable
#' @param indicatorDot Whether the knob should display an indicator dot for making it easier to read the current value. (TRUE or FALSE)
#' @param indicatorRingType The fill style for the indicator ring. 'positive' - color fills in from the left as value increases. 'negative' - color fills in from the right as value decreases. 'split' - color fills left/right from middle as value increases/decreases relative to the middle value (half-way between min and max)Type of knob can be 'positive' (clockwise), 'negative' (counter-clockwise) or 'split' (plus/minus vs center position)
#' @param dragResistance The amount of resistance to value change on mouse/touch drag events. Higher value means more precision, and the user will have to drag farther to change the input's value. (0 to 100)
#' @param wheelResistance The amount of resistance to value change on mouse wheel scroll. Higher value means more precision, and the mouse wheel will be less effective at changing the input's value. (0 to 100) 
#' @param globalRatePolicy Rate policy determining the behavior of output value events. NULL will output values in real-time, 'debounce' will output values once the knob stops moving, 'throttle' will output values while the knob is moving but only at a certain frequency (controlled with ratePolicyDelay). This setting will affect every touchKnobInput in the project. 
#' @param globalRatePolicyDelay Delay to use when globalRatePolicy is set to 'throttle' or 'debounce'. This setting will affect every touchKnobInput in the project.
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
#'   touchKnobInput(
#'     inputId = "myKnob",
#'     label = "A label...",
#'     initial = 0,
#'     width = "25%",
#'     min = -50,
#'     max = 50,
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
touchKnobInput <- function(inputId,
                                label = NULL,
                                labelPosition = "top",
                                width = 'auto',
                                step = 'any',
                                min = 0,
                                max = 1,
                                initial = 0.5,
                                color = "orange",
                                indicatorDot = TRUE,
                                indicatorRingType = 'positive',
                                dragResistance = 100,
                                wheelResistance = 100,
                                globalRatePolicy = NULL,
                                globalRatePolicyDelay = 500) {

  addResourcePath("www", system.file("www/", package = "flKnobInputs"))

tagList(
    singleton(tags$head(
      tags$script(src="www/precision-inputs/utils/color.js"),
      tags$script(src="www/precision-inputs/utils/svg.js"),
      tags$script(src="www/precision-inputs/utils/ui.js"),
      tags$link(rel="stylesheet", type="text/css", href="www/precision-inputs/fl-controls/fl-standard-knob.css"),
      tags$link(rel="stylesheet", type="text/css", href="www/precision-inputs/base/knob-input.css")
    )),
    singleton(tags$body(
      tags$script(src="www/precision-inputs/base/knob-input.js"),
      tags$script(src="www/precision-inputs/fl-controls/fl-colors.js"),
      tags$script(src="www/precision-inputs/fl-controls/fl-standard-knob.js"),
      tags$script(src="www/flStandardKnobInput-binding.js")
    )),
    tags$div(id = inputId,
             class = "fl-knob",
             "data-label" = label,
             "data-labelposition" = labelPosition,
             'data-width' = width,
             "data-step" = step,
             "data-min" = min,
             "data-max" = max,
             "data-initial" = initial,
             "data-dragresistance" = dragResistance,
             "data-wheelresistance" = wheelResistance,
             "data-indicatordot" = tolower(indicatorDot),
             "data-indicatorringType" = indicatorRingType,
             "data-color" = color,
             "data-globalratepolicy" = globalRatePolicy,
             "data-globalratepolicydelay" = globalRatePolicyDelay)
  )
}
