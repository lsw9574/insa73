package kr.co.seoulit.insa.salarysvc.salarystdinfomgmt.controller;

import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import kr.co.seoulit.insa.salarysvc.salarystdinfomgmt.service.SalaryStdInfoMgmtService;
import kr.co.seoulit.insa.salarysvc.salarystdinfomgmt.to.BaseExtSalTO;


@RequestMapping("/salarystdinfomgmt/*")
@RestController
public class BaseExtSalController {
	
	@Autowired
	private SalaryStdInfoMgmtService salaryStdInfoMgmtService;	
	ModelMap map = null;

	@GetMapping("over-sal")
	public ModelMap findBaseExtSalList(){

		map = new ModelMap();

		try {

			ArrayList<BaseExtSalTO> baseExtSalList = salaryStdInfoMgmtService.findBaseExtSalList();
			map.put("baseExtSalList", baseExtSalList);
			map.put("errorMsg","success");
			map.put("errorCode", 0);

		} catch (Exception dae){
			map.clear();
			map.put("errorCode", -1);
			map.put("errorMsg", dae.getMessage());
		}
		return map;
	}

	
	@PutMapping("over-sal")
	public ModelMap modifyBaseExtSalList(@RequestBody ArrayList<BaseExtSalTO> baseExtSalList){
		map = new ModelMap();

		try {
			salaryStdInfoMgmtService.modifyBaseExtSalList(baseExtSalList);
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
