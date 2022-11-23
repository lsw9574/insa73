package kr.co.seoulit.insa.attdsvc.attdappvl.controller;

import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import kr.co.seoulit.insa.attdsvc.attdappvl.service.AttdAppvlService;
import kr.co.seoulit.insa.attdsvc.attdappvl.to.MonthAttdMgtTO;

@RestController
@RequestMapping("/attdappvl/*")
public class MonthlyAttendanceMgtController {
	
	@Autowired
	private AttdAppvlService attdAppvlService;
	ModelMap map = null;
	
	@GetMapping("month-attnd")
	public ModelMap findMonthAttdMgtList(@RequestParam String applyYearMonth,String workplaceCode){
		
		map = new ModelMap();
		try {
			ArrayList<MonthAttdMgtTO> monthAttdMgtList = attdAppvlService.findMonthAttdMgtList(applyYearMonth,workplaceCode);
			map.put("monthAttdMgtList", monthAttdMgtList);
			map.put("errorMsg","success");
			map.put("errorCode", 0);
			
		}catch (Exception dae){
			map.clear();
			map.put("errorCode", -1);
			map.put("errorMsg", dae.getMessage());
		}
		return map;
	}

	
	@PutMapping("month-attnd")
	public ModelMap modifyMonthAttdList(@RequestBody ArrayList<MonthAttdMgtTO> monthAttdMgtList){
		map = new ModelMap();
		try {
			attdAppvlService.modifyMonthAttdMgtList(monthAttdMgtList);
			map.put("errorMsg","success");
			map.put("errorCode", 0);
			
		}catch (Exception dae){
			map.clear();
			map.put("errorCode", -1);
			map.put("errorMsg", dae.getMessage());
		}
		return map;
	} 

}
