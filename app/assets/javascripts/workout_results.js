$(document).ready(function() {
  $(".result-field").on("click", function(){
    if( $(this).text() == "" ){
      $(this).text( $(this).data("reps") );
    }
    else{
      var reps = parseInt($(this).text());
      if(reps == 0){
        $(this).text( $(this).data("reps") );
      }
      else{
        $(this).text(reps - 1);
      }
    }
  });
});