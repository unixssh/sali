package org.sali

class ClientAbonamente {

    Abonat abonat
    Abonament abonament
    int noIn
    Date startDate
    Date endDate
    Boolean expired
    Boolean checkedIn
    Date lastUpdated

    static constraints = {
        abonat(nullable: true)
        abonament(nullable: true)
        startDate(nullable: true)
        endDate(nullable: true)
        expired(nullable: true)
        noIn(nullable: true)
        checkedIn(nullable: true)
        lastUpdated(nullable: true)
    }
}
