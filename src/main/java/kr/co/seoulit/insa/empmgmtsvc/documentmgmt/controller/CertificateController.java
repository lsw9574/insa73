package kr.co.seoulit.insa.empmgmtsvc.documentmgmt.controller;

import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import kr.co.seoulit.insa.empmgmtsvc.documentmgmt.service.DocumentMgmtService;
import kr.co.seoulit.insa.empmgmtsvc.documentmgmt.to.CertificateTO;


@RequestMapping("/documentmgmt/*")
@RestController
public class CertificateController {
	@Autowired
	private DocumentMgmtService documentMgmtService;
	
	ModelMap map = null;

	@PostMapping("certificate")
	public ModelMap registRequest(@RequestBody CertificateTO certificate) {
		
		map = new ModelMap();

		try {
			Gson gson = new Gson();
			documentMgmtService.registRequest(certificate);
			map.put("errorMsg", "success");
			map.put("errorCode", 0);

		} catch (Exception dae) {
			map.clear();
			map.put("errorCode", -1);
			map.put("errorMsg", dae.getMessage());
		}
		return map;
	}
	
	@GetMapping("certificate")
	public ModelMap findCertificateList(@RequestParam String empCode,String startDate,String endDate) {
		
		map = new ModelMap();
		
		try {
			
			ArrayList<CertificateTO> certificateList = documentMgmtService.findCertificateList(empCode, startDate, endDate);
			map.put("certificateList", certificateList);
			map.put("errorMsg", "success");
			map.put("errorCode", 0);

		} catch (Exception dae) {
			map.clear();
			map.put("errorCode", -1);
			map.put("errorMsg", dae.getMessage());

		}
		return map;
	}
	
	@DeleteMapping("certificate")
	public ModelMap removeCertificateRequest(@RequestParam String sendData) {
		map = new ModelMap();
		
		try {
			Gson gson=new Gson();
			ArrayList<CertificateTO> certificateList=gson.fromJson(sendData, new TypeToken<ArrayList<CertificateTO>>() {
			}.getType());
			documentMgmtService.removeCertificateRequest(certificateList);
			map.put("errorMsg", "success");
			map.put("errorCode", 0);
			
		}catch(Exception dae) {
			map.clear();
			map.put("errorCode", -1);
			map.put("errorMsg", dae.getMessage());
			
		}
		return map;
	}
	
}
