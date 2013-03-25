package sali

import grails.converters.JSON
import org.sali.Abonament
import org.sali.ClientAbonamente

class AbonamenteController extends BaseController{

    def index() {
        render view: '/abonamente/index'
    }

    def list(){
        def sala = currentUser().sala
        def results = Abonament.withCriteria {
            eq('sala',sala)
            eq ('deleted', false)
            order('lastUpdated', 'desc')
        }
        int counter = 0
        def responseList = []

        results.each{
            def response = [:]
            counter++
            response.index = counter
            response.name = it.name
            response.id = it.id
            response.description = it.description
            response.noInTotal = it.noInTotal
            response.price = it.price
            response.unlimited = it.unlimited

            responseList.add(response)
        }

        def response = ['ab':responseList]
        render response as JSON
    }

    def add() {
        def sala = currentUser().sala
        def abonament = new Abonament()
        abonament.name = params.name
        abonament.noInTotal =params.noInTotal?params.noInTotal as int : 0
        abonament.unlimited = params.unlimited ? true : false
        abonament.sala = sala
        abonament.price = new BigDecimal(params.price)
        abonament.description = params.description
        abonament.deleted = false

        abonament.save(flush: true)

        render [:]
    }

    def delete(){
        def id = Long.parseLong(params.id)
        def abonament = Abonament.get(id)
        def response = [:]
        if (!ClientAbonamente.countByAbonamentAndExpired(abonament, false)){
            abonament.deleted = true
            abonament.save(flush: true)
            response.status= true
        } else response.status= false

        render response as JSON
    }
}
