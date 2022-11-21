package kr.co.seoulit.insa.commsvc.systemmgmt.to;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class AppointmentTO extends BaseTO {
   
   String appointmentName;

   public String getAppointmentName() {
      return appointmentName;
   }

   public void setAppointmentName(String appointmentName) {
      this.appointmentName = appointmentName;
   }

}