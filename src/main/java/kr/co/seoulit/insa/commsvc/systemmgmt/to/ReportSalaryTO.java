package kr.co.seoulit.insa.commsvc.systemmgmt.to;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class ReportSalaryTO {
	
	private String empName, position, deptName, hiredate, applyYearMonth, totalExtSal,
				   totalDeduction, totalPayment, realSalary, salary, cost, healthIns,
				   goyongIns, janggiIns, gukmin;

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public String getHiredate() {
		return hiredate;
	}

	public void setHiredate(String hiredate) {
		this.hiredate = hiredate;
	}

	public String getApplyYearMonth() {
		return applyYearMonth;
	}

	public void setApplyYearMonth(String applyYearMonth) {
		this.applyYearMonth = applyYearMonth;
	}

	public String getTotalExtSal() {
		return totalExtSal;
	}

	public void setTotalExtSal(String totalExtSal) {
		this.totalExtSal = totalExtSal;
	}

	public String getTotalDeduction() {
		return totalDeduction;
	}

	public void setTotalDeduction(String totalDeduction) {
		this.totalDeduction = totalDeduction;
	}

	public String getTotalPayment() {
		return totalPayment;
	}

	public void setTotalPayment(String totalPayment) {
		this.totalPayment = totalPayment;
	}

	public String getRealSalary() {
		return realSalary;
	}

	public void setRealSalary(String realSalary) {
		this.realSalary = realSalary;
	}

	public String getSalary() {
		return salary;
	}

	public void setSalary(String salary) {
		this.salary = salary;
	}

	public String getCost() {
		return cost;
	}

	public void setCost(String cost) {
		this.cost = cost;
	}

	public String getHealthIns() {
		return healthIns;
	}

	public void setHealthIns(String healthIns) {
		this.healthIns = healthIns;
	}

	public String getGoyongIns() {
		return goyongIns;
	}

	public void setGoyongIns(String goyongIns) {
		this.goyongIns = goyongIns;
	}

	public String getJanggiIns() {
		return janggiIns;
	}

	public void setJanggiIns(String janggiIns) {
		this.janggiIns = janggiIns;
	}

	public String getGukmin() {
		return gukmin;
	}

	public void setGukmin(String gukmin) {
		this.gukmin = gukmin;
	}
	
}
