package kr.co.seoulit.insa.commsvc.systemmgmt.to;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class DetailCodeTO extends BaseTO{
	
	String detailCodeNumber,codeNumber, detailCodeName, detailCodeNameusing;

	public String getDetailCodeNumber() {
		return detailCodeNumber;
	}

	public void setDetailCodeNumber(String detailCodeNumber) {
		this.detailCodeNumber = detailCodeNumber;
	}

	public String getCodeNumber() {
		return codeNumber;
	}

	public void setCodeNumber(String codeNumber) {
		this.codeNumber = codeNumber;
	}

	public String getDetailCodeName() {
		return detailCodeName;
	}

	public void setDetailCodeName(String detailCodeName) {
		this.detailCodeName = detailCodeName;
	}

	public String getDetailCodeNameusing() {
		return detailCodeNameusing;
	}

	public void setDetailCodeNameusing(String detailCodeNameusing) {
		this.detailCodeNameusing = detailCodeNameusing;
	}

}
