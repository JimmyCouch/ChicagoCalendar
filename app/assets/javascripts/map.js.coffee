

ready = ->
  windowHeight = $(window).height()
  mapTop = $('#map').offset().top
  $('#map').height(windowHeight - mapTop - 20)

  infowindow = new google.maps.InfoWindow
    content: "nothing yet"

  sidebar = new Sidebar("NULL")

  mapOptions = 
    zoom: 12
    center: new google.maps.LatLng(41.8781136, -87.6297982)
    mapTypeId: google.maps.MapTypeId.ROADMAP
  map = new google.maps.Map($('#map')[0], mapOptions)
  month = $('#current_date').text()
  date = Date.parse(month).toString('yyyy-MM-dd')


  if window.location.pathname == "/users/events"
    url = "/user_addresses?date="
  else
    url = "/addresses?date="

  $.ajax url + date,
    type: 'GET'
    dataType: 'json'
    error: (jqXHR, textStatus, errorThrown) ->
      alert errorThrown
    success: (data, textStatus, jqXHR) -> 
      events = data
      markers = []
      x = 0
      while x < events.length
        latlng = new google.maps.LatLng(events[x].lat, events[x].lng)
        marker = new google.maps.Marker(
          position: latlng
          map: map
          event: events[x]
        )
        markers.push marker

        x++
        add_marker_listeners markers

  add_marker_listeners = (markers) ->
    x = 0
    while x < markers.length
      marker = markers[x]
      google.maps.event.addListener marker, 'click', ->
        $('.about-box.selected').fadeIn().removeClass('hidden');
        view = 
          title: @.event.title
          date: Date.parse(@.event.datetime).toString('dddd MMMM dd yyyy H:mm')
          desc: @.event.desc
          url: @.event.id
        template = '<div class="info-window">
          <h3>{{title}}</h3>
          <br>
          <h4>{{date}}</h4>
          <p>More info: <a href="/events/{{url}}">Click Here</a></p>
          </div>'
        infowindow.setContent(Mustache.render(template, view))
        infowindow.open map, @
        sidebar.setContent(@.event)
        sidebar.render()
      x++




class Sidebar
  constructor: (event) ->
    @event = event
  setContent: (event) ->
    @event = event

  render: ->
    raw_date = Date.parse(@event.datetime)
    view =
      date: raw_date.toString("yyyy-MM-dd")
      day: raw_date.toString("dddd")
      month: raw_date.toString("MMMM")
      day_number: raw_date.toString("dd")

    date_template = '<time datetime="{{date}}" class="icon">
      <em>{{day}}</em>
      <strong>{{month}}</strong>
      <span>{{day_number}}</span>
      </time>'
    $('.event-icon').html(Mustache.render(date_template, view))




$(document).ready(ready)
$(document).on('page:load', ready)