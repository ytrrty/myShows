$(document).ready(function () {
  $("label.bookmarks").change(function () {
    $.post('/shows/' + $(this).data('id') + '/to_favorite', {
      favorite: $(".bookmarks input").prop('checked')
    });
  });

  $(document).on('click', '.comment-feedback-link', function (e) {
    e.preventDefault();
    $('#'+$(this).data('comment')).slideDown(300);
    $(this).slideUp(300);
  })
});
