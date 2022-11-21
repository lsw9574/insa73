package kr.co.seoulit.insa.commsvc.systemmgmt.to;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class ReportTO {
	
   private String empName, hiredate, occupation, employmentType, position,
   				  address, detailAddress, deptName;

public String getEmpName() {
	return empName;
}

public void setEmpName(String empName) {
	this.empName = empName;
}

public String getHiredate() {
	return hiredate;
}

public void setHiredate(String hiredate) {
	this.hiredate = hiredate;
}

public String getOccupation() {
	return occupation;
}

public void setOccupation(String occupation) {
	this.occupation = occupation;
}

public String getEmploymentType() {
	return employmentType;
}

public void setEmploymentType(String employmentType) {
	this.employmentType = employmentType;
}

public String getPosition() {
	return position;
}

public void setPosition(String position) {
	this.position = position;
}

public String getAddress() {
	return address;
}

public void setAddress(String address) {
	this.address = address;
}

public String getDetailAddress() {
	return detailAddress;
}

public void setDetailAddress(String detailAddress) {
	this.detailAddress = detailAddress;
}

public String getDeptName() {
	return deptName;
}

public void setDeptName(String deptName) {
	this.deptName = deptName;
}
   

}