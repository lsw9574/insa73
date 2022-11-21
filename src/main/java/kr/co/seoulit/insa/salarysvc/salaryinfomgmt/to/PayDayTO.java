package kr.co.seoulit.insa.salarysvc.salaryinfomgmt.to;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class PayDayTO {
	
	private String
	ord,
	payment_date,
	smltn_issue,
	salary_type,
	remarks;

	public String getOrd() {
		return ord;
	}

	public void setOrd(String ord) {
		this.ord = ord;
	}

	public String getPayment_date() {
		return payment_date;
	}

	public void setPayment_date(String payment_date) {
		this.payment_date = payment_date;
	}

	public String getSmltn_issue() {
		return smltn_issue;
	}

	public void setSmltn_issue(String smltn_issue) {
		this.smltn_issue = smltn_issue;
	}

	public String getSalary_type() {
		return salary_type;
	}

	public void setSalary_type(String salary_type) {
		this.salary_type = salary_type;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

}
