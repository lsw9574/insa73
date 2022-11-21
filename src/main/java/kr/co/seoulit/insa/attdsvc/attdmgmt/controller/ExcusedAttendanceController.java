package kr.co.seoulit.insa.attdsvc.attdmgmt.controller;

import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import kr.co.seoulit.insa.attdsvc.attdmgmt.service.AttdMgmtService;
import kr.co.seoulit.insa.attdsvc.attdmgmt.to.RestAttdTO;

@RestController
@RequestMapping("/attdmgmt/*")
public class ExcusedAttendanceController {
	
	@Autowired
	private AttdMgmtService attdMgmtService;	
	ModelMap map = null;
	
	
	@PostMapping("excused-attnd")
	public ModelMap registRestAttd(@RequestBody RestAttdTO restAttd) {
		map = new ModelMap();
		try {
			attdMgmtService.registRestAttd(restAttd);
			map.put("errorMsg", "success");
			map.put("errorCode", 0);
			
		} catch (Exception dae) {
			map.clear();
			map.put("errorCode", -1);
			map.put("errorMsg", dae.getMessage());
		}
		return map;
	}

	
	@GetMapping("excused-attnd")
	public ModelMap findRestAttdList(@RequestParam String empCode,String startDate,String endDate,String code) {
		 
		map = new ModelMap();
		
		try {
			ArrayList<RestAttdTO> restAttdList = attdMgmtService.findRestAttdList(empCode, startDate, endDate, code); // 테이블 분리 해놔야 될 거 같은데 존나 병신같음 이거 
			map.put("restAttdList", restAttdList);
			map.put("errorMsg", "success");
			map.put("errorCode", 0);
			
		}catch (Exception dae) {
			map.clear();
			map.put("errorCode", -1);
			map.put("errorMsg", dae.getMessage());
		}
		return map;
	}

	@DeleteMapping("excused-attnd")
	public ModelMap removeRestAttdList(@RequestBody ArrayList<RestAttdTO> restAttdList) {
		
		map = new ModelMap();
		try {
			attdMgmtService.removeRestAttdList(restAttdList);
			map.put("errorMsg", "success");
			map.put("errorCode", 0);

		} catch (Exception dae) {
			map.clear();
			map.put("errorCode", -1);
			map.put("errorMsg", dae.getMessage());
		}
		return map;
	}

}
