#' @export
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
