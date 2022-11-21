package kr.co.seoulit.insa.empmgmtsvc.empinfomgmt.to;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class EmpAppointmentInfoTO {

	private String title, hosu, approval_status, appointment_detail,
			appointment_date, appointment_count;

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getHosu() {
		return hosu;
	}

	public void setHosu(String hosu) {
		this.hosu = hosu;
	}

	public String getApproval_status() {
		return approval_status;
	}

	public void setApproval_status(String approval_status) {
		this.approval_status = approval_status;
	}

	public String getAppointment_detail() {
		return appointment_detail;
	}

	public void setAppointment_detail(String appointment_detail) {
		this.appointment_detail = appointment_detail;
	}

	public String getAppointment_date() {
		return appointment_date;
	}

	public void setAppointment_date(String appointment_date) {
		this.appointment_date = appointment_date;
	}

	public String getAppointment_count() {
		return appointment_count;
	}

	public void setAppointment_count(String appointment_count) {
		this.appointment_count = appointment_count;
	}
}
