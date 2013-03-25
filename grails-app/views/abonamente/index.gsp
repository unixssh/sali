<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name='layout' content='abonamente-layout'/>
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
            <li>Abonamente</li>
        </ul>
        <hr class="marginbottom0">
    </div>
    <!-- End of Breadcrumbs -->


    <div class="row-fluid margintop20px">
        <div class="span6">

        </div>

        <div class="span6">
            <a class="btn pull-right add-abonament"><i class="icon-plus"></i>&nbsp;Adauga Abonament</a>
        </div>
    </div>
    <!--Box with some content-->
    <div class="row-fluid margintop20px">
        <div class="span12">
            <table class="table table-striped table-bordered table-highlight">
                <thead>
                <th style="width:1%;">Nr.</th>
                <th style="width:20%;">Nume Abonament</th>
                <th style="width:15%;">Descriere</th>
                <th style="width:15%;">Sedinte</th>
                <th style="width:15%;">Pret</th>
                <th style="width:15%;">Actiuni</th>
                </thead>
                <tbody id="abonamente-holder"></tbody>
            </table>
        </div>
    </div>

</div>
</body>
</html>