package org.sali

class Sala {

    String name
    String address
    String phone
    String email

    static hasMany = [abonati: Abonat, abonamente: Abonament, operatori: Operator, admini: Admin]

    static constraints = {
        name(nullable: true)
        address(nullable: true)
        phone(nullable: true)
        email(nullable: true)
        abonati(nullable: true)
        abonamente(nullable: true)
    }
}
