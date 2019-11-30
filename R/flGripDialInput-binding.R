#' @export
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

  addResourcePath("www", system.file("www/", package = "flKnobInputs"))

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
