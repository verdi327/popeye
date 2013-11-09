$(document).ready(function() {
  $('#new-workout-submit').click(function() {
    $('form#new_workout').submit();
  });

  $('#update-workout-submit').click(function() {
    $('form').submit();
  });

  function highlightErrors(){
    $("form .form-group").each(function(){
      if ( missingValue( $(this) ) ){
        addErrorClass( $(this) );
      }
    });
  }

  lockAllExercisesInitialWeight();
  if(errorsPresent()){highlightErrors()};
  function missingValue(formElement){
    var field_value = formElement.children().filter(":input").val();
    return field_value == null || field_value == ""
  }

  function lockAllExercisesInitialWeight(){
    $(".initial-weight").each(function(){
      var field = $(this);
      if(initialWeightExist(field)){
        field.attr("disabled", "disabled");
      }
    });
  }

  function initialWeightExist(element){
    return element.val() != ""
  }

  function addErrorClass(formElement){
    formElement.addClass("has-error")
  }

  function errorsPresent(){
    return $(".alert.alert-danger").length > 0
  }

  function exerciseTypeSelectBoxes(){
    return $("select");
  }

  function selectedValuesExists(){
    var exists = false
    exerciseTypeSelectBoxes().each(function(){
      if( $(this).val() != "" ) {exists = true}
    });
    return exists;
  }

  // make select sticky so that on form errors, the proper ajax calls are made
  if(selectedValuesExists()){
    exerciseTypeSelectBoxes().each(function(){
      fetchExerciseType( $(this) );
    });
  }

  $(".container").on("change", ".exercise-type", function(){
    var element = $(this);
    fetchExerciseType(element);
  });

  function fetchExerciseType(element){
    var nested_exercise_id = element.attr("id").match(/(\d+)/)[0]
    if(element.val() != ""){
      $.ajax({
        type: "GET",
        url: "/exercises/display_specific_attributes",
        data: {type: element.val(), id: nested_exercise_id},
        dataType: "html",
      })
        .done(function(html){
          addExerciseType( element.parent().parent(), html );
          if(errorsPresent()){highlightErrors()};
        });
      }
  }

  function addExerciseType(parent, content) {
    if (parent.children().length == 4) {
      parent.append(content);
    }
    else{
      parent.children(":last-child").replaceWith(content);
    }
  }

  $("#new_workout").on("click", ".preview", function(){
    var id = $(this).data("id");
    var liftDetails = getLiftDetails(id);
    var all_values_present = _.every(_.values(liftDetails), function(num) {return num != "" })

    if(all_values_present){
      var result = previewRoutine(liftDetails);
      $("span.ascending").html(result.ascending);
      $("span.descending").html(result.descending);
    }
    else{
      $("span.ascending").html("please fill in the above four fields");
      $("span.descending").html("please fill in the above four fields");
    }
    return false;
  });

  function getLiftDetails(id){
    var keys = ["sets", "start_rep", "delta_rep", "delta_weight", "start_weight"]
    var values = [];
    $(".pyramid_" + id).each(function(){
      values.push($(this).val());
    });
    // add the initial weight, which is not a pyramid specific trait so cannot get from above loop
    values.push( $("#" + "workout_exercises_attributes_" + id + "_initial_weight").val() );
    return createHash(keys, values);
  }

  function createHash(arr1, arr2) {
    var hash = {};
    var length = arr1.length;
    _(length).times(function(num){
      hash[arr1[num]] = arr2[num];
    });
    return hash;
  }

  function previewRoutine(lift_details){
    var sets            = parseInt(lift_details.sets);
    var start_rep       = parseInt(lift_details.start_rep);
    var start_weight    = parseInt(lift_details.start_weight);
    var delta_rep       = parseInt(lift_details.delta_rep);
    var delta_weight    = parseInt(lift_details.delta_weight);
    var descending      = [ [start_rep, start_weight] ];
    var ascending       = [ [start_rep, start_weight] ];
    _(sets-1).times(function(num){
      ascending.push([ (ascending[num][0] + delta_rep), (ascending[num][1] - delta_weight) ]);
      descending.push([ (descending[num][0] - delta_rep), (descending[num][1] + delta_weight) ]);
    });
    descending = prepareForPreview(descending);
    ascending  = prepareForPreview(ascending);
    return {ascending: ascending, descending: descending}
  }

  function prepareForPreview(array){
    var temp =  _.map(array, function(pair){return pair[0] + "@" + pair[1];} )
    return ( "(" + temp.join(" | ") + ")" )
  }
});

