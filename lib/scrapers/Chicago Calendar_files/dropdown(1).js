(function() {
  var ready;

  ready = function() {
    return $('#menu-dropdown-button').on('click', function() {
      console.log("button click");
      return $('#menu-dropdown').animate({
        height: 'toggle'
      });
    });
  };

  $(document).ready(ready);

  $(document).on('page:load', ready);

}).call(this);
