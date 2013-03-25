import org.sali.SecRole
import org.sali.SecUserSecRole
import org.sali.SecUser
import sali.DbPopulatorService

class BootStrap {
    def springSecurityService
    def authenticateService
    DbPopulatorService dbPopulatorService

    def init = { servletContext ->

        //user's roles
        def userRole = SecRole.findByAuthority('ROLE_OPERATOR') ?: new SecRole(authority: 'ROLE_OPERATOR').save(failOnError: true)
        def adminRole = SecRole.findByAuthority('ROLE_ADMIN') ?: new SecRole(authority: 'ROLE_ADMIN').save(failOnError: true)
        def godRole = SecRole.findByAuthority('ROLE_GOD') ?: new SecRole(authority: 'ROLE_GOD').save(failOnError: true)

        //module's roles
        def bronzeRole = SecRole.findByAuthority('ROLE_BRONZE') ?: new SecRole(authority: 'ROLE_BRONZE').save(failOnError: true)
        def silverRole = SecRole.findByAuthority('ROLE_SILVER') ?: new SecRole(authority: 'ROLE_SILVER').save(failOnError: true)
        def goldRole = SecRole.findByAuthority('ROLE_GOLD') ?: new SecRole(authority: 'ROLE_GOLD').save(failOnError: true)

        //create the mother fucker user-GOD
        def god = SecUser.findByUsername('god') ?: new SecUser(
                username: 'god',
                password: 'god',
                enabled: true).save(failOnError: true)

        if (!god.authorities.contains(godRole)) {
            SecUserSecRole.create god, godRole
        }

        dbPopulatorService.addSubscribers()
    }

    def destroy = {
    }
}
