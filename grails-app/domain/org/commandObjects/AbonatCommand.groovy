package org.commandObjects

import grails.validation.Validateable

/**
 * Created with IntelliJ IDEA.
 * User: Bogdan
 * Date: 04.03.2013
 * Time: 16:52
 * To change this template use File | Settings | File Templates.
 */

 @Validateable
class AbonatCommand {

    String name
    String cnp
    String birthDate
    String phone
    String email
    String code
    String sex
    String details
    String address

    static constraints = {

        name(blank: false, nullable: false, minSize: 3, maxSize: 30)
        cnp(blank: false, nullable: false, minSize: 13, maxSize: 13, matches: "\\d+", unique: true)
        phone(blank: false, nullable: false, minSize: 10, maxSize: 10)
        email(blank: false, nullable: false, email: true)
        code(blank: false, nullable: false, unique: true)
    }

}
