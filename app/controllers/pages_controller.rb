class PagesController < ApplicationController
  def home
  end
  def sms
  end
end

class Sms
   #Rückgabewert des Namens
   def getsmsname
       @name
   end
   #Rückgabewert der Nummer
   def getsmsnumber
        @number
   end
   #Rückabewert der Anzahl der sms anzahl 1 bis x
   def getsmsanz
        @anzsms
   end
   #Rückgabe des smstextes in arrayform gertrennt nach 160 zeichen
   def getsmstextarray
        @smstextarray
   end
   #übergabe der Formularinhalte (sms name, sms nummer, sms text) werte stammen aus views/pages/home.html.erb
   def setsms(setname, setnumber, settext)
        @name=setname
        @number=setnumber
        text=settext
        # löschen von leerzeichen vor und nach dem text
        @smstext = text.strip
        #Länge des textes ermitteln
        @smslength =  @smstext.length
        #anzahl der sms ermitteln
        anzsms =@smslength/160.0
        #wichtig bei sms mit weniger 160 zeichen wird auf 1 sms aufgerunder. Auf runden auf die nächst höhere sms anzahl, wenn die anzahl der zeichen nicht glatt durch 160 teilbar ist.
        if anzsms%1 !=1
            anzsms=anzsms+1
        else
        end
        #löschen der Nachkommastellen
        anzsms        = anzsms-(anzsms%1)
        @anzsms       = anzsms.to_i
        #vobereitung für das Trennens der sms nach 160 zeichen
        str           = @smstext
        n             = @smslength
        boundary      = 160
        durchgang     = 1
        #Arren zum speichern der smssegmente
        @smstextarray = []
        #schleife zum trennen des textes und speichern im array
        while durchgang<=@anzsms
            @smstextarray << str.slice(0, boundary)
            #speichern des resttextes für den nächsten schleifen durchgang
            str = str.slice(boundary, n)
            durchgang=durchgang+1
        end
        @smstextarray
    end
end

#klasse für das versenden der sms
class SmsSend

  def send_sms_message(text, to, from)
        deliver_message_via_carrier(text, to, from)
  end
  def deliver_message_via_carrier(text, to, from)
        SMS_CARRIER.deliver_message(text, to, from)
  end
end
