package sali
import grails.plugins.springsecurity.Secured
import org.sali.Admin;

class GodController extends BaseController{

    def index() { }

    @Secured(['ROLE_GOD'])
    def addAdminSala(){

        def sala = currentUser().sala
        Admin admin = new Admin(name: "geta", address: "adresa admin", phone: "0123", username: "get", password: "geta", enabled: true, accountExpired: false, accountLocked: false, passwordExpired: false)
        admin.sala = sala
        admin.save(flush: true)

    }
}
