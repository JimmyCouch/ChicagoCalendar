# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



ready = ->
  $('.view-type.selected').fadeIn().removeClass('hidden');
  $('.navbar-lower').addClass('affix-top')
  $(window).on 'affix.bs.affix', ->
    $("body").css("padding-top", 150)
  $(window).bind 'scroll', ->
    position =  $(window).scrollTop() - $('.navbar-lower').position().top 
    $("body").css("padding-top", 100) if position < 0
  $('.event-link a').hover ->
    eventSearch @id
  $('.calendar-day-box').mouseenter ->
    toggleStar @
  $('.calendar-day-box').mouseleave ->
    toggleStar @


toggleStar = (object) ->
  $(object).find(".calendar-number").toggle()
  $(object).find("i").toggle()


eventSearch = (id) ->
  $.ajax '/events/'+id,
    type: 'GET'
    dataType: 'json'
    success: (data, textStatus, jqXHR) ->
      eventShow data

eventShow = (data) ->
  date = data.date
  desc = data.desc
  time = data.time
  title = data.title
  url = data.url

  regex_day = date.match(/\d{4}(-\d{2}){2}/gm)


  $('.event-title').text title
  $('.event-desc').text desc
  $('.event-time').text "Time: " + time if time != null
  #$('.event-date').text regex_day
  if url != null || url != undefined
    $('.event-url').attr("href",url)

  $clamp($('.event-desc')[0], {clamp: 5});



$(document).ready(ready)
$(document).on('page:load', ready)
