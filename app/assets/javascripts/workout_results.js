$(document).ready(function() {
  $('#new-workout-result-submit').click(function() {
    $('form#new_workout_result').submit();
  });

  $(".result-field").on("click", function(){
    decrementReps($(this));
    updateHiddenField($(this));
  });

  function decrementReps(element){
    if( element.text() == "" ){
      element.text( element.data("reps") );
    }
    else{
      var reps = parseInt(element.text());
      if(reps == 0){
        element.text( element.data("reps") );
      }
      else{
        element.text(reps - 1);
      }
    }
  }

  function updateHiddenField(element){
    var completedReps = element.text();
    var exerciseId = element.data("exercise-id");
    var liftId = element.data("lift-id");
    $("#workout_result_exercise_results_attributes_" + exerciseId + "_lift_results_attributes_" + liftId + "_reps").val(completedReps);
  }
});