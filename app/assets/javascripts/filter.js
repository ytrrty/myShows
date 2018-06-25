$(document).ready(function () {

  var filter = debounce(function () {
    var params = $('#form').serialize();
    history.pushState(null, '', '?' + params);
    $.get("/shows/list", params, function (data) {
      $('#content').html(data);
    });
  }, 250);


  $('#form input[type=text]').keyup(filter);
  $('#form select').add('#form input[type=checkbox]').change(filter);

  function debounce(a, b, c) {
    var d;
    return function () {
      var e = this, f = arguments;
      clearTimeout(d), d = setTimeout(function () {
        d = null, c || a.apply(e, f)
      }, b), c && !d && a.apply(e, f)
    }
  }

});
