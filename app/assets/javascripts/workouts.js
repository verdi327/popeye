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

  if(errorsPresent()){highlightErrors()};
  function missingValue(formElement){
    var field_value = formElement.children().filter(":input").val();
    return field_value == null || field_value == ""
  }

  function addErrorClass(formElement){
    formElement.addClass("has-error")
  }

  function errorsPresent(){
    return $(".alert.alert-danger").length > 0
  }

  // TODO auto increment sets
  // $("#new_workout").on("click", ".add-lift-detail", function(){
  //   var index = $(this).data("association-insertion-template").match(/\[([0-9]+)\]/)[1];
  // });
});

