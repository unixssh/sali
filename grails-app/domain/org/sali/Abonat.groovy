package org.sali

class Abonat {
    public static final enum SexType{MASCULIN, FEMININ}

    String name
    String cnp
    Date birthDate
    String phone
    String email
    String code
    String sex
    String details
    String address
    Date lastUpdated
    Date dateCreated
    boolean active
    byte[] avatar
    String avatarType

    static belongsTo = [sala: Sala]

    static constraints = {
        name(nullable: false)
        cnp(nullable: false, unique: true)
        birthDate(nullable: true)
        phone(nullable: false)
        email(nullable: false)
        code(nullable: true, unique: true)
        sex(nullable: true)
        address(nullable: true)
        dateCreated(nullable: true)
        sala(nullable: true)
        details(nullable: true)
        avatar(nullable:true, maxSize: 50000000 /* 16K */)
        avatarType(nullable:true)
    }
}
