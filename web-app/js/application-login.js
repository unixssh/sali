$(function () {
    $('#btn-forgot').on('click', function () {
        var email = $('#email-forgot').val();
        var $modal = $(this).parents('.modal');

        //local error function
        function err(message) {
            //throw error if not exist
            if (!$modal.find('.alert-error').size()) {
                $modal.find('.modal-body').append('<div class="alert alert-error"><button type="button" class="close" data-dismiss="alert">×</button><span>' + message + '</span></div>');
                $modal.find('.control-group').addClass('error');
                $modal.find('.alert-error').bind('closed', function () {
                    $modal.find('.control-group').removeClass('error');
                });
            } else if (message != $modal.find('.alert-error').find('span').text()) $modal.find('.alert-error').find('span').html(message);
        }

        if (email_pattern.test(email)) {
            $.ajax({
                url: '',
                type: 'POST',
                data: {
                    email: email
                },
                beforeSend: function () {
                    $modal.modal('loading');
                }
            }).done(function (response) {
                    //throw succes message
                    if (response) {
                        $modal.find('.modal-body').html('<div class="alert alert-info">Un e-mail cu noua parola a fost trimis la adresa <strong>' + email + '</strong></div>');
                        $('#btn-forgot').off('click').on('click', function () {
                            $modal.modal('toggle');
                        });
                    } else err('Parola nu a putut fi trimisa.');
                    $modal.modal('loading');
                });
        } else err('Adresa de e-mail invalida: <strong>' + email + '</strong>');

        return false;
    });
});

// ============ General Scripts ============

//reposition the login Area on the center for small devices
function reposition() {
    var element = $("#content");
    if ($(window).height() <= (element.outerHeight() + 200)) {
        element.removeClass('margintop100px');
        var margin = parseInt(($(window).height() - element.outerHeight()) / 2);
        margin = margin < 0 ? 0 : margin;
        element.css({
            'margin-top': margin
        });
    } else {
        element.addClass('margintop100px');
        element.css({
            'margin': ''
        });
    }
}

$(function () {
    reposition();
});

$(window).resize(function () {
    reposition();
});