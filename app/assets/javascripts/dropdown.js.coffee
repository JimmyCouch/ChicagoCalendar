ready = ->
  $('.alert').hide().slideDown(1000).delay(1000).slideUp(1000)

  $('#menu-dropdown-button').on 'click', ->
    console.log "button click"
    $('#menu-dropdown').animate({height:'toggle'});

$(document).ready(ready)
$(document).on('page:load', ready)