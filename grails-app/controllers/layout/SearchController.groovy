package layout

import grails.converters.JSON
import org.sali.Abonat
import org.sali.ClientAbonamente
import org.sali.InOutHistory
import sali.BaseController

class SearchController extends BaseController{
    def abonatiService

    def index() {}

    def findUser(){
        redirect (action: "abonatGeneral", params: [id:params.id])
    }

        def abonatGeneral(){
            Long id = Long.parseLong(params.id)
            Abonat abonat = Abonat.get(id)

            def response = [:]
            def user = [:]
            user.id = abonat.id
            user.name = abonat.name
            user.phone = abonat.phone
            user.email = abonat.email
            user.code = abonat.code
            response.user = user

            def absact = ClientAbonamente.withCriteria {
                eq('abonat', abonat)
                eq('expired', false)
                order('startDate', 'desc')
            }
            def absListact = []
            for(ClientAbonamente cb : absact){
                def cb1 = [:]
                cb1.cbId  = cb.id
                cb1.name  =  cb.abonament.name
                cb1.startDate = cb.startDate.format('dd/MM/yyyy')
                cb1.endDate = cb.endDate.format('dd/MM/yyyy')
                cb1.noIn = cb.abonament.noInTotal - cb.noIn
                cb1.noInTotal = cb.abonament.noInTotal
                cb1.noInPercent = cb.abonament.unlimited ? 0 : Math.round((cb.abonament.noInTotal - cb.noIn) * 100 / cb.abonament.noInTotal)
                cb1.dateProcent = Math.round((new Date() - cb.startDate)*100 / (cb.endDate - cb.startDate))
                cb1.unlimited =  cb.abonament.unlimited
                cb1.checkedIn = cb.checkedIn

                absListact.add(cb1)
            }
            response.abActive = absListact
            render response as JSON
        }

        def abonatAbonamente(){
            Long id = Long.parseLong(params.id)
            Abonat abonat = Abonat.get(id)

            def response = [:]

            def absact = ClientAbonamente.withCriteria {
                eq('abonat', abonat)
                eq('expired', false)
                order('startDate', 'desc')
            }
            def absListact = []
            for(ClientAbonamente cb : absact){
                def cb1 = [:]
                cb1.cbId  = cb.id
                cb1.name  =  cb.abonament.name
                cb1.startDate = cb.startDate.format('dd/MM/yyyy')
                cb1.endDate = cb.endDate.format('dd/MM/yyyy')
                cb1.noIn = cb.abonament.noInTotal - cb.noIn
                cb1.noInTotal = cb.abonament.noInTotal
                cb1.noInPercent = cb.abonament.unlimited ? 0 : Math.round((cb.abonament.noInTotal - cb.noIn) * 100 / cb.abonament.noInTotal)
                cb1.dateProcent = Math.round((new Date() - cb.startDate)*100 / (cb.endDate - cb.startDate))
                cb1.unlimited =  cb.abonament.unlimited
                cb1.checkedIn = cb.checkedIn

                absListact.add(cb1)
            }
            response.abActive = absListact
            render response as JSON
        }

        def abonatDetalii(){
            Long id = Long.parseLong(params.id)
            Abonat abonat = Abonat.get(id)

            def response = [:]
            def user = [:]
            user.id = abonat.id
            user.name = abonat.name
            user.cnp = abonat.cnp
            user.phone = abonat.phone
            user.birthDate = abonat.birthDate.format('dd-MM-yyyy')
            user.email = abonat.email
            user.code = abonat.code
            user.active = abonat.active
            user.sex = abonat.sex
            user.details = abonat.details
            user.address = abonat.address
            response.user = user

            render response as JSON
    }

        def abonatIstoric(){
            Long id = Long.parseLong(params.id)
            Abonat abonat = Abonat.get(id)

            def response = [:]
            response.history = [:]
            response.history.pages = Math.ceil(InOutHistory.countByAbonat(abonat) / 8)
            response.history.entries = abonatiService.getAbonatHistory(params.id, 1, 8)

            render response as JSON
    }
}
