package kr.co.seoulit.insa.newempsvc.documentmgmt.to;

public class RecruitmentTO 
{
	private String pcode, pname, gender, tel, address, email, lastschool, dept, approvalStatus, status;
	private int age;
	private double p_avg, i_avg;
	
	public String getPcode() {
		return pcode;
	}
	public void setPcode(String pcode) {
		this.pcode = pcode;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getLastschool() {
		return lastschool;
	}
	public void setLastschool(String lastschool) {
		this.lastschool = lastschool;
	}
	public String getDept() {
		return dept;
	}
	public void setDept(String dept) {
		this.dept = dept;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public double getP_avg() {
		return p_avg;
	}
	public void setP_avg(double p_avg) {
		this.p_avg = p_avg;
	}
	public double getI_avg() {
		return i_avg;
	}
	public void setI_avg(double i_avg) {
		this.i_avg = i_avg;
	}
	public String getApprovalStatus() {
		return approvalStatus;
	}
	public void setApprovalStatus(String approval) {
		this.approvalStatus = approval;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
}
