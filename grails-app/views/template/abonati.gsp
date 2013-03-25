<!DOCTYPE html>
<html lang="en">
<head></head>
<body>
%{--Tabel abonati--}%
<script id="abonati-table-template" type="text/html">
{{#users}}
    <tr data-id="{{id}}" class="user-details" id="user-{{id}}">
        <td>{{index}}</td>
        <td>{{name}}</td>
        <td>{{code}}</td>
        <td>{{cnp}}</td>
        <td>{{phone}}</td>
    </tr>
{{/users}}
</script>

<script id="add-abonat-modal-template" type="text/html">
    <div id="modal-add-abonat" class="modal hide fade" data-keyboard="false" data-backdrop="static" data-width="800" data-focus-on="input:first">
        <div class="modal-header"><button type="button" class="close close-modal" data-dismiss="modal" aria-hidden="true">×</button><h3>Adauga Abonat</h3></div>
        <form  method="POST" class="marginbottom0 add-user-form" autocomplete="off">
            <div class="modal-body" >
                <div class="row-fluid">
                    <div class="span4">
                        <div class="thumbnail well user-vCard marginbottom0">
                            <img class="userAvatar" src="<g:createLinkTo dir="img" file="user.png"/>" alt="User foto"/>
                            <a class="btn btn-mini pull-left browse-foto"><i class="icon-picture"></i>&nbsp;Browse</a>
                            <a class="btn btn-warning btn-mini pull-right change-foto"><i class="icon-facetime-video icon-white"></i>&nbsp;Webcam</a>
                            <label class="bold px12 margintop10px">Cod abonat:</label>
                            <input type="text" name="code" class="span12 hasTooltip" required="required" placeholder="Cod abonat" title="Cod abonat" data-placement="right" />
                            <input type="hidden" name="dataImg" class="span12 foto" required="required"/>
                        </div>
                    </div>

                    <div class="span8">
                        <div class="error"></div>
                        <div class="row-fluid">
                            <div class="span6">
                                <label class="bold px12">Nume:</label>
                                <input type="text" name="name" class="span12 hasTooltip" data-placement="right" required="required" pattern="[a-zA-Z ]{3,30}" placeholder="Nume si prenume" title="Numele trebuie sa fie intre 3 si 30 de caractere alfanumerice."/>

                                <label class="bold px12">Cnp:</label>
                                <input type="text" name="cnp" class="span12 hasTooltip" data-placement="right" required="required"  pattern="[0-9]{13}" placeholder="Cod numeric personal" title="Codul numeric personal trebuie sa fie din 13 cifre."/>

                                <label class="bold px12">E-mail:</label>
                                <input type="email" name="email" class="span12 hasTooltip" data-placement="right" required="required" placeholder="Adresa de e-mail" title="Adresa de e-mail trebuie sa fie de forma: mail@domeniu.ro"/>

                                <label class="bold px12">Telefon:</label>
                                <input type="tel" name="phone" class="span12 hasTooltip" data-placement="right" required="required" placeholder="Numar de telefon" pattern="[0-9]{10}" title="Numarul de telefon trebuie sa fie din 10 cifre."/>
                            </div>

                            <div class="span6">
                                <label class="bold px12">Sex:</label>
                                <div class="row-fluid marginbottom10px">
                                    <div class="span5"><label class="radio bold px12 pull-left marginright:10px"><input type="radio" name="sex" value="MASCULIN" checked="checked">Masculin</label></div>
                                    <div class="span5"><label class="radio bold px12 pull-left"><input type="radio" name="sex" value="FEMININ">Feminin</label></div>
                                </div>

                                <label class="bold px12">Data nasterii:</label>
                                <div class="date" data-date-format="dd-mm-yyyy">
                                    <input class="span12 datepick" type="text"  name="birthDate" readonly="readonly" placeholder="Data nasterii"/>
                                </div>

                                <label class="bold px12">Adresa:</label>
                                <textarea name="address" class="span12" style="resize:none; height:95px;" placeholder="Adresa completa"></textarea>
                            </div>
                        </div>
                        <div class="row-fluid">
                            <div class="span12">
                                <label class="bold px12">Detalii:</label>
                                <textarea name="details" class="span12" style="resize:none; height:95px;" placeholder="Observatii despre abonat"></textarea>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal-footer">
                <a href="" data-dismiss="modal" class="btn pull-left close-modal">Close</a>
                <button type="submit" class="btn btn-primary pull-right" data-loading-text="Saving...">Adauga</button>
            </div>
        </form>
    </div>
</script>
</body>
</html>