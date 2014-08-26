(function() {
  var eventSearch, eventShow, ready, toggleStar;

  ready = function() {
    $('.view-type.selected').fadeIn().removeClass('hidden');
    $('.navbar-lower').addClass('affix-top');
    $(window).on('affix.bs.affix', function() {
      return $("body").css("padding-top", 125);
    });
    $(window).bind('scroll', function() {
      var position;
      position = $(window).scrollTop() - $('.navbar-lower').position().top;
      if (position < 0) {
        return $("body").css("padding-top", 100);
      }
    });
    $('.event-link a').hover(function() {
      return eventSearch(this.id);
    });
    $('.calendar-day-box').mouseenter(function() {
      return toggleStar(this);
    });
    return $('.calendar-day-box').mouseleave(function() {
      return toggleStar(this);
    });
  };

  toggleStar = function(object) {
    $(object).find(".calendar-number").toggle();
    return $(object).find("i").toggle();
  };

  eventSearch = function(id) {
    return $.ajax('/events/' + id, {
      type: 'GET',
      dataType: 'json',
      success: function(data, textStatus, jqXHR) {
        return eventShow(data);
      }
    });
  };

  eventShow = function(data) {
    var date, desc, img_url, regex_day, title, url;
    date = data.datetime;
    desc = data.desc;
    title = data.title;
    url = data.url;
    img_url = data.img_url;
    regex_day = date.match(/\d{4}(-\d{2}){2}/gm);
    $('.event-title').text(title);
    $('.event-desc').text(desc.replace(/(<([^>]+)>)/ig, ""));
    if (url !== null || url !== void 0) {
      $('.event-url').attr("href", url);
    }
    return $clamp($('.event-desc')[0], {
      clamp: 5
    });
  };

  $(document).ready(ready);

  $(document).on('page:load', ready);

}).call(this);
