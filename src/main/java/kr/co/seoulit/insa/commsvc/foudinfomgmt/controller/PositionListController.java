package kr.co.seoulit.insa.commsvc.foudinfomgmt.controller;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import kr.co.seoulit.insa.commsvc.foudinfomgmt.service.FoudInfoMgmtService;
import kr.co.seoulit.insa.commsvc.foudinfomgmt.to.PositionTO;
import kr.co.seoulit.insa.salarysvc.salarystdinfomgmt.to.BaseSalaryTO;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;


@RequestMapping("/foudinfomgmt/*")
@RestController
public class PositionListController {
	
	@Autowired
	private FoudInfoMgmtService foudInfoMgmtService;	
	ModelMap map = null;
	
	@GetMapping("positionlist")
	public ModelMap findPositionList() {
		
		map = new ModelMap();
	
			try {
				ArrayList<PositionTO> positionList = foudInfoMgmtService.findPositionList();
				BaseSalaryTO positionTO = new BaseSalaryTO();
				
				map.put("positionList", positionList);
				map.put("emptyPositionBean", positionTO);
				map.put("errorCode",0);
				map.put("errorMsg","success");
				
			} catch (DataAccessException dae){	
				map.clear();
				map.put("errorCode", -1);
				map.put("errorMsg", dae.getMessage());
			}
			return map;
	}
	
	@PutMapping("positionlist")
	public ModelMap modifyPosition(@RequestBody ArrayList<PositionTO> positionList){
		map = new ModelMap();
		try{
			
			foudInfoMgmtService.modifyPosition(positionList);
			map.put("errorMsg","success");
			map.put("errorCode", 0);
			
		} catch (DataAccessException dae){
			map.clear();
			map.put("errorCode", -1);
			map.put("errorMsg", dae.getMessage());
		}
		return map;
	}	

}
