package kr.co.seoulit.insa.salarysvc.salarystdinfomgmt.to;

import kr.co.seoulit.insa.commsvc.systemmgmt.to.BaseTO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class SocialInsTO extends BaseTO{
	
	private String
	attributionYear,
	healthinsureRates,
	longtermcareRates,
	nationpenisionRates,
	teachpenisionRates,
	empinsureRates,
	wrkinsureRates,
	jobstabilRates,
	vocacompetencyRates,
	industinsureRates,
	industinsurecharRates;

	public String getAttributionYear() {
		return attributionYear;
	}

	public void setAttributionYear(String attributionYear) {
		this.attributionYear = attributionYear;
	}

	public String getHealthinsureRates() {
		return healthinsureRates;
	}

	public void setHealthinsureRates(String healthinsureRates) {
		this.healthinsureRates = healthinsureRates;
	}

	public String getLongtermcareRates() {
		return longtermcareRates;
	}

	public void setLongtermcareRates(String longtermcareRates) {
		this.longtermcareRates = longtermcareRates;
	}

	public String getNationpenisionRates() {
		return nationpenisionRates;
	}

	public void setNationpenisionRates(String nationpenisionRates) {
		this.nationpenisionRates = nationpenisionRates;
	}

	public String getTeachpenisionRates() {
		return teachpenisionRates;
	}

	public void setTeachpenisionRates(String teachpenisionRates) {
		this.teachpenisionRates = teachpenisionRates;
	}

	public String getEmpinsureRates() {
		return empinsureRates;
	}

	public void setEmpinsureRates(String empinsureRates) {
		this.empinsureRates = empinsureRates;
	}

	public String getWrkinsureRates() {
		return wrkinsureRates;
	}

	public void setWrkinsureRates(String wrkinsureRates) {
		this.wrkinsureRates = wrkinsureRates;
	}

	public String getJobstabilRates() {
		return jobstabilRates;
	}

	public void setJobstabilRates(String jobstabilRates) {
		this.jobstabilRates = jobstabilRates;
	}

	public String getVocacompetencyRates() {
		return vocacompetencyRates;
	}

	public void setVocacompetencyRates(String vocacompetencyRates) {
		this.vocacompetencyRates = vocacompetencyRates;
	}

	public String getIndustinsureRates() {
		return industinsureRates;
	}

	public void setIndustinsureRates(String industinsureRates) {
		this.industinsureRates = industinsureRates;
	}

	public String getIndustinsurecharRates() {
		return industinsurecharRates;
	}

	public void setIndustinsurecharRates(String industinsurecharRates) {
		this.industinsurecharRates = industinsurecharRates;
	}

}