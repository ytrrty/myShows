$( function() {
    var a = function() {
        if (document.getElementById("switch").checked == true)
        { favorite_status = 1; }
        else
        { favorite_status = 0 }
        return favorite_status
    };

    $('.switch').on('change', function() {
        $.ajax({
            type: 'POST',
            url: window.location.pathname + '/favorite',
            data: {fav: a}
        });
    })
});