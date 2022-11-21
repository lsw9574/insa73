package kr.co.seoulit.insa.salarysvc.salaryinfomgmt.controller;

import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import kr.co.seoulit.insa.salarysvc.salaryinfomgmt.service.SalaryInfoMgmtService;
import kr.co.seoulit.insa.salarysvc.salaryinfomgmt.to.SalaryBonusTO;


@RequestMapping("/salaryinfomgmt/*")
@RestController
public class SalaryAwardsController {
	
	@Autowired
	private SalaryInfoMgmtService salaryInfoMgmtService;	
	ModelMap map = null;
	
	@GetMapping("awards")
	public ModelMap salInfo(@RequestParam String empCode){
		
		map = new ModelMap();
			
		try {
			ArrayList<SalaryBonusTO> list = salaryInfoMgmtService.findBonusSalary(empCode);	
			map.put("List", list);
			
		} catch (Exception e) {
			map.put("errorCode", -1);
			map.put("errorMsg", e.getMessage());
		}
		
		return map;
	}
	
}