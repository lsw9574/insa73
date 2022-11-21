package kr.co.seoulit.insa.commsvc.systemmgmt.to;

import lombok.Data;

@Data
public class ResultTO {
	
	private String errorCode, errorMsg;

	public String getErrorCode() {
		return errorCode;
	}

	public void setErrorCode(String errorCode) {
		this.errorCode = errorCode;
	}

	public String getErrorMsg() {
		return errorMsg;
	}

	public void setErrorMsg(String errorMsg) {
		this.errorMsg = errorMsg;
	}

}
