$(document).ready(function() {
  $('#new-exercise-submit').one("click", function() {
    $(this).attr('disabled','disabled');
    $('form#new_exercise').submit();
  });

  $('#update-exercise-submit').one("click", function() {
    $(this).attr('disabled','disabled');
    $('form').submit();
  });
});