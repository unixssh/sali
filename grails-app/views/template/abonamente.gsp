<!DOCTYPE html>
<html lang="en">
<head></head>
<body>
%{--Tabel abonamente--}%
<script id="abonamente-table-template" type="text/html">
    {{#ab}}
    <tr">
        <td>{{index}}</td>
        <td>{{name}}</td>
        <td>{{description}}</td>
        {{#unlimited}}
        <td>Nelimitat</td>
        {{/unlimited}}
        {{^unlimited}}
        <td>{{noInTotal}}</td>
        {{/unlimited}}
        <td>{{price}}</td>
        <td><a class="btn btn-danger delete-abonament" data-id="{{id}}"><i class="icon-trash icon-white"></i>&nbsp; Delete</a></td>
    </tr>
    {{/ab}}
</script>

%{--Modal add abonament--}%
<script id="modal-abonament-nou-template" type="text/html">
    <div id="modal-abonament-nou" class="modal hide fade" data-keyboard="false" data-backdrop="static">
        <div class="modal-header"><button type="button" class="close" aria-hidden="true" data-dismiss="modal">×</button><h3>Adauga abonament</h3></div>
        <form class="form-add-abonament marginbottom0" autocomplete="off">
            <div class="modal-body">
                <div class="row-fluid">
                    <div class="span12">
                        <div class="row-fluid">
                            <div class="span6">
                                <label class="bold px12">Denumire:</label>
                                <input type="text" class="span12" name="name" required="required" pattern="[a-zA-z 0-9]{3,30}"/>
                            </div>

                            <div class="span6">
                                <label class="bold px12">Pret:</label>
                                <input type="text" class="span12" name="price" required="required" pattern="[0-9.]{1,10}"/>
                            </div>
                        </div>

                        <label class="bold px12">Sedinte disponibile:</label>
                        <input type="text" class="span12" name="noInTotal" id="noInTotal" value="0" pattern="[0-9]{1,3}" required="required"/>
                        <label class="checkbox bold px12"><input type="checkbox" name="unlimited" value="true" id="unlimited">Abonament nelimitat</label>
                        <label class="bold px12">Descriere abonament:</label>
                        <textarea class="span12" style="resize:none; height:95px;" name="description"></textarea>
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
</body>
</html>