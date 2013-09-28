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
});

