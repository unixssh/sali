<html>
<head>
	<meta name='layout' content='login-layout'/>
	<title><g:message code="springSecurity.login.title"/></title>
</head>

<body>
    <div class="navbar navbar-inverse navbar-fixed-top">
        <div class="navbar-inner">
            <div class="container"></div>
        </div>
    </div>

    <div class="container margintop100px page-container" id="content">
        <form class="form-signin" action='${postUrl}' method='post'>
            <h2 class="form-signin-heading">Autentificare</h2>
            <div class="control-group marginbottom0"><input type="text" class="input-block-level" name="j_username" placeholder="Adresa de e-mail"></div>
            <div class="control-group marginbottom0"><input type="password" class="input-block-level" name="j_password" placeholder="Parola" autocomplete="false"></div>

            <label class="checkbox bold px12 medium-lineheight pull-left width50"><input type="checkbox" name='${rememberMeParameter}' <g:if test='${hasCookie}'>checked='checked'</g:if>>Tine-ma minte</label>
            <a href="#modal-forgot-pass" data-toggle="modal" class="pull-right px12 medium-lineheight">Am uitat parola</a>
            <div class="clearfix"></div>

            <button class="btn btn-large margintop20px btn-primary btn-block" type="submit">Log in</button>

        </form>
    </div>

    <div id="modal-forgot-pass" class="modal hide fade" tabindex="-1" data-width="500" data-focus-on="input:first">
        <div class="modal-header"><button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button><h3>Am uitat parola</h3></div>
        <div class="modal-body">
            <div class="row-fluid">
                <div class="span12">
                    <div class="control-group">
                        <input class="span12" type="email" id="email-forgot" name="email-forgot" placeholder="Adresa de e-mail" autocomplete="false">
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" data-dismiss="modal" class="btn pull-left">Close</button>
            <button type="button" class="btn btn-primary" id="btn-forgot">Continua</button>
        </div>
    </div>
</body>
</html>
