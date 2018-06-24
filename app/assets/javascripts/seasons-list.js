var iframe;

$(document).ready(function () {
  $(".watched.episode").change(function () {
    var watched = $(this).find('input')[0].checked;
    $.post('/episodes/mark_as_watched', { id: $(this).data('id'), watched: watched });
  });

  $(".watched.season").change(function () {
    var episodes = $(this).parent().next().find('input');
    var watched = $(this).find('input')[0].checked;

    episodes.attr('checked', watched);
    $.post('/episodes/mark_as_watched', { id: $(this).data('id'), watched: watched });
  });

  $('span.toggle-films').on('click', function (e) {
    e.preventDefault();
    var _iframe_place = $(this).parents('tr').next().find('.films-inner-ct');
    var _all_iframes =  $('iframe');

    if ($(this).hasClass('opened')) {
      $(this).removeClass('opened');
      _iframe_place.slideUp(300);
      _all_iframes.remove();
      return;
    }

    $('span.toggle-films').removeClass('opened');
    _all_iframes.remove();
    $('.films-inner-ct').slideUp(300);

    _iframe_place.slideDown(300);

    $(this).toggleClass('opened');
    iframe = document.createElement('iframe');
    $(iframe).attr({
      id: 'cdn-player',
      src: $(this).data('src'),
      width: 640,
      height: 445,
      frameborder: 0,
      allowfullscreen: '',
      webkitallowfullscreen: '',
      mozallowfullscreen: '',
      oallowfullscreen: '',
      msallowfullscreen: ''
    });

    _iframe_place.append(iframe);
  });
});
