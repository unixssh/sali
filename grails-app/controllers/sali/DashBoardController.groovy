package sali
import grails.plugins.springsecurity.Secured;
class DashBoardController extends BaseController {

    @Secured(['ROLE_OPERATOR'])
    def index(){

        def current = currentUser()
        render view: '/dashBoard/index'
    }
}
