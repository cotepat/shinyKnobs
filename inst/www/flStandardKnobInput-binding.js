// this object that tells Shiny how to identify instances of our component and how to interact with them
var flStandardKnobBinding = new Shiny.InputBinding();

var flKnobRatePolicy;
var flKnobRatePolicyDelay;

// add methods to it using jQuery's extend method
$.extend(flStandardKnobBinding, {

  find: function(scope) {
    // find all instances of class fl-knob
    return $(scope).find(".fl-knob");
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
      var indicatorDot = $(el).data("indicatordot");
      var indicatorRingType = $(el).data("indicatorringtype");
      var color = $(el).data("color");
      color = typeof color !== 'undefined' ? color : colors.default.str;
      flKnobRatePolicy = typeof($(el).data("globalratepolicy")) !== 'undefined' ? $(el).data("globalratepolicy") : flKnobRatePolicy;
      flKnobRatePolicyDelay = typeof($(el).data("globalratepolicydelay")) !== 'undefined' ? $(el).data("globalratepolicydelay") : flKnobRatePolicyDelay;

     eval("var knob" +
          el.id +
          "  = new FLStandardKnob(el, { " +
          "step: " + step +
          ", min: " + min +
          ", max: " + max +
          ", initial: " + initial +
          ", dragResistance: " + dragResistance +
          ", wheelResistance: " + wheelResistance +
          ", indicatorDot: " + indicatorDot +
          ", indicatorRingType: '" + indicatorRingType + "'" +
          ", color: '" + color + "'" +
          "})");

          el.style.width = typeof width === 'number' ? 'auto' : width;

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

    // get the value from bootstrapSwitch
    var value = $(el)[0].querySelector(".knob-input__input").value;

    return value;
  },

  // see http://bootstrapswitch.com/events.html
  subscribe: function(el, callback) {
    // trigger the getValue method and send the value to shiny
    $(el.querySelector(".knob-input__input")).on('change.knob-input__input', function(event){
      //console.log(event);
      // callback which will tell Shiny to retrieve the value via getValue

      //when callback is true, uses getflKnobRatePolicy()
      var useflKnobRatePolicy = (flKnobRatePolicy === 'throttle' || flKnobRatePolicy === 'debounce');
      callback(useflKnobRatePolicy);
    });
  },

  unsubscribe: function(el) {
    $(el.querySelector(".knob-input__input")).off("change.knob-input__input");
  },

    // The input rate limiting policy
  getRatePolicy: function() {

    return {
      // Can be 'debounce' or 'throttle'
      policy: flKnobRatePolicy,
      delay: flKnobRatePolicyDelay
    };
  }

});

// register the binding so Shiny knows it exists
Shiny.inputBindings.register(flStandardKnobBinding);
