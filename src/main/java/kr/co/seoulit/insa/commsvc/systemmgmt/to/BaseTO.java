package kr.co.seoulit.insa.commsvc.systemmgmt.to;

import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper=false)
public class BaseTO {
	
	protected String status = "normal";

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

}
