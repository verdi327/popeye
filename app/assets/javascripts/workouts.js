$(document).ready(function() {

  // TODO auto increment sets
  // $("#new_workout").on("click", ".add-lift-detail", function(){
  //   var index = $(this).data("association-insertion-template").match(/\[([0-9]+)\]/)[1];
  // });

  // new workout form
  $( "ul.list-group.drop-true-workout" ).sortable({
    connectWith: "ul",
    dropOnEmpty: true,
    receive: updatePlaceholder
  });

  $( "#workout-list, #exercise-list" ).disableSelection();

  function updatePlaceholder(event, ui){
    var placeholder = $(".placeholder").length == 1;
    var noPlaceholder = $(".placeholder").length == 0;
    var workoutListEmpty = $("#workout-list").children().length == 0;
    if(placeholder){
      $(".placeholder-text").remove();
      $("#workout-list").removeClass("placeholder");
    }
    if(workoutListEmpty && noPlaceholder){
     $("#workout-list").addClass("placeholder");
     $("#workout-list").append("<li class='placeholder-text'>Add Exercises Here</li>");
    }
  }

  function grabExerciseIds(){
    var ids = ""
    $("#workout-list").children().each(function(){
      id = $(this).data("id") + "_";
      ids += id;
    })
    return ids;
  }

  function noExerciseIds(ids){
    return /undef/.test(ids);
  }

  $("#new-workout-submit").on("click", function(){
    var exercise_ids = grabExerciseIds();
    if(noExerciseIds(exercise_ids)){
      alert("Need to add at least 1 exercise first!");
    } else{
      $(this).attr('disabled','disabled');
      $("#workout_exercise_ids").val(exercise_ids);
      $("form#new_workout").submit();
    }
  });
  // end
});

