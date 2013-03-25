<!-- Navbars -->
<div class="navbar navbar-inverse navbar-fixed-top">
    <div class="navbar-inner">
        <div class="container-fluid">
            <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse"> <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span> </a>
            <a class="brand bold">Sali de sport</a>

            <div class="nav-collapse collapse">
                <ul class="nav pull-right px12">
                    <li class="dropdown">
                        <a href="" class="dropdown-toggle" data-toggle="dropdown"><i class="iconic-cog"></i>&nbsp; Settings <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href=""><i class="iconic-hash"></i>&nbsp; Profile</a></li>
                            <li class="divider"></li>
                            <li><a href="<g:createLink controller="logout"/>" id="logout-btn"><i class="iconic-lock"></i>&nbsp; Log out</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>

<div class="subnavbar">
    <div class="subnavbar-inner">
        <div class="container-fluid">
            <ul class="mainnav">
                <li ${params.controller == 'dashBoard' ? 'class="active"' : ''}><a href="<g:createLink controller="dashBoard" action="index"/>"><i class="iconic-layers"></i><span>DashBoard</span></a></li>
                <li ${params.controller == 'abonati' ? 'class="active"' : ''}><a href="<g:createLink controller="Abonati" action="index"/>"><i class="iconic-user"></i><span>Abonati</span></a></li>
                <li ${params.controller == 'abonamente' ? 'class="active"' : ''}><a href="<g:createLink controller="Abonamente" action="index"/>"><i class="iconic-book"></i><span>Abonamente</span></a></li>
                <li><a href=""><i class="iconic-document-alt"></i><span>Facturi</span></a></li>
                <li><a href=""><i class="iconic-chart"></i><span>Rapoarte</span></a></li>
            </ul>
        </div>
    </div>
</div>
<!-- End of Navbars -->
<div id="page-message" class="page-alert"></div>