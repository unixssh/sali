package org.sali

class CategorieProdus {

    String name
    String description

    static constraints = {
        name(nullable: true)
        description(nullable: true)
    }
}
