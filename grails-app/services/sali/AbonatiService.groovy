package sali

import org.sali.Abonat
import org.sali.InOutHistory
import sun.misc.BASE64Decoder
import org.sali.ClientAbonamente

class AbonatiService {

    def springSecurityService

    def uploadCam(String id, String dataImg) {
       Abonat.withSession {
            def user = Abonat.lock(Long.parseLong(id))  // get Abonat form DB

            def indexb = dataImg.toString().indexOf(",")+1
            def indexe = dataImg.toString().size()

            def sb = new StringBuilder(dataImg)
            def mimeType = sb.substring(0, indexb)
            def lastMimeType = mimeType.substring(mimeType.indexOf(":")+1, mimeType.indexOf(";"))
            def base = sb.substring(indexb, indexe)

            byte[] decodedBytes = new BASE64Decoder().decodeBuffer(base.toString())
            user.avatar = decodedBytes   //save file in DB
            user.avatarType = lastMimeType //save mimeType in DB
            user.save()
        }
    }

    def addAbonat(String name, String sex, String code, String address, String cnp, String details, String email, String phone, String birthDate, String dataImg){
        def currentUseru = springSecurityService.currentUser
        def abonat = new Abonat()
        abonat.sala = currentUseru.sala
        abonat.name = name
        abonat.code = code
        abonat.sex = sex
        abonat.address = address
        abonat.cnp = cnp
        abonat.details = details
        abonat.email = email
        abonat.phone = phone
        abonat.birthDate = birthDate? new Date().parse('dd-MM-yyyy', birthDate) : new Date()
        abonat.active = true
        abonat.save(flush: true)
        if (dataImg) uploadCam(abonat.id.toString(), dataImg)
    }

    boolean deleteAbonat(String id){
        def abonat = Abonat.get(Long.parseLong(id))
        def cb = ClientAbonamente.findAllByAbonatAndCheckedIn(abonat, true)
        if(!cb){
            abonat.active = false
            abonat.save(flush: true)
            return true
        }
        return false
    }

    def getAbonatHistory(String abonatId, int page, int limit){
        def abonat = Abonat.get(Long.parseLong(abonatId))
        int offset = (page-1) * limit

        def history = InOutHistory.withCriteria {
            eq('abonat', abonat)
            firstResult(offset)
            maxResults(limit)
            order('lastUpdated', 'desc')
        }

        def historyList = []
        for (InOutHistory entry : history){
            def entry1 = [:]
            entry1.name = entry.abonament.name
            entry1.checkedIn = entry.checkedIn?entry.checkedIn?.format('dd/MM/yyyy HH:mm'):null
            entry1.checkedOut = entry.checkedOut?entry.checkedOut.format('dd/MM/yyyy HH:mm'):null
            entry1.operator = entry.user.username

            historyList.add(entry1)
        }

        return historyList
    }
}
