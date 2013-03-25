modules = {
    /*Libs*/
    'libs' {
        resource url: 'js/libs/jquery-1.9.1.min.js'
        resource url: 'js/libs/bootstrap.js'

        //Config file
        resource url: 'js/config.js'
    }

    'date' {
        resource url: 'js/libs/date.js'
        resource url: 'js/libs/bootstrap-datepicker.js'
    }

    'mustache' {
        resource url: 'js/libs/mustache.js'
        resource url: 'js/libs/jquery-Mustache.js'
    }

    /*--------------------------------------------------------*/
    /*Modulse*/
    'abonatiModule' {
        defaultBundle 'abonatiModule'
        dependsOn 'date'
        dependsOn 'mustache'
        resource url: 'js/libs/select2.js'
        resource url: 'js/libs/photobooth_min.js'
        resource url: 'js/modules/abonati-module.js'
    }

    /*--------------------------------------------------------*/
    /*Layouts*/
    'loginLayout' {
        defaultBundle 'login-layout'
        dependsOn 'libs'
        //Development
        resource url: 'js/config.js'
        resource url: 'js/application-login.js'
        resource url: 'css/login-styles.less', attrs: [rel: "stylesheet/less", type: 'css']
    }

    'dashBoardLayout' {
        defaultBundle 'dashBoard-layout'
        dependsOn 'libs'
        resource url: 'js/application-layout.js'
        resource url: 'js/application-dash.js'
        resource url: 'css/layout.less', attrs: [rel: "stylesheet/less", type: 'css']
    }

    'abonatiLayout' {
        defaultBundle 'abonatiLayout'
        dependsOn 'libs'
        dependsOn 'abonatiModule'
        resource url: 'js/application-layout.js'
        resource url: 'js/application-abonati.js'
        resource url: 'css/layout.less', attrs: [rel: "stylesheet/less", type: 'css']
    }

    'abonamenteLayout' {
        defaultBundle 'abonamenteLayout'
        dependsOn 'libs'
        resource url: 'js/application-layout.js'
        resource url: 'js/application-abonamente.js'

        resource url: 'css/layout.less', attrs: [rel: "stylesheet/less", type: 'css']
    }


}