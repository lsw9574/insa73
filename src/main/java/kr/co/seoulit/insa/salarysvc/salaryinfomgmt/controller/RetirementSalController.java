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
import kr.co.seoulit.insa.salarysvc.salaryinfomgmt.to.RetirementSalaryTO;


@RequestMapping("/salaryinfomgmt/*")
@RestController
public class RetirementSalController {
	
	@Autowired
	private SalaryInfoMgmtService salaryInfoMgmtService;	
	ModelMap map = null;

	@GetMapping("retirement")
	public ModelMap retirementSalaryList(@RequestParam String empCode){
		
		map = new ModelMap();
		
		try {
			
			ArrayList<RetirementSalaryTO> retirementSalaryList = salaryInfoMgmtService.findretirementSalaryList(empCode);
			map.put("retirementSalaryList", retirementSalaryList);
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
