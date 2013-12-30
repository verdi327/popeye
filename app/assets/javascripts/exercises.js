$(document).ready(function() {
  $('#new-exercise-submit').click(function() {
    $('form#new_exercise').submit();
  });

  $('#update-exercise-submit').click(function() {
    $('form').submit();
  });
});