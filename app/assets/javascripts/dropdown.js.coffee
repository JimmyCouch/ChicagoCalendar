ready = ->
	$('#menu-dropdown-button').on 'click', ->
	  console.log "button click"
	  $('#menu-dropdown').animate({height:'toggle'});

$(document).ready(ready)
$(document).on('page:load', ready)