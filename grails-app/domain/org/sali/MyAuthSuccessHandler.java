package org.sali;

/**
 * Created with IntelliJ IDEA.
 * User: cata
 * Date: 1/17/13
 * Time: 8:31 PM
 * To change this template use File | Settings | File Templates.
 */

import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MyAuthSuccessHandler
        extends SavedRequestAwareAuthenticationSuccessHandler {

    @Override
    protected String determineTargetUrl(HttpServletRequest request,
                                        HttpServletResponse response) {

        boolean hasAdmin = SpringSecurityUtils.ifAllGranted("ROLE_ADMIN");
        boolean hasUser = SpringSecurityUtils.ifAllGranted("ROLE_USER");

        if(hasAdmin){
            return adminUrl;
        }else if (hasUser){
            return userUrl;
        }else{
            return super.determineTargetUrl(request, response);
        }
    }

    private String userUrl;
    private String adminUrl;

    public void setUserUrl(String userUrl){
        this.userUrl = userUrl;
    }

    public void setAdminUrl(String adminUrl){
        this.adminUrl = adminUrl;
    }
}
