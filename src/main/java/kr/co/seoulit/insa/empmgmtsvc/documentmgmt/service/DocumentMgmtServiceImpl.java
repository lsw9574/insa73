package kr.co.seoulit.insa.empmgmtsvc.documentmgmt.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.seoulit.insa.empmgmtsvc.documentmgmt.mapper.CertificateMapper;
import kr.co.seoulit.insa.empmgmtsvc.documentmgmt.mapper.ProofCertificateMapper;
import kr.co.seoulit.insa.empmgmtsvc.documentmgmt.to.CertificateTO;
import kr.co.seoulit.insa.empmgmtsvc.documentmgmt.to.proofTO;

@Service
public class DocumentMgmtServiceImpl implements DocumentMgmtService {
	
	@Autowired
	private CertificateMapper certificateMapper;
	@Autowired
	private ProofCertificateMapper proofCertificateMapper;


	
	@Override
	public void registRequest(CertificateTO certificate) {
		certificateMapper.insertCertificateRequest(certificate);
		
	}

	@Override
	public ArrayList<CertificateTO> findCertificateList(String empCode, String startDate, String endDate) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("empCode", empCode);
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		
		ArrayList<CertificateTO> certificateList=null;
		certificateList = certificateMapper.selectCertificateList(map);
		return certificateList;
		
	}

	@Override
	public void removeCertificateRequest(ArrayList<CertificateTO> certificateList) {

			for (CertificateTO certificate : certificateList) {
				certificateMapper.deleteCertificate(certificate);
			}
			
	}

	@Override
	public ArrayList<CertificateTO> findCertificateListByDept(String deptName, String startDate, String endDate,String workplaceCode) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("deptName", deptName);
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		map.put("workplaceCode",workplaceCode);
		
		ArrayList<CertificateTO> certificateList = null;
			if (deptName.equals("모든부서")) {
				certificateList = certificateMapper.selectCertificateListByAllDept(startDate,workplaceCode);
			} else {
				certificateList = certificateMapper.selectCertificateListByDept(map);
			}
		return certificateList;
		
	}

	@Override
	public void modifyCertificateList(ArrayList<CertificateTO> certificateList) {

			for (CertificateTO certificate : certificateList) {


				if (certificate.getStatus().equals("update")) {
					certificateMapper.updateCertificate(certificate);
				}
			}
			
	}

	public void proofRequest(proofTO proof) {

		proofCertificateMapper.insertProofCertificateRequest(proof);

	}

	@Override
	public ArrayList<proofTO> proofLookupList(String empCode, String Code, String startDate, String endDate,String workplaceCode) {
		HashMap<String, String> map = new HashMap<>();
		map.put("empCode", empCode);
		map.put("proofTypeCode", Code);
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		map.put("workplaceCode", workplaceCode);
		ArrayList<proofTO> proofLookupList=null;
		
		proofLookupList = proofCertificateMapper.selectProofCertificateList(map);
		return proofLookupList;
		
	}

	@Override
	public void removeProofRequest(ArrayList<proofTO> proofList) {

			for (proofTO proof : proofList) {
				proofCertificateMapper.deleteProof(proof);
			}
			
	}

	@Override
	public ArrayList<proofTO> findProofListByDept(String deptName, String startDate, String endDate,String workplaceCode) {
		HashMap<String, String> map = new HashMap<>();
		map.put("deptName", deptName);
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		map.put("workplaceCode", workplaceCode);
		ArrayList<proofTO> proofList = null;
		
		if (deptName.equals("모든부서")) {
			proofList = proofCertificateMapper.selectProofListByAllDept(startDate,workplaceCode);
		} else {
			proofList = proofCertificateMapper.selectProofListByDept(map);
		}
		return proofList;
	}

	@Override
	public void modifyProofList(ArrayList<proofTO> proofList) {
		
		for (proofTO proof : proofList) {
			System.out.println(proof.getApplovalStatus());

			if (proof.getStatus().equals("update")) {
				proofCertificateMapper.updateProof(proof);
			}
		}

	}

	public void rsgistProofImg(String cashCode, String proofImg) {
		HashMap<String, String> map = new HashMap<>();
		map.put("cashCode", cashCode);
		map.put("proofImg", proofImg);
		
		proofCertificateMapper.updateProofImg(map);

	}
	
}
