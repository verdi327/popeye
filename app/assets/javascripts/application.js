// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.sidr
//= require cocoon
//= require jquery.ui.draggable
//= require jquery.ui.droppable
//= require jquery.ui.sortable
//= require jquery.ui.selectable
//= require_tree .


$(document).ready(function() {
  $('#simple-menu').sidr();

  if(errorsPresent()){highlightErrors()};

  function highlightErrors(){
    $("form .form-group").each(function(){
      if ( missingValue( $(this) ) ){
        addErrorClass( $(this) );
      }
    });
  }

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
});
