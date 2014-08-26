
ready = ->
	lat = $('#event-lat').text()
	lng = $('#event-lng').text()
	date = $('#event-date').text()
	mapOptions = 
	  zoom: 14
	  center: new google.maps.LatLng(lat, lng)
	  mapTypeId: google.maps.MapTypeId.ROADMAP
	map = new google.maps.Map($('.event-map-large')[0], mapOptions)
	latlng = new google.maps.LatLng(lat, lng)
	marker = new google.maps.Marker(
	  position: latlng
	  map: map
	)
	raw_date = Date.parse(date)
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