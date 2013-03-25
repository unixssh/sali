package sali

import org.sali.SecUser

class BaseController {

    def springSecurityService

    private currentUser() {
        return SecUser.get(springSecurityService.principal.id)
    }
}
