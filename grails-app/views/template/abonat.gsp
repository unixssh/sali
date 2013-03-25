<!DOCTYPE html>
<html lang="en">
<head></head>
<body>
<script id="abonat-modal" type="text/html">
    <div id="modal-abonat-details" class="modal hide fade" data-keyboard="false" data-backdrop="static" data-width="1000" data-height="550" data-id="{{user.id}}">
        <div class="modal-header"><button type="button" class="close close-modal" data-dismiss="modal" aria-hidden="true">×</button><h3>Detalii Abonat</h3></div>
        <div class="modal-body" >
            <div class="tabbable">
                <ul class="nav nav-tabs modal-navigation">
                    <li class="active"><a href="#abonat-general" data-toggle="tab" data-page="general"><i class="icon-th-list"></i>&nbsp;&nbsp;General</a></li>
                    <li><a href="#abonat-abonamente" data-toggle="tab" data-page="abonamente"><i class="icon-file"></i>&nbsp;&nbsp;Abonamente</a></li>
                    <li><a href="#abonat-detalii" data-toggle="tab" data-page="detalii"><i class="icon-user"></i>&nbsp;&nbsp;Detalii Abonat</a></li>
                    <li><a href="#abonat-pos" data-toggle="tab" data-page="pos"><i class="icon-shopping-cart"></i>&nbsp;&nbsp;Pos</a></li>
                    <li><a href="#abonat-istoric" data-toggle="tab" data-page="istoric"><i class="icon-time"></i>&nbsp;&nbsp;Istoric</a></li>
                </ul>
                <div class="row-fluid">
                    <div class="span4">
                        <div class="thumbnail well user-vCard marginbottom0">
                            {{>abonat-modal-vcard}}
                        </div>
                    </div>

                    <div class="span8">
                        <div class="tab-content">
                            %{--Check in & Check out tab--}%
                            <div id="abonat-general" class="tab-pane active">
                                {{>abonat-modal-general}}
                            </div>

                            <div id="abonat-abonamente" class="tab-pane"></div>

                            <div id="abonat-detalii" class="tab-pane"></div>

                            <div id="abonat-pos" class="tab-pane"></div>

                            <div id="abonat-istoric" class="tab-pane"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <a data-dismiss="modal" class="btn pull-left close-modal">Close</a>
        </div>
    </div>
</script>

    <script id="abonat-modal-vcard" type="text/html">
        {{#user}}
        <img class="userAvatar" src="/sali/abonati/showImage?id={{id}}" alt="{{code}}"/>
        <a class="btn btn-mini pull-left browse-foto"><i class="icon-picture"></i>&nbsp;Browse</a>
        <a class="btn btn-warning btn-mini pull-right change-foto"><i class="icon-facetime-video icon-white"></i>&nbsp;Webcam</a>
        <div class="clearfix"></div>
        <div class="caption">
            <h4><a href="" class="more-details">{{name}}</a></h4>
            <p><strong>Cod utilizator:</strong> {{code}}</p>
            <p><strong>Telefon:</strong> {{phone}}</p>
            <p><strong>E-mail:</strong> {{email}}</p>
            <div class="btn-group" style="margin:10px 21% 0">
                <a class="btn btn-danger delete"><i class="icon-trash icon-white"></i>&nbsp;Sterge</a>
                <a class="btn more-details">Detalii&nbsp;<i class="icon-user"></i></a>
            </div>
            <div class="clearfix"></div>
        </div>
        {{/user}}
    </script>

        <script id="upload-foto-webcam" type="text/html">
            <div id="modal-abonat-foto-webcam" class="modal hide fade" data-keyboard="false" data-backdrop="static">
                <div class="modal-header"><button type="button" class="close cancel" aria-hidden="true">×</button><h3>Make a foto</h3></div>
                <div class="modal-body" >
                    <div class="photoUpload img-polaroid" style="min-width:520px; min-height:390px"></div>
                </div>
                <div class="modal-footer">
                    <a class="btn cancel pull-left">Cancel</a>
                    <a class="btn btn-warning capture pull-right" data-loading-text="Uploading..."><i class="icon-camera icon-white"></i>&nbsp; Foto</a>
                </div>
            </div>
        </script>

        <script id="upload-foto-browse" type="text/html">
            <div id="modal-abonat-foto-browse" class="modal hide fade" data-keyboard="false" data-backdrop="static">
                <div class="modal-header"><button type="button" class="close" aria-hidden="true" data-dismiss="modal">×</button><h3>Upload a foto</h3></div>
                <div class="modal-body" >
                    <div id="photoBrowse" class="fileupload-new" data-provides="fileupload">
                        <div class="fileupload-new" style="line-height: 20px;">
                            {{#id}}
                            <img src="/sali/abonati/showImage?id={{id}}" class="img-polaroid" style="width:390px; height:390px; display:block; margin:auto"/>
                            {{/id}}
                            {{^id}}
                            <img src="<g:createLinkTo dir="img" file="user.png"/>" class="img-polaroid" style="width:390px; height:390px; display:block; margin:auto"/>
                            {{/id}}
                        </div>
                        <div class="fileupload-preview fileupload-exists thumbnail" style="max-width:390px; max-height:390px; line-height: 20px; margin:auto"></div>
                        <div>
                            <span class="btn btn-file hide"><input type="file" id="foto2Upload"/></span>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <a class="btn pull-left" data-dismiss="modal">Cancel</a>
                    <a class="btn btn-warning capture pull-right" data-loading-text="Uploading..."><i class="icon-upload icon-white"></i>&nbsp; Upload</a>
                    <a class="btn pull-right change-foto"><i class="icon-folder-open"></i>&nbsp;Schimba poza</a>
                </div>
            </div>
        </script>


    <script id="abonat-modal-general" type="text/html">
        %{--User abonamente--}%
        {{#abActive}}
        <div class="alert {{#checkedIn}}alert-info{{/checkedIn}} {{^checkedIn}}alert-success{{/checkedIn}}">
            <div class="row-fluid">
                <div class="span9">
                    <h4 class="margintop5px">{{name}}</h4>
                </div>

                <div class="span3">
                    {{#checkedIn}}
                    <a class="btn btn btn-block btn-info check-out" data-id="{{cbId}}">Check out</a>
                    {{/checkedIn}}
                    {{^checkedIn}}
                    <a class="btn btn-block btn-success check-in" data-id="{{cbId}}">Check in</a>
                    {{/checkedIn}}
                </div>
            </div>

            {{#checkedIn}}
            <div class="row-fluid margintop20px smaller-lineheight">
                <div class="span2">
                    <span class="bold px12">Sedinte:</span>
                </div>

                {{#unlimited}}
                <div class="span10">
                    <span class="label label-info">Nelimitat</span>
                </div>
                {{/unlimited}}

                {{^unlimited}}
                <div class="span7">
                    <div class="progress progress-info marginbottom0" style="height:15px">
                        <div class="bar" style="width:{{noInPercent}}%"></div>
                    </div>
                </div>

                <div class="span3">
                    <span class="label label-info pull-right px11">{{noIn}} / {{noInTotal}}</span>
                </div>
                {{/unlimited}}
            </div>

            <div class="row-fluid smaller-lineheight">
                <div class="span2">
                    <span class="bold px12">Valabilitate:</span>
                </div>
                <div class="span7">
                    <div class="progress progress-info progress-striped active marginbottom0" style="height:15px">
                        <div class="bar" style="width:{{dateProcent}}%"></div>
                    </div>
                </div>

                <div class="span3">
                    <span class="label label-info pull-right px11">{{startDate}} - {{endDate}}</span>
                </div>
            </div>
            {{/checkedIn}}

            {{^checkedIn}}
            <div class="row-fluid margintop20px smaller-lineheight">
                <div class="span2">
                    <span class="bold px12">Sedinte:</span>
                </div>

                {{#unlimited}}
                <div class="span10">
                    <span class="label label-success">Nelimitat</span>
                </div>
                {{/unlimited}}

                {{^unlimited}}
                <div class="span7">
                    <div class="progress progress-success marginbottom0" style="height:15px">
                        <div class="bar" style="width:{{noInPercent}}%"></div>
                    </div>
                </div>

                <div class="span3">
                    <span class="label label-success pull-right px11">{{noIn}} / {{noInTotal}}</span>
                </div>
                {{/unlimited}}
            </div>

            <div class="row-fluid smaller-lineheight">
                <div class="span2">
                    <span class="bold px12">Valabilitate:</span>
                </div>
                <div class="span7">
                    <div class="progress progress-success progress-striped active marginbottom0" style="height:15px">
                        <div class="bar" style="width:{{dateProcent}}%"></div>
                    </div>
                </div>

                <div class="span3">
                    <span class="label label-success pull-right px11">{{startDate}} - {{endDate}}</span>
                </div>
            </div>
            {{/checkedIn}}
        </div>
        {{/abActive}}
    </script>

    <script id="abonat-modal-abonamente" type="text/html">
        <div class="row-fluid marginbottom10px">
            <div class="span12">
                <a class="btn pull-right istoric-abonament marginleft10px" data-id="{{user.id}}"><i class="icon-list"></i>&nbsp;Istoric abonamente</a>
                <a class="btn pull-right add-abonament" data-id="{{user.id}}"><i class="icon-plus"></i>&nbsp;Abonament nou</a>
            </div>
        </div>
        <div class="row-fluid">
            <div class="span12">
                <table class="table table-striped table-bordered">
                    <thead>
                    <th>Denumire</th>
                    <th>Start</th>
                    <th>End</th>
                    <th>Terminate</th>
                    <th>Total</th>
                    <th>Actiuni</th>
                    </thead>

                    <tbody id="abonat-abonamente">
                        {{>abonat-details-modal-template-abonamente-table}}
                    </tbody>
                </table>
            </div>
        </div>
    </script>

            %{--Cols abonamente user--}%
            <script id="abonat-details-modal-template-abonamente-table" type="text/html">
                {{#abActive}}
                <tr>
                    <td>{{name}}</td>
                    <td>{{startDate}}</td>
                    <td>{{endDate}}</td>
                    {{#unlimited}}
                    <td colspan="2">Nelimitat</td>
                    {{/unlimited}}
                    {{^unlimited}}
                    <td>{{noIn}}</td>
                    <td>{{noInTotal}}</td>
                    {{/unlimited}}
                    <td><div class="btn-group"><a class="btn edit-abonament" data-id="{{cbId}}"><i class="icon-cog"></i></a><a class="btn delete-abonament" data-id="{{cbId}}" data-name="{{name}}"><i class="icon-trash"></i></a></div></td>
                </tr>
                {{/abActive}}
            </script>

            %{--Modal abonament--}%
            <script id="abonat-details-modal-abonament-nou" type="text/html">
                <div id="modal-abonat-abonament-nou" class="modal hide fade" data-keyboard="false" data-backdrop="static" data-height="250">
                    <div class="modal-header"><button type="button" class="close" aria-hidden="true" data-dismiss="modal">×</button><h3>Adauga abonament</h3></div>
                    <form class="form-add-abonament marginbottom0" autocomplete="off">
                        <input type="hidden" name="idAbonat" value="{{id}}"/>
                        <div class="modal-body">
                            <div class="row-fluid">
                                <div class="span12">
                                    <label class="bold px12">Abonament:</label>
                                    <select class="tip-abonament span12" name="idAbonament">
                                        <option selected="selected" disabled="disabled">--- Selectati un abonament ---</option>
                                        <g:each in="${abonamente}" var="abonament">
                                            <option value="${abonament.id}" data-description="${abonament.description}" data-unlimited="${abonament.unlimited}" data-nointotal="${abonament.noInTotal}" data-price="${abonament.price}">${abonament.name}</option>
                                        </g:each>
                                    </select>

                                    <div class="abonament-details"></div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <a class="btn pull-left" data-dismiss="modal">Cancel</a>
                            <button class="btn btn-warning add pull-right" data-loading-text="Saveing..." type="submit"><i class="icon-plus icon-white"></i>&nbsp; Adauga</button>
                        </div>
                    </form>
                </div>
            </script>

            %{--Modal abonament form--}%
            <script id="abonat-details-modal-abonament-nou-template" type="text/html">
                <div class="row-fluid">
                    <div class="span6">
                        <label class="bold px12">Start date:</label>
                        <div class="date input-append" data-date-format="dd-mm-yyyy">
                            <input type="text" class="span10 datepick" name="startDate" placeholder="Data Start" required="required"/>
                            <span class="add-on"><i class="icon-calendar"></i></span>
                        </div>
                    </div>

                    <div class="span6">
                        <label class="bold px12">End date:</label>
                        <div class="date input-append" data-date-format="dd-mm-yyyy">
                            <input type="text" class="span10 datepick" name="endDate" placeholder="Data End" required="required"/>
                            <span class="add-on"><i class="icon-calendar"></i></span>
                        </div>
                    </div>
                </div>

                <div class="row-fluid">
                    <div class="span6">
                        <label class="bold px12">Discount:</label>
                        <div class="input-append">
                            <input type="text" class="span10" name="discount" placeholder="Discount" value="0" id="discount"/>
                            <span class="add-on">%</span>
                        </div>
                    </div>

                    <div class="span6">
                        <label class="bold px12">Pret Total<span id="price-info"></span>:</label>
                        <div class="input-append">
                            <input type="text" class="span10" disabled="disabled" value="{{price}}" data-value="{{price}}" id="total-price"/>
                            <span class="add-on">Lei</span>
                        </div>
                    </div>
                </div>

                <label class="bold px12">Sedinte disponibile:</label>
                <input type="text" class="span12" disabled="disabled" {{#unlimited}}value="nelimitat"{{/unlimited}} {{^unlimited}}value="{{noInTotal}}"{{/unlimited}}/>

                <label class="bold px12">Descriere abonament:</label>
                <textarea class="span12" disabled="disabled" style="resize:none; height:95px;">{{description}}</textarea>
            </script>

            %{--Istoric abonamente (expirate si sterse)--}%
            <script id="abonat-details-modal-abonament-istoric" type="text/html">
                <div id="modal-abonat-istoric" class="modal hide fade" data-height="350" data-maxHeight="350">
                    <div class="modal-header"><button type="button" class="close" aria-hidden="true" data-dismiss="modal">×</button><h3>Istoric abonamente</h3></div>
                    <div class="modal-body">
                        <div class="row-fluid">
                            <div class="span12">
                                <table class="table table-striped table-bordered">
                                    <thead>
                                    <th>Denumire</th>
                                    <th>Start</th>
                                    <th>End</th>
                                    <th>Terminate</th>
                                    <th>Total</th>
                                    </thead>

                                    <tbody>
                                    {{#abInActive}}
                                    <tr>
                                        <td>{{name}}</td>
                                        <td>{{startDate}}</td>
                                        <td>{{endDate}}</td>
                                        {{#unlimited}}
                                        <td colspan="2">Nelimitat</td>
                                        {{/unlimited}}
                                        {{^unlimited}}
                                        <td>{{noIn}}</td>
                                        <td>{{noInTotal}}</td>
                                        {{/unlimited}}
                                    </tr>
                                    {{/abInActive}}
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <a class="btn pull-right" data-dismiss="modal">Cancel</a>
                    </div>
                </div>
            </script>


    <script id="abonat-modal-detalii" type="text/html">
    <form method="POST" class="marginbottom0 user-details-form" autocomplete="off">
        <input type="hidden" name="id" value="{{user.id}}" />
        <input type="hidden" name="code" value="{{user.code}}" />
        <div class="error"></div>
        <div class="row-fluid">
            <div class="span6">
                <label class="bold px12">Nume:</label>
                <input type="text" name="name" class="span12 hasTooltip" value="{{user.name}}" data-placement="right" required="required" pattern="[a-zA-Z ]{3,30}" title="Numele trebuie sa fie intre 3 si 30 de caractere alfanumerice."/>

                <label class="bold px12">Cnp:</label>
                <input type="text" name="cnp" class="span12 hasTooltip" value="{{user.cnp}}" data-placement="right" required="required"  pattern="[0-9]{13}" title="Codul numeric personal trebuie sa fie din 13 cifre."/>

                <label class="bold px12">E-mail:</label>
                <input type="email" name="email" class="span12 hasTooltip" value="{{user.email}}" data-placement="right" required="required" title="Adresa de e-mail trebuie sa fie de forma: mail@domeniu.ro"/>

                <label class="bold px12">Telefon:</label>
                <input type="tel" name="phone" class="span12 hasTooltip" value="{{user.phone}}" data-placement="right" required="required" pattern="[0-9]{10}" title="Numarul de telefon trebuie sa fie din 10 cifre."/>
            </div>

            <div class="span6">
                <label class="bold px12">Sex:</label>
                {{#user.sexWrapper}}
                <div class="row-fluid marginbottom10px">
                    <div class="span5"><label class="radio bold px12 pull-left marginright:10px"><input type="radio" name="sex" value="MASCULIN">Masculin</label></div>
                    <div class="span5"><label class="radio bold px12 pull-left"><input type="radio" name="sex" value="FEMININ">Feminin</label></div>
                </div>
                {{/user.sexWrapper}}

                <label class="bold px12">Data nasterii:</label>
                <div class="date" data-date="{{user.birthDate}}" data-date-format="dd-mm-yyyy">
                    <input class="span12 datepick" type="text" value="{{user.birthDate}}" name="birthDate" readonly="readonly"/>
                </div>

                <label class="bold px12">Adresa:</label>
                <textarea name="address" class="span12" style="resize:none; height:95px;">{{user.address}}</textarea>
            </div>
        </div>

        <div class="row-fluid">
            <div class="span12">
                <label class="bold px12">Detalii:</label>
                <textarea name="details" class="span12" style="resize:none; height:150px;">{{user.details}}</textarea>
                <button type="submit" class="btn btn-primary pull-right" data-loading-text="Saving...">Salveaza</button>
            </div>
        </div>
    </form>
</script>

    <script id="abonat-modal-pos" type="text/html">
        Pos
    </script>

    <script id="abonat-modal-istoric" type="text/html">
        {{#history}}
        <div class="row-fluid">
            <div class="span12">
                <table class="table table-striped table-bordered">
                    <thead>
                    <th>Operator</th>
                    <th>Denumire abonament</th>
                    <th>Actiune</th>
                    <th>Data</th>
                    </thead>

                    <tbody id="user-history">
                        {{#entries}}
                        <tr>
                            <td>{{operator}}</td>
                            <td>{{name}}</td>
                            {{#checkedIn}}
                            <td>Check In</td>
                            <td>{{checkedIn}}</td>
                            {{/checkedIn}}
                            {{^checkedIn}}
                            <td>Check Out</td>
                            <td>{{checkedOut}}</td>
                            {{/checkedIn}}
                        </tr>
                        {{/entries}}
                    </tbody>
                </table>

                <div class="pagination pagination-right" id="history-pag" data-pages=></div>
            </div>
        </div>
        {{/history}}
    </script>
</body>
</html>