package kr.co.seoulit.insa.empmgmtsvc.empinfomgmt.controller;

import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import kr.co.seoulit.insa.empmgmtsvc.empinfomgmt.service.EmpInfoService;
import kr.co.seoulit.insa.empmgmtsvc.empinfomgmt.to.EmpTO;


@RequestMapping("/empinfomgmt/*")
@RestController
public class EmpListController {
	
	@Autowired
	private EmpInfoService empInfoService;
	
	ModelMap map = null;

	@GetMapping("emplist")
	public ModelMap emplist(@RequestParam String value, String workplaceCode) {
		
		map = new ModelMap();
		
		try {
			String p_value = "전체부서";
			if (value != null) {
				p_value = value;
			}
			ArrayList<EmpTO> list = empInfoService.findEmpList(p_value,workplaceCode);
			map.put("list", list);

		} catch (Exception e) {
			map.put("errorCode", -1);
			map.put("errorMsg", e.getMessage());			
		}
		return map;
	}	
	
}