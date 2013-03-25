package sali
import org.sali.Abonat
import org.sali.ClientAbonamente
import org.sali.Sala
import org.sali.Abonament
import org.sali.SecUser
import org.sali.SecUserSecRole
import org.sali.SecRole
import org.sali.Admin
import org.sali.Operator

class DbPopulatorService {
    def addSubscribers() {


        1.times {
            Sala sala = new Sala(name: "GEDOTEAM", address: "Iuliu Maniu", phone: "072150539${it}", email: "gedoteam@gmail.com")
            sala.save(flush: true)
            Admin admin = new Admin(name: "admin", address: "adresa admin", phone: "0123", username: "admin", password: "admin", enabled: true, accountExpired: false, accountLocked: false, passwordExpired: false)
            admin.sala = sala
            admin.save(flush: true)
            Operator operator = new Operator(name: "operator", address: "adresa operator", phone: "123456", username: "operator", password: "operator", enabled: true, accountExpired: false, accountLocked: false, passwordExpired: false)
            operator.sala = sala
            operator.save(flush: true)

            def adminRole = SecRole.findByAuthority('ROLE_ADMIN') ?: new SecRole(authority: 'ROLE_ADMIN').save(failOnError: true)
            def operatorRole = SecRole.findByAuthority('ROLE_OPERATOR') ?: new SecRole(authority: 'ROLE_OPERATOR').save(failOnError: true)

            if (!admin.authorities.contains(adminRole)) {
                SecUserSecRole.create admin, adminRole
            }
            if (!operator.authorities.contains(operatorRole)) {
                SecUserSecRole.create operator, operatorRole
            }
        }

        1.times {
            Sala sala = new Sala(name: "OTHER GYM", address: "Iuliu Maniu", phone: "072150539${it}", email: "gedoteam@gmail.com")
            sala.save(flush: true)
            Admin admin = new Admin(name: "admin", address: "adresa admin", phone: "0123", username: "admin1", password: "admin1", enabled: true, accountExpired: false, accountLocked: false, passwordExpired: false)
            admin.sala = sala
            admin.save(flush: true)
            Operator operator = new Operator(name: "operator", address: "adresa operator", phone: "123456", username: "operator1", password: "operator1", enabled: true, accountExpired: false, accountLocked: false, passwordExpired: false)
            operator.sala = sala
            operator.save(flush: true)

            def adminRole = SecRole.findByAuthority('ROLE_ADMIN') ?: new SecRole(authority: 'ROLE_ADMIN').save(failOnError: true)
            def operatorRole = SecRole.findByAuthority('ROLE_OPERATOR') ?: new SecRole(authority: 'ROLE_OPERATOR').save(failOnError: true)

            if (!admin.authorities.contains(adminRole)) {
                SecUserSecRole.create admin, adminRole
            }
            if (!operator.authorities.contains(operatorRole)) {
                SecUserSecRole.create operator, operatorRole
            }
        }

        10.times {
            Abonament abonament = new  Abonament(name: "Abonament nume${it}", description: "descriere${it}", unlimited: false, noInTotal: 12, price: 100, deleted: false)
            abonament.sala = Sala.get(1)
            abonament.save(flush: true)
        }

        10.times {
            Abonat abonat = new Abonat(name: "FirstName${it} LastName${it}", cnp: "1${it}", birthDate: new Date(), phone: "077444555222${it}", email: "mail${it}@gmail.com", code: "12${it}", sex: Abonat.SexType.MASCULIN.toString(), details: 'User details here', lastUpdated: new Date(), dateCreated: new Date(), active: true, address: 'Sector 2, Bucuresti')
            abonat.sala = Sala.get(1)
            abonat.save(flush: true)

            3.times{
                ClientAbonamente ab1 = new ClientAbonamente(abonat: Abonat.get(abonat.id), abonament: Abonament.get(it+1), noIn: 2, startDate: new Date().minus(15), endDate: new Date().plus(10), expired:false, checkedIn: false)
                ab1.save(flush: true)
            }
        }


        5.times {
            Abonat abonat = new Abonat(name: "FirstName${it} LastName${it}", cnp: "1${it}", birthDate: new Date(), phone: "077444555222${it}", email: "mail${it}@gmail.com", code: "12${it}", sex: Abonat.SexType.MASCULIN.toString(), details: 'User details here', lastUpdated: new Date(), dateCreated: new Date(), active: true, address: 'Sector 2, Bucuresti')
            abonat.sala = Sala.get(2)
            abonat.save(flush: true)

            3.times{
                ClientAbonamente ab1 = new ClientAbonamente(abonat: Abonat.get(abonat.id), abonament: Abonament.get(it+1), noIn: 2, startDate: new Date().minus(15), endDate: new Date().plus(10), expired:false, checkedIn: false)
                ab1.save(flush: true)
            }
        }
    }
}