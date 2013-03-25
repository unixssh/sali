<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name='layout' content='abonati-layout'/>
    <title><g:message code="springSecurity.login.title"/></title>
</head>
<body>
<g:render template="/layouts/user-header"/>
<div class="container-fluid" id="content">
    <!-- Breadcrumbs -->
    <div class="visible-desktop">
        <hr>
        <ul class="breadcrumb">
            <li>Fitness name <span class="divider">&raquo;</span></li>
            <li><a href="<g:createLink controller="dashBoard" action="index"/>">Dashboard</a> <span class="divider">&raquo;</span></li>
            <li>Abonati</li>
        </ul>
        <hr class="marginbottom0">
    </div>
    <!-- End of Breadcrumbs -->

    <!--Box with some content-->
    <div class="row-fluid margintop20px">
        <div class="span6">
            <form id="find-user" class="form-search" autocomplete="off">
                <div class="input-append">
                    <input type="search" class="input-xlarge search-query" placeholder="Cauta uitilizator">
                    <button class="btn" type="submit">Cauta</button>
                </div>
            </form>
        </div>

        <div class="span6">
            <a class="btn pull-right add-user"><i class="icon-plus"></i>&nbsp;Adauga Abonat</a>
        </div>
    </div>

    <div class="row-fluid">
        <div class="span12">
            <table class="table table-striped table-bordered table-highlight">
                <thead>
                    <th style="width:1%;">Nr.</th>
                    <th class="sortable" data-sort="name" style="width:20%;"><a class="hasTooltip" data-original-title="Sorteaza dupa Nume" data-placement="top">Nume abonat</a></th>
                    <th class="sortable" data-sort="code" style="width:15%;"><a class="hasTooltip" data-original-title="Sorteaza dupa Cod Abonat" data-placement="top" >Cod Abonat</a></th>
                    <th class="sortable" data-sort="cnp" style="width:15%;"><a class="hasTooltip" data-original-title="Sorteaza dupa Cnp" data-placement="top">Cnp</a></th>
                    <th class="sortable" data-sort="phone" style="width:15%;"><a class="hasTooltip" data-original-title="Sorteaza dupa Telefon" data-placement="top">Telefon</a></th>
                </thead>
                <tbody id="abonati-holder"></tbody>
            </table>
        </div>
    </div>

</div>
</body>
</html>