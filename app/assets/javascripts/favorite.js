$(document).ready(function () {
  $("label.bookmarks").change(function () {
    $.post('/shows/' + $(this).data('id') + '/to_favorite', {
      favorite: $(".bookmarks input").prop('checked')
    });
  });

  $(document).on('click', '.comment-feedback-link', function (e) {
    var reply_form = $('#' + $(this).data('comment'));
    e.preventDefault();
    reply_form.slideDown(300);
    reply_form.css('display', 'flex');
    $(this).slideUp(300);
  });

  $('.submit').click(function (e) {
    e.preventDefault();
    var _form = $(this).parent();
    var _action = _form.attr('action');
    var _id = $(this).data('target') || '#' + _form.attr('id');
    $(this).parent().attr('action', _action + _id).submit();
  })
});
