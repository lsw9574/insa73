package kr.co.seoulit.insa.empmgmtsvc.documentmgmt.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import kr.co.seoulit.insa.empmgmtsvc.documentmgmt.to.proofTO;

@Mapper
public interface ProofCertificateMapper{
	
	public void insertProofCertificateRequest(proofTO proof);
	public  ArrayList<proofTO> selectProofCertificateList(HashMap<String, String> map);
	public void deleteProof(proofTO proof);
	public ArrayList<proofTO> selectProofListByDept(HashMap<String, String> map);
	public ArrayList<proofTO> selectProofListByAllDept(String startDate,String workplaceCode);
	public void updateProof(proofTO proof);
	public void updateProofImg(HashMap<String, String> map);
	
}
