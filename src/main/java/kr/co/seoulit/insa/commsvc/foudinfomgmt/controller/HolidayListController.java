package kr.co.seoulit.insa.commsvc.foudinfomgmt.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import kr.co.seoulit.insa.commsvc.foudinfomgmt.service.FoudInfoMgmtService;
import kr.co.seoulit.insa.commsvc.foudinfomgmt.to.HolidayTO;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

@RequestMapping("/foudinfomgmt/*")
@RestController
public class HolidayListController {
	
	@Autowired
	private FoudInfoMgmtService foudInfoMgmtService;	
	ModelMap map = null;

	@GetMapping("holiday")
	public ModelMap findHolidayList() {

		map = new ModelMap();
		try {
			ArrayList<HolidayTO> holidayList = foudInfoMgmtService.findHolidayList();
			HolidayTO holito = new HolidayTO();
			map.put("holidayList", holidayList);
			map.put("emptyHoilday", holito);
			map.put("errorMsg", "success");
			map.put("errorCode", 0);
			
		} catch (Exception dae) {
			map.clear();
			map.put("errorCode", -1);
			map.put("errorMsg", dae.getMessage());
		}
		return map;
	}

	@GetMapping("holidayweek")
	public ModelMap findWeekDayCount(@RequestParam String startDate,String endDate) {
		map = new ModelMap();
		
		try {
			String weekdayCount = foudInfoMgmtService.findWeekDayCount(startDate, endDate);
			map.put("weekdayCount", weekdayCount);
			map.put("errorMsg", "success");
			map.put("errorCode", 0);
			
		} catch (Exception dae) {
			map.clear();
			map.put("errorCode", -1);
			map.put("errorMsg", dae.getMessage());
		}
		return map;
	}

	
	@PutMapping("holiday")
	public ModelMap batchHolidayProcess(@RequestBody ArrayList<HolidayTO> holidayList) {
		map = new ModelMap();
		try {
			foudInfoMgmtService.batchHolidayProcess(holidayList);
			map.put("errorMsg", "success");
			map.put("errorCode", 0);

		} catch (Exception e) {
			map.clear();
			map.put("errorCode", -1);
			map.put("errorMsg", e.getMessage());
		}
		return map;
	}

}
