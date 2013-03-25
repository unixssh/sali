/**
 *-------------------------------------------------- Helper Functions (webcam upload and File upload)
 * ==================================================================================================
 */
/*Webcam Upload*/
function triggerWebCam(modal, id){
    modal.find('.modal').remove();
    modal.find('.modal-body').mustache('upload-foto-webcam');
    $('#modal-abonat-foto-webcam').modal('show');
    $('#modal-abonat-foto-webcam').on('shown', function(){
        $('#modal-abonat-foto-webcam').find('.photoUpload').photobooth().on("image",function(event, dataUrl){
            if(id){
                $('#modal-abonat-foto-webcam').find('.photoUpload').find('.loading').addClass('white').fadeIn();
                $.ajax({url:'/sali/abonati/uploadFoto', data:{id:id, dataImg:dataUrl}, type:'POST'}).then(function(){
                    modal.find('.userAvatar').each(function(){$(this).attr('src', dataUrl);})
                    $('#modal-abonat-foto-webcam').find('.cancel:first').click();
                },function(){
                    $('#modal-abonat-foto-webcam').find('.cancel:first').click();
                });
            }else{
                modal.find('.userAvatar').each(function(){$(this).attr('src', dataUrl);});
                modal.find('input.foto').val(dataUrl);
                $('#modal-abonat-foto-webcam').find('.cancel:first').click();
            }
        });

        //Resize and fix
        $('#modal-abonat-foto-webcam').find('.photoUpload').data( "photobooth" ).resize(520, 390, 130);
        $('#modal-abonat-foto-webcam').find('.photoUpload').find('.resizehandle').remove();

        //Register some actions
        $('#modal-abonat-foto-webcam').on('click', '.cancel', function(){
            $('#modal-abonat-foto-webcam').find('.photoUpload').data("photobooth").destroy();
            $('#modal-abonat-foto-webcam').modal('hide');
            return false;
        });

        //Make a foto
        $('#modal-abonat-foto-webcam').on('click', '.capture', function(){
            $(this).button('loading');
            $('#modal-abonat-foto-webcam').find('.photoUpload').find('.trigger:first').click();
            return false;
        });
    });
}

/*Browse upload*/
function triggerBrowse(modal, id){
    modal.find('.modal').remove();
    modal.find('.modal-body').mustache('upload-foto-browse', {id:id});
    $('#photoBrowse').fileupload({uploadType:'image', name: 'foto', crop: 390});
    $('#modal-abonat-foto-browse').modal('show');
    $('#modal-abonat-foto-browse').on('shown', function(){
        $('#modal-abonat-foto-browse').on('click', '.change-foto', function(){
            $('#modal-abonat-foto-browse').find('#foto2Upload').trigger('click');
            return false;
        }).on('click', '.capture', function(){
            if($('#modal-abonat-foto-browse').find('.fileupload-preview').find('img').size()){
                $(this).button('loading');
                var dataUrl = $('#modal-abonat-foto-browse').find('.fileupload-preview').find('img').attr('src');
                if(id){
                    $.ajax({url:'/sali/abonati/uploadFoto', data:{id:id, dataImg:dataUrl}, type:'POST'}).then(function(){
                        modal.find('.userAvatar').each(function(){$(this).attr('src', dataUrl);})
                        $('#modal-abonat-foto-browse').modal('hide');
                    },function(){
                        $('#modal-abonat-foto-browse').modal('hide');
                    });
                }else{
                    modal.find('.userAvatar').each(function(){$(this).attr('src', dataUrl);});
                    modal.find('input.foto').val(dataUrl);
                    $('#modal-abonat-foto-browse').modal('hide');
                }
            }else $('#modal-abonat-foto-browse').modal('hide');
            return false;
        });
    });
}


/**
 *-------------------------------------------------- Add new User Modal
 * ====================================================================
 */
function makeAddAbonatModal(){
    $('#modal-add-abonat').remove();
    $('body').mustache('add-abonat-modal-template', {});

    //------------- Activate elements -------------------------//
    $('#modal-add-abonat').modal('show');
    $('#modal-add-abonat').find('.datepick').datepicker({format:'dd-mm-yyyy', weekStart:1, startView:2, startDate:Date.today().add({years:-80}), date:Date.today().add({years:-20}), endDate:Date.today().add({years:-1}), autoclose:true});
    $('.hasTooltip').tooltip();

    //------------- Register some actions -------------------------//
    $('#modal-add-abonat').on('click', '.change-foto', function(){
        //Photo change
        triggerWebCam($('#modal-add-abonat'));
        return false;
    }).on('click', '.browse-foto', function(){
        //Browse for foto with webcam
        triggerBrowse($('#modal-add-abonat'));
        return false;
    }).on('submit', '.add-user-form', function(){
        var form = $(this), data = form.serialize();
        form.find('button').button('loading');
        $.ajax({url:'/sali/abonati/addAbonat', data:data, type:'POST'}).then(function(response){
            if (response.status){
                var user = form.serializeObject();
                refreshUserTable();
                $('#modal-add-abonat').modal('hide');
                throwMessage('success', 'Abonatul <strong>'+user.name+'</strong> a fost adaugat.');
            }else{
                form.find('button').button('reset');
                var error = 'Campurile: <strong>'
                delete response.status;
                $.map(response, function(i,j){
                    form.find('input[name="'+j+'"]').val('');
                    error += j+', ';
                });
                error = error.slice(0, -2);
                error +='</strong> nu sunt corecte.'
                form.find('.error').html('<div class="alert alert-error"><button type="button" class="close" data-dismiss="alert">&times;</button> '+error+'</div>');
            }
        }, function(){
            form.find('button').button('reset');
        });

        return false;
    });
}


/**
 *-------------------------------------------------- Find User Modals
 * ====================================================================
 */
/*User data into modal*/
function makeAbonatModal(id){
/*=========================Closure Functions=========================*/
    //Global
    function registerGlobal(id){
        $('#modal-abonat-details').on('click', '.change-foto', function(){
            //Change foto with webcam
            triggerWebCam($('#modal-abonat-details'), id);
            return false;
        }).on('click', '.browse-foto', function(){
                //Browse for foto with webcam
                triggerBrowse($('#modal-abonat-details'), id);
                return false;
        }).on('click', '.more-details', function(){
            //Details btn
            $('#modal-abonat-details').find('.modal-navigation').find('li:eq(2) a').click();
            return false;
        }).on('click', '.delete', function(){
            //Delete btn
            bootbox.dialog('Esti sigur ca vrei sa stergi abonatul?', [{
                "label" : "Sterge",
                "icon" : 'icon-trash icon-white',
                "class" : "btn-danger pull-right",
                "callback": function() {
                    $.ajax({url:'/sali/abonati/deactivateAbonat', data:{id:id}, type:'POST'}).done(function(response){
                        if(response.status) modal.find('.close-modal:first').click();
                        else bootbox.dialog('Abonatul nu poate fi sters cat timp este in sala.', [{"label" : "Ok", "class" : "pull-right"}], {header:'Eroare!'});
                    });
                }
            }, {
                "label" : "Cancel",
                "class" : "btn pull-left"
            }], {header:'Confirma stergerea'});
            return false;
        }).on('click', '.close-modal', function(){
            refreshUserTable();
        });
    }

    //General
    function registerGeneral(id){
        $.ajax({url:'/sali/search/abonatGeneral', data:{id:id}, type:'POST'}).done(function(result){
            //Put data into model
            $('#abonat-general').mustache('abonat-modal-general', result, {method:'html'});

            /*=========================Register Actions=========================*/
            $('#modal-abonat-details').off('click', '.check-in').on('click', '.check-in', function(){
                var abonamentId = $(this).data('id');
                $.ajax({url:'/sali/abonati/AbonamentCheckIn', data:{id:abonamentId}, type:'POST'}).done(function(response){
                    $('#modal-abonat-details').find('.modal-navigation').find('li:eq(0) a').click();
                });
                return false;
            }).off('click', '.check-out').on('click', '.check-out', function(){
                var abonamentId = $(this).data('id');
                $.ajax({url:'/sali/abonati/AbonamentCheckOut', data:{id:abonamentId}, type:'POST'}).done(function(response){
                    $('#modal-abonat-details').find('.modal-navigation').find('li:eq(0) a').click();
                });
                return false;
            });
            
        });
    }

    //Abonamente
    function registerAbonamente(id){
        $.ajax({url:'/sali/search/abonatAbonamente', data:{id:id}, type:'POST'}).done(function(result){
            //Put data into model
            $('#abonat-abonamente').mustache('abonat-modal-abonamente', result, {method:'html'});

            $('#abonat-abonamente').off('click','.add-abonament').on('click','.add-abonament', function(){
                makeAbonatAbonamentModal($('#modal-abonat-details'), id);
                return false;
            }).off('click', '.istoric-abonament').on('click', '.istoric-abonament', function(){
                $('#modal-abonat-details').find('.modal').remove();

                $.ajax({url:'/sali/abonati/abonamentAbonatIstoric', data:{id:id}, type:'POST'}).done(function(response){
                    $('#modal-abonat-details').mustache('abonat-details-modal-abonament-istoric', response);
                    $('#modal-abonat-istoric').modal('show');
                })
            }).off('click', '.delete-abonament').on('click', '.delete-abonament', function(){
                var abonamentId = $(this).data('id');
                bootbox.dialog('Esti sigur ca vrei sa stergi abonamentul?', [{
                    "label" : "Sterge",
                    "icon" : 'icon-trash icon-white',
                    "class" : "btn-danger pull-right",
                    "callback": function() {
                        $.ajax({url:'/sali/abonati/deactivateAbonamentAbonat', data:{id:abonamentId}, type:'POST'}).done(function(response){
                            if(response!='0') $('#modal-abonat-details').find('.modal-navigation').find('li:eq(1) a').click();
                            else bootbox.dialog('Abonamentul nu poate fi sters cat timp utilizatorul il foloseste!', [{"label" : "Ok", "class" : "pull-right"}], {header:'Eroare!'});
                        });
                    }
                }, {
                    "label" : "Cancel",
                    "class" : "btn pull-left"
                }], {header:'Confirma stergerea'});
            });
            
        });
    }

    //Detalii abonat
    function registerDetalii(id){
        $.ajax({url:'/sali/search/abonatDetalii', data:{id:id}, type:'POST'}).done(function(result){
            //Put data into model
            result.user.sexWrapper = function(){return function(text){ return text.replace('value="' + this.user.sex+'"', 'value="' + this.user.sex+'" checked');}}
            $('#abonat-detalii').mustache('abonat-modal-detalii', result, {method:'html'});
            $('#abonat-detalii').find('.datepick').datepicker({format:'dd-mm-yyyy', weekStart:1, startView:2, startDate:Date.today().add({years:-80}), date:Date.today().add({years:-20}), endDate:Date.today().add({years:-1}), autoclose:true});

            $('#modal-abonat-details').off('submit', '.user-details-form').on('submit', '.user-details-form', function(){/*----------------User details actions--------------------------*/
                //Edit user details
                var form = $(this), data = form.serialize();
                form.find('button').button('loading');
                $.ajax({url:'/sali/abonati/updateAbonat', data:data, type:'POST'}).done(function(response){
                    if (response.status){
                        //TODO: Do some magic Here
                        $('#modal-abonat-details').find('.user-vCard').mustache('abonat-modal-vcard', {'user':form.serializeObject()}, {method:'html'});
                    }else{
                        //TODO: Throw an error here
                    }
                    form.find('button').button('reset');
                });

                return false;
            });
            
        });
    }

    //POS
    function registerPos(id) {
        //-----------------//
        
    }

    //Istoric
    function registerIstoric(id) {
        $.ajax({url:'/sali/search/abonatIstoric', data:{id:id}, type:'POST'}).done(function(result){
            //Put data into model
            $('#abonat-istoric').mustache('abonat-modal-istoric', result, {method:'html'});
            paginate($('#history-pag'), result.history.pages, 1);

            $('#modal-abonat-details').off('click', '#history-pag a').on('click', '#history-pag a', function(){ /*------------Istoric abonat -----------------*/
                var currPage = parseInt($(this).data('page'));

                $.ajax({url:'/sali/abonati/abonatIstoric', data:{page:currPage, id:id}, type:'POST'}).done(function(response){
                    $('#abonat-istoric').mustache('abonat-modal-istoric', response, {method:'html'})
                    paginate($('#history-pag'), response.history.pages, currPage);
                });

                return false;
            });
            
        });
    }

/*=========================Load the Template=========================*/
    $.Mustache.load('/sali/template/abonatTemplate').done(function(){
        $.ajax({url:'/sali/search/findUser', data:{id:id}, type:'POST'}).done(function(result){
            $('#modal-abonat-details').remove();
            $('body').mustache('abonat-modal', result);
            //------------- Show modal -------------------------//
            $('#modal-abonat-details').modal('show');
            $('.hasTooltip').tooltip();

            /*=========================Register Actions=========================*/
            /*Main nav*/
            $('#modal-abonat-details').on('click', '.nav-tabs a', function(){
                $('#modal-abonat-details').find('.tab-pane').html('');
                
                switch ($(this).data('page')){
                    case 'general':
                        registerGeneral(id);
                        break;


                    case 'abonamente':
                        registerAbonamente(id);
                        break;


                    case 'detalii':
                        registerDetalii(id);
                        break;


                    case 'pos':
                        registerPos(id);
                        break;


                    case 'istoric':
                        registerIstoric(id);
                        break;
                }
            });

            /*Persistent actions*/
            registerGlobal(id);
            $('#modal-abonat-details').find('.modal-navigation').find('li:eq(0) a').click();
        });
    });
}

/*Abonament 2 Abonat*/
function makeAbonatAbonamentModal(modal, id){
    modal.find('.modal').remove();
    modal.find('.modal-body').mustache('abonat-details-modal-abonament-nou', {id:id});

    //------------- Activate elements -------------------------//
    $('#modal-abonat-abonament-nou').modal('show');
    $('#modal-abonat-abonament-nou').find('.tip-abonament').select2({containerCssClass:'width100 marginbottom10px big-lineheight'});


    //------------- Register some actions -------------------------//
    $('#modal-abonat-abonament-nou').on('change', '.tip-abonament', function(){
        var selected = $(this).find('option:selected');
        var abonament = {'unlimited':selected.data('unlimited'), 'price':selected.data('price'), 'noInTotal':selected.data('nointotal'), 'description':selected.data('description')};
        $('#modal-abonat-abonament-nou').find('.abonament-details').slideUp('fast', function(){
            $(this).mustache('abonat-details-modal-abonament-nou-template', abonament, {method:'html'});
            $(this).find('.datepick').datepicker({format:'dd-mm-yyyy', weekStart:1, startView:0, startDate:Date.today(), autoclose:true, todayBtn: 'linked'});
            $(this).slideDown('fast');
        });
    }).on('submit', '.form-add-abonament', function(){
            var form = $(this), data = form.serialize();
            form.find('button').button('loading');
            $.ajax({url:'/sali/abonati/addAbonamentAbonat', data:data, type:'POST'}).then(function(response){
                $('#modal-abonat-details').find('.modal-navigation').find('li:eq(1) a').click();
                $('#modal-abonat-abonament-nou').modal('hide');
            }, function(){
                form.find('button').button('reset');
            });
            return false;
    }).on({
        'keyup':function(){
            var is_decimal = /^[0-9.]$/;
            if(!is_decimal.test($(this).val().substr(-1)) && $(this).val().substr(-1)) $(this).val($(this).val().slice(0, -1));
            else{
                //Value or between 0 - 100
                var discount = $(this).val()>=0 ? ($(this).val() >=100 ? 100 : parseFloat($(this).val())) : 0;
                var price = parseFloat($('#total-price').data('value')), finalPrice = price - (price * discount/100);

                $('#discount').val(discount);
                $('#total-price').val(finalPrice.toFixed(2));
                if(discount) $('#price-info').html(' ('+price+' - '+discount+'%)')
            }
        },
        'keydown': function(){
            var is_decimal = /^[0-9.]$/;
            if(!is_decimal.test($(this).val().substr(-1)) && $(this).val().substr(-1)) $(this).val($(this).val().slice(0, -1));
        },
        'focusin':function(){ $(this).val() <=0 ? $(this).val('') : $(this).val(parseFloat($(this).val())); },
        'focusout':function(){ $(this).val() ? $(this).val(parseFloat($(this).val())) : $(this).val(0); }
    }, '#discount');
}

//Register Functions
$(function(){
    /*Load templates in DOM for later use*/
    $.Mustache.load('/sali/template/templates');

    /* Trigger user details modal */
    $('body').on('click', '.user-details', function(){
        makeAbonatModal($(this).data('id'));
        return false;
    }).on('click', '.add-user', function(){
        makeAddAbonatModal();
        return false;
    });
});
