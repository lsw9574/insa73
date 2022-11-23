package kr.co.seoulit.insa.newempsvc.documentmgmt.to;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class ConditionTO {
	private int min_age;
	private int max_age;
	private String dept;
	private String last_school;
	private String half;
	private int year;
	private String hwp_file;
	private String career;
	private String workplaceCode;
	
	public String getDept() {
		return dept;
	}
	public void setDept(String dept) {
		this.dept = dept;
	}
	public String getCareer() {
		return career;
	}
	public void setCareer(String career) {
		this.career = career;
	}
	public String getLast_school() {
		return last_school;
	}
	public void setLast_school(String last_school) {
		this.last_school = last_school;
	}
	public int getYear() {
		return year;
	}
	public void setYear(int year) {
		this.year = year;
	}
	public int getMin_age() {
		return min_age;
	}
	public void setMin_age(int min_age) {
		this.min_age = min_age;
	}
	public int getMax_age() {
		return max_age;
	}
	public void setMax_age(int max_age) {
		this.max_age = max_age;
	}
	public String getHwp_file() {
		return hwp_file;
	}
	public void setHwp_file(String hwp_file) {
		this.hwp_file = hwp_file;
	}
	public String getHalf() {
		return half;
	}
	public void setHalf(String half) {
		this.half = half;
	}
	
	
}
