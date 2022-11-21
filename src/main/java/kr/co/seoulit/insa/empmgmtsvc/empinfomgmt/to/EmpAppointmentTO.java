package kr.co.seoulit.insa.empmgmtsvc.empinfomgmt.to;

import kr.co.seoulit.insa.commsvc.systemmgmt.to.BaseTO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class EmpAppointmentTO extends BaseTO {

	private String empCode, hosu, deptChangeStatus, positionChangeStatus, hobongChangeStatus,
			retirementStatus, dispatchStatus, leaveStatus, requestDate, approvalStatus,
			empName, title, appointmentDate, appointmentDetail, appointmentCount, requestStatus,
			beforeChange, afterChange, type;

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

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

	public String getDeptChangeStatus() {
		return deptChangeStatus;
	}

	public void setDeptChangeStatus(String deptChangeStatus) {
		this.deptChangeStatus = deptChangeStatus;
	}

	public String getPositionChangeStatus() {
		return positionChangeStatus;
	}

	public void setPositionChangeStatus(String positionChangeStatus) {
		this.positionChangeStatus = positionChangeStatus;
	}

	public String getHobongChangeStatus() {
		return hobongChangeStatus;
	}

	public void setHobongChangeStatus(String hobongChangeStatus) {
		this.hobongChangeStatus = hobongChangeStatus;
	}

	public String getRetirementStatus() {
		return retirementStatus;
	}

	public void setRetirementStatus(String retirementStatus) {
		this.retirementStatus = retirementStatus;
	}

	public String getDispatchStatus() {
		return dispatchStatus;
	}

	public void setDispatchStatus(String dispatchStatus) {
		this.dispatchStatus = dispatchStatus;
	}

	public String getLeaveStatus() {
		return leaveStatus;
	}

	public void setLeaveStatus(String leaveStatus) {
		this.leaveStatus = leaveStatus;
	}

	public String getRequestDate() {
		return requestDate;
	}

	public void setRequestDate(String requestDate) {
		this.requestDate = requestDate;
	}

	public String getApprovalStatus() {
		return approvalStatus;
	}

	public void setApprovalStatus(String approvalStatus) {
		this.approvalStatus = approvalStatus;
	}

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getAppointmentDate() {
		return appointmentDate;
	}

	public void setAppointmentDate(String appointmentDate) {
		this.appointmentDate = appointmentDate;
	}

	public String getAppointmentDetail() {
		return appointmentDetail;
	}

	public void setAppointmentDetail(String appointmentDetail) {
		this.appointmentDetail = appointmentDetail;
	}

	public String getAppointmentCount() {
		return appointmentCount;
	}

	public void setAppointmentCount(String appointmentCount) {
		this.appointmentCount = appointmentCount;
	}

	public String getRequestStatus() {
		return requestStatus;
	}

	public void setRequestStatus(String requestStatus) {
		this.requestStatus = requestStatus;
	}

	public String getBeforeChange() {
		return beforeChange;
	}

	public void setBeforeChange(String beforeChange) {
		this.beforeChange = beforeChange;
	}

	public String getAfterChange() {
		return afterChange;
	}

	public void setAfterChange(String afterChange) {
		this.afterChange = afterChange;
	}
}