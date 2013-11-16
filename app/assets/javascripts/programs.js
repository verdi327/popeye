$(document).ready(function() {

  $( "ul.list-group.drop-true" ).sortable({
    connectWith: "ul",
    dropOnEmpty: true,
    receive: managePlaceholder
  });

  $( "#workout-list, #program-list" ).disableSelection();

  function managePlaceholder(event, ui){
    var placeholder = $(".placeholder").length == 1;
    var noPlaceholder = $(".placeholder").length == 0;
    var programListEmpty = $("#program-list").children().length == 0;
    if(placeholder){
      $(".placeholder-text").remove();
      $("#program-list").removeClass("placeholder");
    }
    if(programListEmpty && noPlaceholder){
     $("#program-list").addClass("placeholder");
     $("#program-list").append("<li class='placeholder-text'>Add Workouts Here</li>");
    }
  }

  function grabWorkoutIds(){
    var ids = ""
    $("#program-list").children().each(function(){
      id = $(this).data("id") + "_";
      ids += id;
    })
    return ids;
  }

  function noWorkoutIds(ids){
    return /undef/.test(ids);
  }

  $("#new-program-submit").on("click", function(){
    var workout_ids = grabWorkoutIds();
    if(noWorkoutIds(workout_ids)){
      alert("Need to add at least 1 workout first!");
    } else{
      $("#program_workout_ids").val(workout_ids);
      $("form#new_program").submit();
    }
  })

});
