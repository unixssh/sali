package org.sali

class AbonatProduse {

    Abonat abonat
    Produs produs
    Date dateBuy
    BigDecimal totalToPay

    static belongsTo = [abonat:Abonat]

    static constraints = {
        abonat(nullable: true)
        produs(nullable: true)
        dateBuy(nullable: true)
        totalToPay(nullable: true)
    }
}
