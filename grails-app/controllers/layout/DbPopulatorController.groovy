package layout

import org.sali.Abonat
import grails.converters.JSON

import java.text.DateFormat
import java.text.SimpleDateFormat

class DbPopulatorController {

    def index() {
        def abonatsList = Abonat.findAll()
        render abonatsList as JSON
    }

    def update(){
        println params
         if (params.lastUpdated ==""){
            render Abonat.findAll() as JSON
        }
        else {
            String str =  new String(params.lastUpdated).replace("T"," ")
            String lastStr = new String(str).replace("Z","")
            DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.ENGLISH);
            df.setTimeZone(TimeZone.getTimeZone("GMT"));
            Date result =  df.parse(lastStr);
            def list = Abonat.findAllByLastUpdatedGreaterThan(result)
            render list as JSON
        }
    }

}