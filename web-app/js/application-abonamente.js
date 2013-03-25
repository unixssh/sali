$('#abonamente-holder').modalmanager('loading');
function loadTable(){
    $.ajax({url:'/sali/abonamente/list', type:'POST'}).done(function(results){
        //Json -> template
        $('#abonamente-holder').html('').mustache('abonamente-table-template', results);
        $('#abonamente-holder').modalmanager('removeLoading');
    });
}

$(function(){
    /*Load templates in DOM and use it when done*/
    $.Mustache.load('/sali/template/abonamente').done(function(){
        loadTable();
    });

    $('.add-abonament').on('click', function(){
        $('#modal-abonament-nou').remove();
        $('body').mustache('modal-abonament-nou-template', {});
        $('#modal-abonament-nou').modal('show');
        $('#modal-abonament-nou').on('submit', '.form-add-abonament', function(){
            var form = $(this);
            form.find('button').button('loading');
            $.ajax({url:'/sali/abonamente/add', data:form.serialize(), type:'POST'}).then(function(){
                loadTable();
                $('#modal-abonament-nou').modal('hide');
            }, function(){form.find('button').button('reset');});

            return false;
        }).on('click', '#unlimited', function(){
           if($('#noInTotal').attr('disabled')) $('#noInTotal').removeAttr('disabled')
           else $('#noInTotal').attr('disabled', 'disabled')
           $('#noInTotal').val(0);
        });
        return false;
    });

    $('body').on('click', '.delete-abonament', function(){
        var id = $(this).data('id');
        bootbox.dialog('Esti sigur ca vrei sa stergi abonamentul?', [{
            "label" : "Sterge",
            "icon" : 'icon-trash icon-white',
            "class" : "btn-danger pull-right",
            "callback": function() {
                $.ajax({url:'/sali/abonamente/delete', data:{id:id}, type:'POST'}).done(function(response){
                    if(response.status) loadTable();
                    else bootbox.dialog('Abonamentul nu poate fi sters cat timp este asociat unui abonat.', [{"label" : "Ok", "class" : "pull-right"}], {header:'Eroare!'});
                });
            }
            }, {
                "label" : "Cancel",
                "class" : "btn pull-left"
        }], {header:'Confirma stergerea'});
        return false;
    });
});