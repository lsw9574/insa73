package kr.co.seoulit.insa.salarysvc.salarystdinfomgmt.controller;

import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import kr.co.seoulit.insa.salarysvc.salarystdinfomgmt.service.SalaryStdInfoMgmtService;
import kr.co.seoulit.insa.salarysvc.salarystdinfomgmt.to.SocialInsTO;

@RequestMapping("/salarystdinfomgmt/*")
@RestController
public class SocialInsController {
	
	@Autowired
	private SalaryStdInfoMgmtService salaryStdInfoMgmtService;	
	ModelMap map = null;
	
	@GetMapping("social")
	public ModelMap findBaseInsureList(@RequestParam String yearBox){
		
		map = new ModelMap();
			
		try {
			ArrayList<SocialInsTO> baseInsureList = salaryStdInfoMgmtService.findBaseInsureList(yearBox);
			SocialInsTO emptyBean = new SocialInsTO();
			
			map.put("baseInsureList", baseInsureList); 
			emptyBean.setStatus("insert");                     
			map.put("emptyBean", emptyBean);                 
			map.put("errorMsg","success");
			map.put("errorCode", 0);
			
		} catch (Exception dae){
			map.clear();
			map.put("errorCode", -1);
			map.put("errorMsg", dae.getMessage());	
		}
		return map;
	}
	
	
	@PutMapping("social")
	public ModelMap updateInsureData(@RequestBody ArrayList<SocialInsTO> baseInsureList){
		map = new ModelMap();
	
		try {
			salaryStdInfoMgmtService.updateInsureData(baseInsureList);
			map.put("errorMsg","success");
			map.put("errorCode", 0);

		} catch (DataAccessException dae){
			map.clear();
			map.put("errorCode", -1);
			map.put("errorMsg", dae.getMessage());
		}
		return map;
	}
	
	
	@DeleteMapping("social")
	public ModelMap deleteInsureData(@RequestBody ArrayList<SocialInsTO> baseInsureList){
		map = new ModelMap();
		
		try {
			salaryStdInfoMgmtService.deleteInsureData(baseInsureList);
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