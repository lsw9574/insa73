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
import kr.co.seoulit.insa.empmgmtsvc.documentmgmt.to.proofTO;


@RequestMapping("/documentmgmt/*")
@RestController
public class ReceiptProofController {
	
	@Autowired
	private DocumentMgmtService documentMgmtService;
	
	ModelMap map = null;
	
	@PostMapping("receipt-proof")
	public ModelMap proofRequest(@RequestBody proofTO proof) {
		
		map = new ModelMap();

		try {
			documentMgmtService.proofRequest(proof);
			map.put("errorMsg", "success");
			map.put("errorCode", 0);

		} catch (Exception dae) {
			map.clear();
			map.put("errorCode", -1);
			map.put("errorMsg", dae.getMessage());

		}
		return map;
	}

	
	@GetMapping("receipt-proof")
	public ModelMap proofLookupList(@RequestParam String empCode,String startDate,String endDate,String Code,String workplaceCode) {
		
		map = new ModelMap();

		try {

			ArrayList<proofTO> proofList = documentMgmtService.proofLookupList(empCode,Code,startDate, endDate,workplaceCode);
			map.put("proofList", proofList);
			map.put("errorMsg", "success");
			map.put("errorCode", 0);

		} catch (Exception dae) {
			map.clear();
			map.put("errorCode", -1);
			map.put("errorMsg", dae.getMessage());

		}
		return map;
	}
	
	
	@DeleteMapping("receipt-proof")
	public ModelMap removeProofAttdList(@RequestBody ArrayList<proofTO> proofList) {
		map = new ModelMap();
		
		try {
			documentMgmtService.removeProofRequest(proofList);
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
