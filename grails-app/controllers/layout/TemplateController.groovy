package layout

import org.sali.Abonament
import org.sali.Sala
import sali.BaseController

class TemplateController extends BaseController{
    def templates() {
        render view: 'templates'
    }

    def abonatDetails(){
        Sala sala = currentUser().sala
        def abonamente = Abonament.findAllBySalaAndDeleted(sala, false)

        render view: 'abonatDetails', model: [abonamente:abonamente]
    }

    def abonati() {
        render view:  'abonati'
    }

    def abonamente() {
        render view: 'abonamente'
    }

    def abonatTemplate(){
        Sala sala = currentUser().sala
        def abonamente = Abonament.findAllBySalaAndDeleted(sala, false)

        render view: 'abonat', model: [abonamente:abonamente]
    }
}
