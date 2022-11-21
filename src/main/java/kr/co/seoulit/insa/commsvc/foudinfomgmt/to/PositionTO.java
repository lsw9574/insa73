package kr.co.seoulit.insa.commsvc.foudinfomgmt.to;

import kr.co.seoulit.insa.commsvc.systemmgmt.to.BaseTO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class PositionTO extends BaseTO {
	
	private String positionCode,position,basesalary,hobongratio;

	public String getPositionCode() {
		return positionCode;
	}

	public void setPositionCode(String positionCode) {
		this.positionCode = positionCode;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getBasesalary() {
		return basesalary;
	}

	public void setBasesalary(String basesalary) {
		this.basesalary = basesalary;
	}

	public String getHobongratio() {
		return hobongratio;
	}

	public void setHobongratio(String hobongratio) {
		this.hobongratio = hobongratio;
	}

}
