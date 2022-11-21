package kr.co.seoulit.insa.salarysvc.salaryinfomgmt.controller;

import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import kr.co.seoulit.insa.salarysvc.salaryinfomgmt.service.SalaryInfoMgmtService;
import kr.co.seoulit.insa.salarysvc.salaryinfomgmt.to.FullTimeSalTO;
import kr.co.seoulit.insa.salarysvc.salaryinfomgmt.to.PayDayTO;

@RequestMapping("/salaryinfomgmt/*")
@RestController
public class FullTimeSalaryController {

	@Autowired
	private SalaryInfoMgmtService salaryInfoMgmtService;
	ModelMap map = null;

	@GetMapping("salary")
	public ModelMap AllMoneyList(@RequestParam String applyYearMonth) {

		map = new ModelMap();

		try {
			ArrayList<FullTimeSalTO> AllMoneyList = salaryInfoMgmtService.findAllMoney(applyYearMonth);
			map.put("AllMoneyList", AllMoneyList);
			map.put("errorMsg", "success");
			map.put("errorCode", 0);

		} catch (Exception dae) {
			map.clear();
			map.put("errorCode", -1);
			map.put("errorMsg", dae.getMessage());
		}
		return map;
	}

	@GetMapping("salary/empcode")
	public ModelMap selectSalary(@RequestParam String applyYearMonth,String empCode) {

		map = new ModelMap();

		try {

			ArrayList<FullTimeSalTO> fullTimeSalaryList = salaryInfoMgmtService.findselectSalary(applyYearMonth,
					empCode);
			map.put("FullTimeSalaryList", fullTimeSalaryList);
			map.put("errorMsg", "success");
			map.put("errorCode", 0);

		} catch (Exception dae) {
			map.clear();
			map.put("errorCode", -1);
			map.put("errorMsg", dae.getMessage());
		}
		System.out.println("체크임" + map.get("FullTimeSalaryList"));
		return map;
	}

	@PutMapping("salary")
	public ModelMap modifyFullTimeSalary(@RequestBody ArrayList<FullTimeSalTO> fullTimeSalary) {

		map = new ModelMap();

		try {
			System.out.println("자바체크" + fullTimeSalary);
			salaryInfoMgmtService.modifyFullTimeSalary(fullTimeSalary);
			map.put("errorMsg", "success");
			map.put("errorCode", 0);

		} catch (Exception e) {
			map.put("errorMsg", e.getMessage());
			map.put("errorCode", -1);
		}
		return map;
	}

	public ModelMap paydayList() {

		map = new ModelMap();

		try {
			ArrayList<PayDayTO> list = salaryInfoMgmtService.findPayDayList();
			map.put("list", list);

		} catch (Exception e) {
			map.put("errorCode", -1);
			map.put("errorMsg", e.getMessage());
		}
		return map;
	}
}