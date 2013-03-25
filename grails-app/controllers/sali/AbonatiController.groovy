package sali

import grails.converters.JSON
import grails.plugins.springsecurity.Secured
import org.commandObjects.AbonatCommand
import org.sali.Abonat
import org.sali.Abonament
import org.sali.ClientAbonamente
import org.sali.InOutHistory

class AbonatiController extends BaseController {

    def abonatiService

    @Secured(['ROLE_OPERATOR'])
    def index() {
        def user = currentUser()
        render view: '/abonati/index'
    }

    def lastUpdated(){
        String sort  = params.sort
        String ord = params.order
        String query = params.query

        def responseList = []
        def sala = currentUser().sala
        def results = Abonat.withCriteria{
            and {
                eq('active',true)
                eq('sala',sala)
            }

            if (query.length()>0){
                or{
                    like('name', '%'+query+'%')
                    like('phone', query+'%')
                    like('code', query+'%')
                    like('cnp', query+'%')
                    like('email', '%'+query+'%')
                }
            }else maxResults(20)
            order('lastUpdated', 'desc')
        }

        results.sort{a,b->
            if(ord =='asc'){
                return a[sort]<=>b[sort]
            }else{
                return b[sort]<=>a[sort]
            }
        }

        int counter = 0
        results.each{
            def response = [:]
            counter++
            response.index = counter
            response.name = it.name
            response.id = it.id
            response.phone = it.phone
            response.code = it.code
            response.cnp = it.cnp

            responseList.add(response)
        }

        def response = ['users':responseList]
        render response as JSON
    }

    def updateAbonat = { AbonatCommand cmd ->
        def response = [:]
        def abonat = Abonat.get(Long.parseLong(params.id))

        if (cmd.validate()){
            abonat.name = cmd.name
            abonat.sex = cmd.sex
            abonat.address = cmd.address
            abonat.cnp = cmd.cnp
            abonat.details = cmd.details
            abonat.email = cmd.email
            abonat.phone = cmd.phone
            abonat.birthDate = new Date().parse('dd-MM-yyyy', cmd.birthDate)

            abonat.save(flush: true)
            response.status = true
        }else{
            response.status = false
            if (cmd.errors.hasFieldErrors("name")) response.name = false
            if (cmd.errors.hasFieldErrors("cnp"))  response.cnp = false
            if (cmd.errors.hasFieldErrors("phone"))response.phone = false
            if (cmd.errors.hasFieldErrors("email"))response.email = false
            if (cmd.errors.hasFieldErrors("code")) response.code = false
        }

        render response as JSON
    }

    def uploadFoto(){
       abonatiService.uploadCam(params.id, params.dataImg)
       render [:]
    }

    def showImage = {
        def avatarUser = Abonat.get(Long.parseLong(params.id))
        if (!avatarUser || !avatarUser.avatar || !avatarUser.avatarType) {
            def image = new File("user.png")
            response.setContentType("image/png")
            response.setContentLength(image.getBytes().size())
            OutputStream out = response.getOutputStream();
            out.write(image.getBytes());
            out.close();
            return;
        }
        response.setContentType(avatarUser.avatarType)
        response.setContentLength(avatarUser.avatar.size())
        OutputStream out = response.getOutputStream();
        out.write(avatarUser.avatar);
        out.close();
    }

    def addAbonat = { AbonatCommand cmd ->
        def response = [:]
        if (cmd.validate()){
            abonatiService.addAbonat(cmd.name, cmd.sex, cmd.code, cmd.address, cmd.cnp, cmd.details, cmd.email, cmd.phone, cmd.birthDate, params.dataImg)
            response.status = true
        }else{
            response.status = false
            if (cmd.errors.hasFieldErrors("name")) response.name = false
            if (cmd.errors.hasFieldErrors("cnp"))  response.cnp = false
            if (cmd.errors.hasFieldErrors("phone"))response.phone = false
            if (cmd.errors.hasFieldErrors("email"))response.email = false
            if (cmd.errors.hasFieldErrors("code")) response.code = false
        }

        render response as JSON
    }

    def deactivateAbonat = {
        def response = [:]
        response.status = abonatiService.deleteAbonat(params.id)
        render response as JSON
    }

    def addAbonamentAbonat = {
        def abonat = Abonat.get(Long.parseLong(params.idAbonat))
        def abonament = Abonament.get(Long.parseLong(params.idAbonament))
        def clientAbonamente = new ClientAbonamente(abonat: abonat, abonament: abonament, noIn: abonament.noInTotal, startDate: new Date().parse('dd-MM-yyyy', params.startDate), endDate: new Date().parse('dd-MM-yyyy', params.endDate), expired: false)
        clientAbonamente.save(flush: true)
        render [:]
    }

    def deactivateAbonamentAbonat (){
        Long id = Long.parseLong(params.id)
        def clientAbonamente = ClientAbonamente.get(id)
        if (!clientAbonamente.checkedIn){
            clientAbonamente.expired = true
            clientAbonamente.save(flush: true)
            render [:]
        }else render 0
    }

    def AbonamentCheckIn(){
        def currentUser = currentUser()
        def cbId = Long.parseLong(params.id)
        def cb = ClientAbonamente.get(cbId)

        if (!cb.abonament.unlimited) cb.noIn = cb.noIn - 1

        cb.checkedIn = true
        cb.save(flush: true)
        //chechIn
        def checkIn = new InOutHistory(abonat: cb.abonat, abonament: cb.abonament, checkedIn: new Date(), user: currentUser)
        checkIn.save(flush: true)
        render [:]
    }

    def AbonamentCheckOut(){
        def currentUser = currentUser()
        def cbId = Long.parseLong(params.id)
        def cb = ClientAbonamente.get(cbId)
        cb.checkedIn = false

        if (!cb.noIn && !cb.abonament.unlimited) cb.expired = true
        cb.save(flush: true)
        //checkOut
        def checkOut = new InOutHistory(abonat: cb.abonat, abonament: cb.abonament, checkedOut: new Date(), user: currentUser)
        checkOut.save(flush: true)
        render [:]
    }

    def AbonamentAbonatIstoric(){
        Long id = Long.parseLong(params.id)
        Abonat abonat = Abonat.get(id)

        def response = [:]
        def absact = ClientAbonamente.withCriteria {
            eq('abonat', abonat)
            eq('expired', true)
            order('lastUpdated', 'desc')
        }
        def absListact = []
        for(ClientAbonamente cb : absact){
            def cb1 = [:]
            cb1.name  =  cb.abonament.name
            cb1.startDate = cb.startDate.format('dd/MM/yyyy')
            cb1.endDate = cb.endDate.format('dd/MM/yyyy')
            cb1.noIn = cb.abonament.noInTotal - cb.noIn
            cb1.noInTotal = cb.abonament.noInTotal
            cb1.unlimited =  cb.abonament.unlimited
            absListact.add(cb1)
        }
        response.abInActive = absListact

        render response as JSON
    }

    def AbonatIstoric(){
        Long id = Long.parseLong(params.id)
        Abonat abonat = Abonat.get(id)

        def response = [:]
        response.history = [:]
        response.history.pages = Math.ceil(InOutHistory.countByAbonat(abonat) / 8)
        response.history.entries = abonatiService.getAbonatHistory(params.id, params.page as int, 8)

        render response as JSON
    }
}
