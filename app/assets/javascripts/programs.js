$(document).ready(function() {

  $( "ul.list-group.drop-true-program" ).sortable({
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

  $(".program-exercise-list").hide();
  $(".view-exercises").on("click", function(){
    $(".program-exercise-list").slideToggle("slow");
  })

  $(".store-fields").hide();
  $(".container").on("change", "#program_available_in_store", function(){
    if(wants_in_store(this)){
      $(".store-fields").show();
    } else {
      $(".store-fields").hide();
    }
  });
  function wants_in_store(element){
    return $(element).is(":checked")
  };

  $("#update-weight-metrics").on("click", function(){
    $("#current-weight-form").submit();
  });

});
