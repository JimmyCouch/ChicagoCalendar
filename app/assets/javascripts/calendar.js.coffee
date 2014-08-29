# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



ready = ->
  mapOptions = 
    zoom: 14
    center: new google.maps.LatLng(0, 0)
    mapTypeId: google.maps.MapTypeId.ROADMAP
  modal_map = new google.maps.Map($('.modal-map')[0], mapOptions)
  event_map = new google.maps.Map($('.event-map')[0], mapOptions)
  $('.view-type.selected').fadeIn().removeClass('hidden');
  $('.event-map').hide()
  $('.navbar-lower').addClass('affix-top')

  $(window).on 'affix.bs.affix', ->
    $("body").css("padding-top", 100)
  $(window).bind 'scroll', ->
    position =  $(window).scrollTop() - $('.navbar-lower').position().top 
    console.log position
    $("body").css("padding-top", 75) if position < -30
  $('.event-link a').hover ->
    $('.event-map').show()
    eventSearch @id
  $('.day-event').hover ->
    $('.event-map').show()
    eventSearch @id
  $('.calendar-day-box').mouseenter ->
    toggleStar @
  $('.calendar-day-box').mouseleave ->
    toggleStar @


  toggleStar = (object) ->
    $(object).find(".calendar-number").toggle()
    $(object).find("i").toggle()
    $(object).find(".calendar-icon-box").toggle()


  eventSearch = (id) ->
    $.ajax '/events/'+id,
      type: 'GET'
      dataType: 'json'
      success: (data, textStatus, jqXHR) ->
        eventShow data

  eventShow = (data) ->
    $('.about-box.selected').fadeIn().removeClass('hidden');
    date = data.datetime
    desc = data.desc
    title = data.title
    url = data.url
    img_url = data.img_url
    lat = data.lat
    lng = data.lng
    id = data.id

    regex_day = date.match(/\d{4}(-\d{2}){2}/gm)

    $('.event-title').text title
    $('.event-desc').text desc.replace(/(<([^>]+)>)/ig,"")
    #$('.event-time').text "Time: " + time if time != null
    #$('.event-date').text regex_day
    if url != null || url != undefined
      $('.event-url').attr("href",url)
    $('.about-box-more').show()
    $('a.calendar-more-info-button').attr("href","/events/"+ id)

    $clamp($('.event-title')[0], {clamp: 2});
    $clamp($('.event-desc')[0], {clamp: 5});
    eventOptions = 
      zoom: 14
      center: new google.maps.LatLng(lat, lng)
      mapTypeId: google.maps.MapTypeId.ROADMAP
    google.maps.event.trigger(event_map, 'resize');
    event_map.setOptions(eventOptions)
    latlng = new google.maps.LatLng(lat, lng)
    marker = new google.maps.Marker(
      position: latlng
      map: event_map
    )


  $('.event-map').on "click", ->
    $('#map-modal').modal('show')

  $('#map-modal').on 'shown.bs.modal', ->
    LatLng = event_map.getCenter()
    modalOptions = 
      zoom: 14
      center: LatLng
      mapTypeId: google.maps.MapTypeId.ROADMAP
    marker = new google.maps.Marker(
      position: LatLng
      map: modal_map
    )
    google.maps.event.trigger(modal_map, 'resize');
    modal_map.setOptions(modalOptions)
    

$(document).ready(ready)
$(document).on('page:load', ready)
