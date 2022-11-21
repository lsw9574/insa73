package kr.co.seoulit.insa.empmgmtsvc.empinfomgmt.controller;

import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import kr.co.seoulit.insa.empmgmtsvc.empinfomgmt.service.EmpInfoService;
import kr.co.seoulit.insa.empmgmtsvc.empinfomgmt.to.EmpEvalTO;


@RequestMapping("/empinfomgmt/*")
@RestController
public class EmpEvalApprovalController {
	
	@Autowired
	private EmpInfoService empInfoService;
	
	ModelMap map = null;
	
	@GetMapping("evaluation-approval")
	public ModelMap findEmpEvalAppoList(@RequestParam String deptName,String year) {
		
		map = new ModelMap();
		
		try {	
			ArrayList<EmpEvalTO> empEvalList = empInfoService.findEmpEval(deptName,year);
			map.put("empEvalList", empEvalList);
			map.put("errorMsg", "success");
			map.put("errorCode", 0);
		} catch (Exception dae) {
			map.clear();
			map.put("errorCode", -1);
			map.put("errorMsg", dae.getMessage());
		}
		return map;
	}
	
	
	@PutMapping("evaluation-approval")
	public ModelMap modifyEmpEvalList(@RequestBody ArrayList<EmpEvalTO> empevalList) {
		
		map = new ModelMap();
		
		try {
			empInfoService.modifyEmpEvalList(empevalList);
			map.put("errorMsg","success");
			map.put("errorCode", 0);
			
		} catch (Exception dae) {
			map.clear();
			map.put("errorCode", -1);
			map.put("errorMsg", dae.getMessage());

		}
		return map;
	}
}
