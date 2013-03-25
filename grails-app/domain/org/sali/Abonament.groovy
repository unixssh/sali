package org.sali

class Abonament {

    String name
    String description
    Boolean unlimited
    int noInTotal
    BigDecimal price
    Date lastUpdated
    Boolean deleted

    static belongsTo = [sala: Sala]

    static constraints = {
        name(nullable: true)
        description(nullable: true)
        unlimited(nullable: true)
        price(nullable: true)
        sala(nullable: true)
        deleted(nullable: true)
    }
}
