package kr.co.seoulit.insa.salarysvc.salaryinfomgmt.to;

import kr.co.seoulit.insa.commsvc.systemmgmt.to.BaseTO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class RetirementSalaryTO extends BaseTO {
	
	private String
	position, 
	empname, 
	empcode, 
	hiredate, 
	settlementdate, 
	workingdate, 
	retirementsalary;

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getEmpname() {
		return empname;
	}

	public void setEmpname(String empname) {
		this.empname = empname;
	}

	public String getEmpcode() {
		return empcode;
	}

	public void setEmpcode(String empcode) {
		this.empcode = empcode;
	}

	public String getHiredate() {
		return hiredate;
	}

	public void setHiredate(String hiredate) {
		this.hiredate = hiredate;
	}

	public String getSettlementdate() {
		return settlementdate;
	}

	public void setSettlementdate(String settlementdate) {
		this.settlementdate = settlementdate;
	}

	public String getWorkingdate() {
		return workingdate;
	}

	public void setWorkingdate(String workingdate) {
		this.workingdate = workingdate;
	}

	public String getRetirementsalary() {
		return retirementsalary;
	}

	public void setRetirementsalary(String retirementsalary) {
		this.retirementsalary = retirementsalary;
	}

}
