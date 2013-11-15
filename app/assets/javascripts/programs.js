$(document).ready(function() {
  $(".workout").draggable({
    containment: ".container",
    cursor: "move"
  })

  $(".drop-area").droppable({
    drop: handleDropEvent
  })

  function handleDropEvent(event, ui){
    alert( "just dropped" );
  }

})
