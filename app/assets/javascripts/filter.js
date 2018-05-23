$(document).ready(function () {
    $('#form').submit(function(){
        $.ajax({
            type: "get",
            url: "shows",
            data: {
                order: $("#order").val(),
                genre: $("#genre").val(),
                page: $("#page").val(),
                search: $("#search").val()
            },
            success: function(data){
                data = $(data);
                $("#content").html($('#shows', data).html());
            }
        });
        return false;
    });
});
