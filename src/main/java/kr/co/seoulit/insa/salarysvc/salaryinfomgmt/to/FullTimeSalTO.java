package kr.co.seoulit.insa.salarysvc.salaryinfomgmt.to;


import kr.co.seoulit.insa.commsvc.systemmgmt.to.BaseTO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class FullTimeSalTO extends BaseTO {
	
	private String
	empCode,
	applyYearMonth,
	basicSalary,
	positionSalary,
	familySalary,
	foodSalary,
	overWorkSalary,
	nationalPension,
	healthInsurance,
	longTermInsurance,
	employmentInsurance,
	religionDonation,
	incomeTax,
	residentTax,
	finalizeStatus,
	basicSalBefore;

	public String getEmpCode() {
		return empCode;
	}

	public void setEmpCode(String empCode) {
		this.empCode = empCode;
	}

	public String getApplyYearMonth() {
		return applyYearMonth;
	}

	public void setApplyYearMonth(String applyYearMonth) {
		this.applyYearMonth = applyYearMonth;
	}

	public String getBasicSalary() {
		return basicSalary;
	}

	public void setBasicSalary(String basicSalary) {
		this.basicSalary = basicSalary;
	}

	public String getPositionSalary() {
		return positionSalary;
	}

	public void setPositionSalary(String positionSalary) {
		this.positionSalary = positionSalary;
	}

	public String getFamilySalary() {
		return familySalary;
	}

	public void setFamilySalary(String familySalary) {
		this.familySalary = familySalary;
	}

	public String getFoodSalary() {
		return foodSalary;
	}

	public void setFoodSalary(String foodSalary) {
		this.foodSalary = foodSalary;
	}

	public String getOverWorkSalary() {
		return overWorkSalary;
	}

	public void setOverWorkSalary(String overWorkSalary) {
		this.overWorkSalary = overWorkSalary;
	}

	public String getNationalPension() {
		return nationalPension;
	}

	public void setNationalPension(String nationalPension) {
		this.nationalPension = nationalPension;
	}

	public String getHealthInsurance() {
		return healthInsurance;
	}

	public void setHealthInsurance(String healthInsurance) {
		this.healthInsurance = healthInsurance;
	}

	public String getLongTermInsurance() {
		return longTermInsurance;
	}

	public void setLongTermInsurance(String longTermInsurance) {
		this.longTermInsurance = longTermInsurance;
	}

	public String getEmploymentInsurance() {
		return employmentInsurance;
	}

	public void setEmploymentInsurance(String employmentInsurance) {
		this.employmentInsurance = employmentInsurance;
	}

	public String getReligionDonation() {
		return religionDonation;
	}

	public void setReligionDonation(String religionDonation) {
		this.religionDonation = religionDonation;
	}

	public String getIncomeTax() {
		return incomeTax;
	}

	public void setIncomeTax(String incomeTax) {
		this.incomeTax = incomeTax;
	}

	public String getResidentTax() {
		return residentTax;
	}

	public void setResidentTax(String residentTax) {
		this.residentTax = residentTax;
	}

	public String getFinalizeStatus() {
		return finalizeStatus;
	}

	public void setFinalizeStatus(String finalizeStatus) {
		this.finalizeStatus = finalizeStatus;
	}

	public String getBasicSalBefore() {
		return basicSalBefore;
	}

	public void setBasicSalBefore(String basicSalBefore) {
		this.basicSalBefore = basicSalBefore;
	}
	
}
	