package org.sali

class InOutHistory {

    Abonat abonat
    Abonament abonament
    Date checkedIn
    Date checkedOut
    SecUser user
    Date lastUpdated

    static belongsTo = [abonat:Abonat]

    static constraints = {
        abonat(nullable: true)
        checkedIn(nullable: true)
        checkedOut(nullable: true)
        abonament(nullable: true)
        user(nullable: true)
        lastUpdated(nullable: true)
    }
}
