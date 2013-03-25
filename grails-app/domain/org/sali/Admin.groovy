package org.sali

class Admin extends SecUser {

    String name
    String address
    String phone
    String mail

    static belongsTo = [sala: Sala]

    static constraints = {
        name(nullable: true)
        address(nullable: true)
        phone(nullable: true)
        mail(nullable: true)
    }
}
