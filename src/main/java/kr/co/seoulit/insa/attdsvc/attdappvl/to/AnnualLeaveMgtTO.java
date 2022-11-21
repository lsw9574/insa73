package kr.co.seoulit.insa.attdsvc.attdappvl.to;

import kr.co.seoulit.insa.commsvc.systemmgmt.to.BaseTO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class AnnualLeaveMgtTO extends BaseTO{
	
	private String empCode, empName, applyYearMonth, afternoonOff,
	monthlyLeave, remainingHoliday, finalizeStatus;

	public String getEmpCode() {
		return empCode;
	}

	public void setEmpCode(String empCode) {
		this.empCode = empCode;
	}

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}

	public String getApplyYearMonth() {
		return applyYearMonth;
	}

	public void setApplyYearMonth(String applyYearMonth) {
		this.applyYearMonth = applyYearMonth;
	}

	public String getAfternoonOff() {
		return afternoonOff;
	}

	public void setAfternoonOff(String afternoonOff) {
		this.afternoonOff = afternoonOff;
	}

	public String getMonthlyLeave() {
		return monthlyLeave;
	}

	public void setMonthlyLeave(String monthlyLeave) {
		this.monthlyLeave = monthlyLeave;
	}

	public String getRemainingHoliday() {
		return remainingHoliday;
	}

	public void setRemainingHoliday(String remainingHoliday) {
		this.remainingHoliday = remainingHoliday;
	}

	public String getFinalizeStatus() {
		return finalizeStatus;
	}

	public void setFinalizeStatus(String finalizeStatus) {
		this.finalizeStatus = finalizeStatus;
	}
	
}
