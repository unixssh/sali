$('#abonati-holder').modalmanager('loading');
/*Load table results*/
function loadResults(sorter, order, query){
    $.ajax({url:'/sali/abonati/lastUpdated', data:{sort:sorter, order:order, query:(query || null)}, type:'POST'}).done(function(results){
        //Json -> template
        $('#abonati-holder').html('').mustache('abonati-table-template', results);
        $('#abonati-holder').modalmanager('removeLoading');
    });
}

/*Refresh the user table if exists*/
function refreshUserTable(){
    if($('#abonati-holder').size()){
        $('.sortable').removeClass('asc').removeClass('desc').find('a').find('span').remove();
        $('#find-user').find('input').val('');
        loadResults('lastUpdated', 'desc');
    }
}

$(function(){
    /*Load templates in DOM and use it when done*/
    $.Mustache.load('/sali/template/abonati').done(function(){
        loadResults('lastUpdated', 'desc');
    });

    /*Sorting action*/
    $('.sortable').on('click', function(){
        var sorter = $(this).data('sort');
        var order = '';
        var query = $('#find-user').find('input').val();

        if(!$(this).hasClass('asc') && !$(this).hasClass('desc')){
            $('.sortable').removeClass('asc').removeClass('desc').find('a').find('span').remove();
            $(this).addClass('asc').find('a').append('<span>&nbsp; <i class="icon-chevron-up icon-white"></i></span>');
            order = 'asc';
        }else if($(this).hasClass('asc')){
            order = 'desc';
            $('.sortable').removeClass('asc').removeClass('desc').find('a').find('span').remove();
            $(this).addClass('desc').find('a').append('<span>&nbsp; <i class="icon-chevron-down icon-white"></i></span>');
        }else if($(this).hasClass('desc')){
            $('.sortable').removeClass('asc').removeClass('desc').find('a').find('span').remove();
            sorter = 'lastUpdated';
            order = 'desc';
        }

        loadResults(sorter, order, query);
    });

    $('#find-user').on('submit', function(){
        var query = $(this).find('input').val();
        $('#abonati-holder').modalmanager('loading');
        $('.sortable').removeClass('asc').removeClass('desc').find('a').find('span').remove();
        loadResults('lastUpdated', 'desc', query);
        return false;
    });
});