package kr.co.seoulit.insa.empmgmtsvc.empinfomgmt.controller;

import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import com.google.gson.Gson;
import kr.co.seoulit.insa.empmgmtsvc.empinfomgmt.service.EmpInfoService;
import kr.co.seoulit.insa.empmgmtsvc.empinfomgmt.to.EmpEvalTO;


@RequestMapping("/empinfomgmt/*")
@RestController
public class EmpEvalController {
	
	@Autowired
	private EmpInfoService empInfoService;
	
	ModelMap map = null;
	
	@PostMapping("evaluation")
	public ModelMap registEmpEval(@RequestBody EmpEvalTO emp){
		map = new ModelMap();
		
		try{
			empInfoService.registEmpEval(emp);
			map.put("errorMsg","success");
			map.put("errorCode", 0);
			
		} catch (Exception dae){
			map.clear();
			map.put("errorCode", -1);
			map.put("errorMsg", dae.getMessage());
		}
		return map;
	}
	
	
	@GetMapping("evaluation")
	public ModelMap findEmpEval(){
		map = new ModelMap();		
		try{
			
			ArrayList<EmpEvalTO> empevalList = empInfoService.findEmpEval();			
			map.put("empevalList", empevalList);
			map.put("errorMsg","success");
			map.put("errorCode", 0);

		} catch (Exception dae){
			map.clear();
			map.put("errorCode", -1);
			map.put("errorMsg", dae.getMessage());
		}
		return map;
	}
	
	@DeleteMapping("evaluation")
	public ModelMap removeEmpEvalList(@RequestParam String emp_code,String apply_day){
		map = new ModelMap();
		try{			
			empInfoService.removeEmpEvalList(emp_code, apply_day);
			map.put("errorMsg","success");
			map.put("errorCode", 0);

		} catch (Exception dae){	
			map.clear();
			map.put("errorCode", -1);
			map.put("errorMsg", dae.getMessage());
		}
		return map;
	}
	
}
