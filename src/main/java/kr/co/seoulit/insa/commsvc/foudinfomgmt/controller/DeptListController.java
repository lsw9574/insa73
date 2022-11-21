package kr.co.seoulit.insa.commsvc.foudinfomgmt.controller;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import kr.co.seoulit.insa.commsvc.foudinfomgmt.service.FoudInfoMgmtService;
import kr.co.seoulit.insa.commsvc.foudinfomgmt.to.DeptTO;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

@RequestMapping("/foudinfomgmt/*")
@RestController
public class DeptListController {
	
	@Autowired
	private FoudInfoMgmtService foudInfoMgmtService;
	ModelMap map = null;
	
	
	@PutMapping("deptlist")
	public ModelMap batchDeptProcess(@RequestBody ArrayList<DeptTO> deptTO) {
		
		map = new ModelMap();

		try {
			foudInfoMgmtService.batchDeptProcess(deptTO);
			map.put("errorCode", 0);
			map.put("errorMsg", "부서가 등록/삭제가 완료되었습니다.");

		} catch (Exception e) {
			map.clear();
			map.put("errorCode", -1);
			map.put("errorMsg", e.getMessage());
		}
		return map;
	}
	
	
	@GetMapping("deptlist")
	public ModelMap findDeptList() {
		map = new ModelMap();		
		try {
			List<DeptTO> list = foudInfoMgmtService.findDeptList();
			DeptTO emptyBean = new DeptTO();
			map.put("emptyBean", emptyBean);
			map.put("list", list);
			
		}catch (Exception e) {
			map.clear();
			map.put("errorCode", -1);
			map.put("errorMsg", e.getMessage());
		}
		return map;
	}
}
