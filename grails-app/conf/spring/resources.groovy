import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

beans = {

    authenticationSuccessHandler(org.sali.MyAuthSuccessHandler) {
        def conf = SpringSecurityUtils.securityConfig
        requestCache = ref('requestCache')
        defaultTargetUrl = conf.successHandler.defaultTargetUrl
        alwaysUseDefaultTargetUrl = conf.successHandler.alwaysUseDefault
        targetUrlParameter = conf.successHandler.targetUrlParameter
        useReferer = conf.successHandler.useReferer
        redirectStrategy = ref('redirectStrategy')
        adminUrl = "/dashBoard"
        userUrl = "/dashBoard"
    }
}
