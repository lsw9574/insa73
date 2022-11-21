package kr.co.seoulit.insa.empmgmtsvc.documentmgmt.to;

import kr.co.seoulit.insa.commsvc.systemmgmt.to.BaseTO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class proofTO extends BaseTO {
	
	private String empName, empCode, proofTypeCode, proofTypeName, startDate,
	               position, dept,cash, cause, receipt, applovalStatus;

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}

	public String getEmpCode() {
		return empCode;
	}

	public void setEmpCode(String empCode) {
		this.empCode = empCode;
	}

	public String getProofTypeCode() {
		return proofTypeCode;
	}

	public void setProofTypeCode(String proofTypeCode) {
		this.proofTypeCode = proofTypeCode;
	}

	public String getProofTypeName() {
		return proofTypeName;
	}

	public void setProofTypeName(String proofTypeName) {
		this.proofTypeName = proofTypeName;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getDept() {
		return dept;
	}

	public void setDept(String dept) {
		this.dept = dept;
	}

	public String getCash() {
		return cash;
	}

	public void setCash(String cash) {
		this.cash = cash;
	}

	public String getCause() {
		return cause;
	}

	public void setCause(String cause) {
		this.cause = cause;
	}

	public String getReceipt() {
		return receipt;
	}

	public void setReceipt(String receipt) {
		this.receipt = receipt;
	}

	public String getApplovalStatus() {
		return applovalStatus;
	}

	public void setApplovalStatus(String applovalStatus) {
		this.applovalStatus = applovalStatus;
	}


}
