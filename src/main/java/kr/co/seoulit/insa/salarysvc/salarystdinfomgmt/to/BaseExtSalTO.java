package kr.co.seoulit.insa.salarysvc.salarystdinfomgmt.to;

import kr.co.seoulit.insa.commsvc.systemmgmt.to.BaseTO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class BaseExtSalTO  extends BaseTO{
	
	private String
	extSalCode,
	extSalName,
	ratio;

	public String getExtSalCode() {
		return extSalCode;
	}

	public void setExtSalCode(String extSalCode) {
		this.extSalCode = extSalCode;
	}

	public String getExtSalName() {
		return extSalName;
	}

	public void setExtSalName(String extSalName) {
		this.extSalName = extSalName;
	}

	public String getRatio() {
		return ratio;
	}

	public void setRatio(String ratio) {
		this.ratio = ratio;
	}

}
