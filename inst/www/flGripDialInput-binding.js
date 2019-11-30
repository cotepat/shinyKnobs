// this object that tells Shiny how to identify instances of our component and how to interact with them
var flGripDialBinding = new Shiny.InputBinding();

var flGripRatePolicy;
var flGripRatePolicyDelay;

// add methods to it using jQuery's extend method
$.extend(flGripDialBinding, {

  find: function(scope) {
    // find all instances of class fl-knob
    return $(scope).find(".fl-grip-dial");
  },

  // this method will be called on initialisation
  initialize: function(el) {
      var label = $(el).data("label");
      var labelPosition = $(el).data("labelposition");
      var width = $(el).data("width");
      var step = typeof($(el).data("step"))  === 'number' ? $(el).data("step") : "'any'";
      var min = $(el).data("min");
      var max = $(el).data("max");
      var initial = $(el).data("initial");
      var dragResistance = $(el).data("dragresistance");
      var wheelResistance = $(el).data("wheelresistance");
      var color = $(el).data("color");
      color = typeof color !== 'undefined' ? color : colors.default.str;
      var guideTicks = $(el).data("guideticks");
      var gripBumps = $(el).data("gripbumps");
      var gripExtrusion = $(el).data("gripextrusion");
      var minRotation = $(el).data("minrotation");
      var maxRotation = $(el).data("maxrotation");
      flGripRatePolicy = typeof($(el).data("globalratepolicy")) !== 'undefined' ? $(el).data("globalratepolicy") : flGripRatePolicy;
      flGripRatePolicyDelay = typeof($(el).data("globalratepolicydelay")) !== 'undefined' ? $(el).data("globalratepolicydelay") : flGripRatePolicyDelay;

     eval("var knob" +
          el.id +
          "  = new FLReactiveGripDial(el, { " +
          "step: " + step +
          ", min: " + min +
          ", max: " + max +
          ", initial: " + initial +
          ", dragResistance: " + dragResistance +
          ", wheelResistance: " + wheelResistance +
          ", color: '" + color + "'" +
          ", guideTicks: " + guideTicks +
          ", gripBumps: " + gripBumps +
          ", gripExtrusion: " + gripExtrusion +
          ", minRotation: " + minRotation +
          ", maxRotation: " + maxRotation +
          "})");

          el.style.width = typeof width === 'number' ? 'auto' : width;
          console.log(el.style.width);
          console.log(width);

          if(labelPosition === 'top') {
            if(typeof(label) !== 'undefined') el.insertAdjacentHTML("afterbegin", "<div align = 'center'><b>" + label + "</b></div>");
          } else if (labelPosition === 'bottom') {
            if(typeof(label) !== 'undefined') el.insertAdjacentHTML("beforeend", "<div align = 'center'><b>" + label + "</b></div>");
          }

     // extract the value from el
     var value = el.querySelector(".knob-input__input").value;

     // note $("#" + el.id) equals the input tag we generated
     $("#" + el.id)[0].querySelector(".knob-input__input").value = value;
  },

  // this method will also be called on initialisation (to pass the intial state to input$...)
  // and each time when the callback is triggered via the event bound in subscribe
  getValue: function(el) {

    // get the value
    var value = $(el)[0].querySelector(".knob-input__input").value;

    return value;
  },

  subscribe: function(el, callback) {
    // trigger the getValue method and send the value to shiny
    $(el.querySelector(".knob-input__input")).on('change.knob-input__input', function(event){
      //console.log(event);
      // callback which will tell Shiny to retrieve the value via getValue

      //when callback is true, uses getflGripRatePolicy()
      var useflGripRatePolicy = (flGripRatePolicy === 'throttle' || flGripRatePolicy === 'debounce');
      //console.log(useflGripRatePolicy);
      callback(useflGripRatePolicy);
    });
  },

  unsubscribe: function(el) {
    $(el.querySelector(".knob-input__input")).off("change.knob-input__input");
  },

    // The input rate limiting policy
  getRatePolicy: function() {
    return {
      // Can be 'debounce' or 'throttle'
      policy: flGripRatePolicy,
      delay: flGripRatePolicyDelay
    };
  }

});

// register the binding so Shiny knows it exists
Shiny.inputBindings.register(flGripDialBinding);
