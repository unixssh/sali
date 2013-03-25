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
class AbonamentCommand {

    String name
    String description
    Boolean unlimited
    int noInTotal
    BigDecimal price
    Date lastUpdated
    Boolean deleted

    static constraints = {
        name(blank: false, nullable: false, minSize: 3, maxSize: 30)
        price(blank: false, nullable: false)
    }
}
