package kr.co.seoulit.insa.empmgmtsvc.empinfomgmt.to;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class EmpAppointmentTypeTO {

	private String empCode, hosu, lastDept, nextDept, appointmentDate, dispatchDate, dispatchReturnDate, dispatchPosition, dispatchDept, lastWorkplace,
			lastRegion,	lastHobong, nextHobong, promotionDate, lastPosition, nextPosition, retirementDate, leaveDate, reinstatementDate,
			leaveType, empName;

	public String getEmpCode() {
		return empCode;
	}

	public void setEmpCode(String empCode) {
		this.empCode = empCode;
	}

	public String getHosu() {
		return hosu;
	}

	public void setHosu(String hosu) {
		this.hosu = hosu;
	}

	public String getLastDept() {
		return lastDept;
	}

	public void setLastDept(String lastDept) {
		this.lastDept = lastDept;
	}

	public String getNextDept() {
		return nextDept;
	}

	public void setNextDept(String nextDept) {
		this.nextDept = nextDept;
	}

	public String getAppointmentDate() {
		return appointmentDate;
	}

	public void setAppointmentDate(String appointmentDate) {
		this.appointmentDate = appointmentDate;
	}

	public String getDispatchDate() {
		return dispatchDate;
	}

	public void setDispatchDate(String dispatchDate) {
		this.dispatchDate = dispatchDate;
	}

	public String getDispatchReturnDate() {
		return dispatchReturnDate;
	}

	public void setDispatchReturnDate(String dispatchReturnDate) {
		this.dispatchReturnDate = dispatchReturnDate;
	}

	public String getDispatchPosition() {
		return dispatchPosition;
	}

	public void setDispatchPosition(String dispatchPosition) {
		this.dispatchPosition = dispatchPosition;
	}

	public String getLastWorkplace() {
		return lastWorkplace;
	}

	public void setLastWorkplace(String lastWorkplace) {
		this.lastWorkplace = lastWorkplace;
	}

	public String getLastRegion() {
		return lastRegion;
	}

	public void setLastRegion(String lastRegion) {
		this.lastRegion = lastRegion;
	}

	public String getLastHobong() {
		return lastHobong;
	}

	public void setLastHobong(String lastHobong) {
		this.lastHobong = lastHobong;
	}

	public String getNextHobong() {
		return nextHobong;
	}

	public void setNextHobong(String nextHobong) {
		this.nextHobong = nextHobong;
	}

	public String getPromotionDate() {
		return promotionDate;
	}

	public void setPromotionDate(String promotionDate) {
		this.promotionDate = promotionDate;
	}

	public String getLastPosition() {
		return lastPosition;
	}

	public void setLastPosition(String lastPosition) {
		this.lastPosition = lastPosition;
	}

	public String getNextPosition() {
		return nextPosition;
	}

	public void setNextPosition(String nextPosition) {
		this.nextPosition = nextPosition;
	}

	public String getRetirementDate() {
		return retirementDate;
	}

	public void setRetirementDate(String retirementDate) {
		this.retirementDate = retirementDate;
	}

	public String getLeaveDate() {
		return leaveDate;
	}

	public void setLeaveDate(String leaveDate) {
		this.leaveDate = leaveDate;
	}

	public String getReinstatementDate() {
		return reinstatementDate;
	}

	public void setReinstatementDate(String reinstatementDate) {
		this.reinstatementDate = reinstatementDate;
	}

	public String getLeaveType() {
		return leaveType;
	}

	public void setLeaveType(String leaveType) {
		this.leaveType = leaveType;
	}

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}
}
