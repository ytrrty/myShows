$( document ).ready(function() {
  $('.switch').on('change', function () {
    $.post({
      url: '/shows/' + '' + '/to_favorite',
      data: {
        favorite: $("#switch").checked
      }
    });
  });

  $(".heart.fa").click(function() {
    $(this).toggleClass("fa-heart fa-heart-o");
  });
});
