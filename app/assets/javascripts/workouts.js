$(document).ready(function() {
  $('#new-workout-submit').click(function() {
    $('form#new_workout').submit();
  });

  $('#update-workout-submit').click(function() {
    $('form').submit();
  });

  $("form .form-group").each(function(){
    if ( missingValue( $(this) ) ){
      addErrorClass( $(this) );
    }
  });

  function missingValue(formElement){
    return formElement.children().filter(":input").val() == null
  }

  function addErrorClass(formElement){
    formElement.addClass("has-error")
  }

  $("#new_workout").on("change", ".exercise-type", function(){
    var element = $(this)
    var nested_exercise_id = element.attr("id").match(/(\d+)/)[0]
    if(element.val() != ""){
      $.ajax({
        type: "GET",
        url: "/exercises/display_specific_attributes",
        data: {type: element.val(), id: nested_exercise_id},
        dataType: "html",
      })
        .done(function(html){
          addExerciseType( element.parent().parent(), html )
        });
      }
  });

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
    var all_values_present = _.every(liftDetails, function(num) {return num != "" })

    if(all_values_present){
      liftDetails = _.map(liftDetails, function(num){return parseInt(num);});
      var result = previewRoutine(liftDetails);
      $("span.ascending").html("(" + result.ascending.join("x") + ")");
      $("span.descending").html("(" + result.descending.join("x") + ")");
    }
    else{
      $("span.ascending").html("please fill in all of the above three fields");
      $("span.descending").html("please fill in all of the above three fields");
    }
    return false;
  });

  function getLiftDetails(id){
    var values = [];
    $(".pyramid_" + id).each(function(){
      values.push($(this).val());
    });
    return values;
  }

  function previewRoutine(lift_details){
    var sets = lift_details[0];
    var start_num = lift_details[1];
    var delta = lift_details[2];
    var descending = [start_num]
    var ascending = [start_num]
    _(sets-1).times(function(num){
      descending.push(descending[num] - delta);
      ascending.push(ascending[num] + delta);
    });
    return {ascending: ascending, descending: descending}
  }
});

