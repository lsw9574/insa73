package kr.co.seoulit.insa.commsvc.foudinfomgmt.controller;

import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import kr.co.seoulit.insa.commsvc.foudinfomgmt.service.FoudInfoMgmtService;
import kr.co.seoulit.insa.commsvc.foudinfomgmt.to.BaseWorkTimeTO;

@RequestMapping("/foudinfomgmt/*")
@RestController
public class BaseWorkTimeController {

	@Autowired
	private FoudInfoMgmtService foudInfoMgmtService;
	ModelMap map = null;

	@GetMapping("basetime")
	public ModelMap findTimeList() {

		map = new ModelMap();

		try {
			ArrayList<BaseWorkTimeTO> list = foudInfoMgmtService.findTimeList();
			BaseWorkTimeTO emptyBean = new BaseWorkTimeTO();
			map.put("emptyBean", emptyBean);
			map.put("list", list);

		} catch (Exception e) {
			map.clear();
			map.put("errorCode", -1);
			map.put("errorMsg", e.getMessage());
		}
		return map;
	}

	
	@PutMapping("basetime")
	public ModelMap batchTimeProcess(@RequestBody ArrayList<BaseWorkTimeTO> timeList) {

		map = new ModelMap();

		try {

			foudInfoMgmtService.batchTimeProcess(timeList);
			map.put("errorCode", 0);
			map.put("errorMsg", "기준근무시간이 등록/삭제가 완료되었습니다.");

		} catch (Exception e) {
			map.clear();
			map.put("errorCode", -1);
			map.put("errorMsg", e.getMessage());
		}
		return map;
	}

	
}
