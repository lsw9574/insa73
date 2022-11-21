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
import kr.co.seoulit.insa.empmgmtsvc.empinfomgmt.to.EmpTO;
import kr.co.seoulit.insa.empmgmtsvc.empinfomgmt.to.FamilyInfoTO;
import kr.co.seoulit.insa.empmgmtsvc.empinfomgmt.to.LicenseInfoTO;
import kr.co.seoulit.insa.empmgmtsvc.empinfomgmt.to.WorkInfoTO;


@RequestMapping("/empinfomgmt/*")
@RestController
public class EmpDetailController {
	
	@Autowired
	private EmpInfoService empInfoService;
	ModelMap map = null;
	
	@GetMapping("empdetail/all")
	public ModelMap findAllEmployeeInfo(@RequestParam String empCode){
		
		map = new ModelMap();
		
		try{
			EmpTO empTO=empInfoService.findAllEmpInfo(empCode);
			ArrayList<WorkInfoTO> workInfoTO = empTO.getWorkInfo();
			ArrayList<LicenseInfoTO> licenseInfoTO = empTO.getLicenseInfoList();			
			ArrayList<FamilyInfoTO> familyInfoTO = empTO.getFamilyInfoList();
			
			map.put("empBean", empTO);
			map.put("emptyFamilyInfoBean",familyInfoTO );
			map.put("emptyLicenseInfoBean", licenseInfoTO);
			map.put("emptyWorkInfoBean", workInfoTO);
			map.put("errorMsg","success");
			map.put("errorCode", 0);

		} catch (Exception dae){
			map.clear();
			map.put("errorCode", -1);
			map.put("errorMsg", dae.getMessage());
		}
		return map;
	}
	
	@PutMapping("empdetail/empcode")
	public ModelMap modifyEmployee(@RequestBody EmpTO emp){
		
		map = new ModelMap();
		
		try{
			empInfoService.modifyEmployee(emp);
			map.put("errorMsg","success");
			map.put("errorCode", 0);

		} catch (Exception dae){
			map.clear();
			map.put("errorCode", -1);
			map.put("errorMsg", dae.getMessage());
		}
		return map;
	}
	
	@DeleteMapping("empdetail/empcode")
	public ModelMap removeEmployeeList(@RequestBody ArrayList<EmpTO> empList){
		
		map = new ModelMap();
		
		try{
			empInfoService.deleteEmpList(empList);
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
