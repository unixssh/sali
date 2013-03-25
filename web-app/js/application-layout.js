$(function () {
    /*Activate all Tool Tips*/
    $('.hasTooltip').tooltip();

    /*Boxes actions*/
    $('.box').on('click', '.btn-minimize', function () {
        /*Boxes action (minimize)*/
        element = $(this);
        $(this).parents('.box').find('.box-content').slideToggle('medium', function () {
            if ($(this).is(':visible')) element.find('i').removeClass('icon-chevron-down').addClass('icon-chevron-up');
            else element.find('i').removeClass('icon-chevron-up').addClass('icon-chevron-down');
        });

        return false;
    }).on('click', '.btn-close', function () {
        /*Boxes action (close)*/
        $(this).parents('.box').fadeOut('medium');
        return false;
    });
});

function paginate(element, pages, currPage){
    var pagination = '';

    if (pages > 1) {
        pagination+='<ul>';
        if (pages > 5) {
            pagination += '<li><a class="' + (currPage < 2 ? 'hide' : '') + '" href="#" data-page="' + (currPage > 1 ? currPage - 1 : 1) + '">&laquo;</a></li>';
            for (var i = (currPage > 3 ? (currPage > pages - 2 ? (currPage == pages ? pages - 4 : currPage - 3) : currPage - 2) : 1); i <= ((currPage + 2) < pages ? ((currPage + 2) < 5 ? 5 : currPage + 2) : pages); i++) {
                pagination += '<li id="pag-' + i + '" ' + (i == currPage ? 'class="active"' : '') + '><a href="#" data-page="' + i + '">' + i + '</a></li>';
            }
            pagination += '<li><a class="' + (currPage >= pages - 2 ? 'hide' : '') + '" href="#" data-page="' + (currPage < pages ? currPage + 1 : pages) + '">&raquo;</a></li></ul>';
        }else{
            for (var i = 1; i <=pages; i++) {
                pagination += '<li id="pag-' + i + '" ' + (i == currPage ? 'class="active"' : '') + '><a href="#" data-page="' + i + '">' + i + '</a></li>';
            }
        }
        pagination += '</ul>';
    }

    element.html(pagination);
}

var delay = (function(){
    var timer = 0;
    return function(callback, ms){
        clearTimeout (timer);
        timer = setTimeout(callback, ms);
    };
})();

var throwMessage = function(type, message){
    $('#page-message').slideUp('fast', function(){
        $(this).html('<div class="alert alert-'+type+' marginbottom0"><button type="button" class="close" data-dismiss="alert">&times;</button>'+message+'</div>');
        $(this).slideDown('slow');
    });
}