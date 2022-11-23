package kr.co.seoulit.insa.empmgmtsvc.documentmgmt.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import kr.co.seoulit.insa.empmgmtsvc.documentmgmt.to.CertificateTO;

@Mapper
public interface CertificateMapper {
	
	public void insertCertificateRequest(CertificateTO certificate);
	public ArrayList<CertificateTO>selectCertificateList(HashMap<String, String> map);
	public void deleteCertificate(CertificateTO certificate);
	public ArrayList<CertificateTO> selectCertificateListByAllDept(String requestDate,String workplaceCode);
	public ArrayList<CertificateTO> selectCertificateListByDept(HashMap<String, String> map);
	public void updateCertificate(CertificateTO certificate);
		
}
