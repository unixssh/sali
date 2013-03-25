package org.sali

class Produs {

    String name
    String description
    BigDecimal price
    CategorieProdus categorieProdus

    static constraints = {
        name(nullable: true)
        description(nullable: true)
        price(nullable: true)
    }
}
