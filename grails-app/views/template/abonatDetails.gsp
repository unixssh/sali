<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/html">
<head></head>
<body>

%{--Tabel abonamente User--}%
<script id="abonat-details-modal-template-abonamente" type="text/html">
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

%{--POS--}%
<script id="abonat-details-modal-template-pos" type="text/html">
   Pos
</script>
</body>
</html>