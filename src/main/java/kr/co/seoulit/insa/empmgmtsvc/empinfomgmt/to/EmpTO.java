package kr.co.seoulit.insa.empmgmtsvc.empinfomgmt.to;

import java.util.ArrayList;

import kr.co.seoulit.insa.commsvc.systemmgmt.to.BaseTO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class EmpTO extends BaseTO {

	private String workplaceCode, empCode, empName, birthdate, gender, mobileNumber, address, detailAddress, postNumber, email,
			lastSchool, imgExtend, position, deptName, hobong, occupation, employment, authority, hiredate, achievement,
			ability, attitude;

	ArrayList<FamilyInfoTO> familyInfoList;
	ArrayList<LicenseInfoTO> licenseInfoList;
	ArrayList<WorkInfoTO> workInfo;

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

	public String getBirthdate() {
		return birthdate;
	}

	public void setBirthdate(String birthdate) {
		this.birthdate = birthdate;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getMobileNumber() {
		return mobileNumber;
	}

	public void setMobileNumber(String mobileNumber) {
		this.mobileNumber = mobileNumber;
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

	public String getPostNumber() {
		return postNumber;
	}

	public void setPostNumber(String postNumber) {
		this.postNumber = postNumber;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getLastSchool() {
		return lastSchool;
	}

	public void setLastSchool(String lastSchool) {
		this.lastSchool = lastSchool;
	}

	public String getImgExtend() {
		return "jpg";
	}

	public void setImgExtend(String imgExtend) {
		this.imgExtend = imgExtend;
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

	public String getHobong() {
		return hobong;
	}

	public void setHobong(String hobong) {
		this.hobong = hobong;
	}

	public String getOccupation() {
		return occupation;
	}

	public void setOccupation(String occupation) {
		this.occupation = occupation;
	}

	public String getEmployment() {
		return employment;
	}

	public void setEmployment(String employment) {
		this.employment = employment;
	}

	public String getAuthority() {
		return authority;
	}

	public void setAuthority(String authority) {
		this.authority = authority;
	}

	public String getHiredate() {
		return hiredate;
	}

	public void setHiredate(String hiredate) {
		this.hiredate = hiredate;
	}

	public String getAchievement() {
		return achievement;
	}

	public void setAchievement(String achievement) {
		this.achievement = achievement;
	}

	public String getAbility() {
		return ability;
	}

	public void setAbility(String ability) {
		this.ability = ability;
	}

	public String getAttitude() {
		return attitude;
	}

	public void setAttitude(String attitude) {
		this.attitude = attitude;
	}

	public ArrayList<FamilyInfoTO> getFamilyInfoList() {
		return familyInfoList;
	}

	public void setFamilyInfoList(ArrayList<FamilyInfoTO> familyInfoList) {
		this.familyInfoList = familyInfoList;
	}

	public ArrayList<LicenseInfoTO> getLicenseInfoList() {
		return licenseInfoList;
	}

	public void setLicenseInfoList(ArrayList<LicenseInfoTO> licenseInfoList) {
		this.licenseInfoList = licenseInfoList;
	}

	public ArrayList<WorkInfoTO> getWorkInfo() {
		return workInfo;
	}

	public void setWorkInfo(ArrayList<WorkInfoTO> workInfo) {
		this.workInfo = workInfo;
	}

}