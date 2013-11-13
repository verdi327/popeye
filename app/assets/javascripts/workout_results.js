$(document).ready(function() {

  function initializeAudioApi(){
    var audio = new Audio();
    var context = new webkitAudioContext();
    var analyser = context.createAnalyser();
    var source = context.createMediaElementSource(audio);
    var audioSource = 'http://localhost:3000/ding.mp3';
    return {context: context, analyser: analyser, source: source, audio: audio, audioSource: audioSource};
  }

  function playAudio(){
    api = initializeAudioApi();
    api.source.connect(api.analyser);
    api.analyser.connect(api.context.destination);
    api.audio.src = api.audioSource;
    api.audio.play();
  }

  $(".container").on("click", "#new-workout-result-submit", function(){
    $('form').submit();
  })

  $(".container").on("click", "#update-workout-result-submit", function(){
    $("form").submit();
  })

  $(".timer").hide();
  var watch = new Stopwatch(updateDisplay, 50);

  $(".result-field").on("click", function(){
    decrementReps($(this));
    updateHiddenField($(this));
    if (notEditingForm()){
      manageTimerDisplay($(this));
      if(watchNotStarted()){
        manageStopWatch("start", watch);
      }
      else{manageStopWatch("restart", watch);}
    }
  });

  $(".container").on("click", ".close", function(){
    $(".timer").hide();
    manageStopWatch("reset", watch);
  });

  function notEditingForm(){
    return $(".edit").length == 0;
  }

  function manageTimerDisplay(element){
    if(liftUnsuccessful(element)){
      $(".timer .message").text("Failing Reps is Part of the Game");
      $(".timer .message").css("color", "#de6489" );
      $(".timer #watch-display").css("color", "#de6489" );
      $(".timer").css("border-color", "#de6489" );
    }
    else{
      $(".timer .message").text("Woot! Way to Get Your Reps In");
      $(".timer .message").css("color", "#7bc06e" );
      $(".timer #watch-display").css("color", "#7bc06e" );
      $(".timer").css("border-color", "#7bc06e" );
    }
  }

  function liftUnsuccessful(element){
    return element.text() != parseInt(element.data("reps"));
  }

  function watchNotStarted(){
    return $("#watch-display").text() == ""
  }

  function clearWatchDisplay(){
    $("#watch-display").text("");
  }

  function manageStopWatch(action, watch){
    if(action == "start"){
      $(".timer").show();
      watch.start();
    }
    else if(action == "reset"){watch.stop(); watch.reset(); clearWatchDisplay();}
    else if(action == "restart"){watch.restart();}
  }

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
    $("#workout_result_exercise_results_attributes_" + exerciseId + "_lift_results_attributes_" + liftId + "_achieved_reps").val(completedReps);
  }

  function updateDisplay(watch){
    var time = watch.toString();
    if(time == "01:30" || time == "03:00" || time == "05:00"){
      playAudio();
    }
    $("#watch-display").text(time);
  }

});