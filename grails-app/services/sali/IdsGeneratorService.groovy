package sali

import org.sali.Abonat

class IdsGeneratorService {

    static Random generator = new Random(19580427);

    def generateIds(Long abonatId) {
//        if(howMany < 1 )
//            return

        // find the greatest barcode already generated
        final query = Abonat.where {
            code >= max(code)
        }

        int greatestNumber = 100000 // if there are no voucherNumbers
        Abonat voucherNumber = query.find(max: 1)

        if(voucherNumber != null && voucherNumber.code != null ){
            greatestNumber = voucherNumber.code.toLong() / 1000000
            greatestNumber += 1
        }

        //  now we add new barCodes greater than greatestNumber
//        for(int i = 0 ; i < howMany ; i++){
//            VoucherNumber newVoucherNumber = VoucherNumber.newInstance(
//                    voucherId: ( voucherId < 0 ) ? null : voucherId ,
//                    barCode: new13digits( greatestNumber + i ), status: VoucherNumber.Status.UNASSIGNED.toString()
//            )
//
//            newVoucherNumber.save(flush: true)
//        }
    }


    long new13digits( long seed) {
        long result = seed * 1000000

        result += generator.nextInt(10) * 100000
        result += generator.nextInt(10) * 10000
        result += generator.nextInt(10) * 1000
        result += generator.nextInt(10) * 100
        result += generator.nextInt(10) * 10
        result += generator.nextInt(10)
        //return generatorService.generateEAN13CodeFrom12Digits(result)
        return result
    }
}
