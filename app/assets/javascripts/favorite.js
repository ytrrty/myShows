$(document).ready(function () {
  $("label.bookmarks").change(function() {
    $.post('/shows/' + $(this).data('id') + '/to_favorite', {
      favorite: $(".bookmarks input").prop('checked')
    });
  });
});
