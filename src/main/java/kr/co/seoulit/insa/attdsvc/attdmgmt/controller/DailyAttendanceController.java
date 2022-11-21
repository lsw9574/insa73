package kr.co.seoulit.insa.attdsvc.attdmgmt.controller;

import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import kr.co.seoulit.insa.attdsvc.attdmgmt.service.AttdMgmtService;
import kr.co.seoulit.insa.attdsvc.attdmgmt.to.DayAttdTO;
import kr.co.seoulit.insa.commsvc.systemmgmt.to.ResultTO;

@RestController
@RequestMapping("/attdmgmt/*")
public class DailyAttendanceController {

    @Autowired
    private AttdMgmtService attdMgmtService;
    ModelMap map = null;

    @GetMapping("daily-attnd")
    public ModelMap findDayAttdList(@RequestParam String applyDay, String empCode) {
        map = new ModelMap();

        try {
            ArrayList<DayAttdTO> dayAttdList = attdMgmtService.findDayAttdList(empCode, applyDay);
            map.put("dayAttdList", dayAttdList);
            map.put("errorMsg", "success");
            map.put("errorCode", 0);

        } catch (Exception dae) {
            map.clear();
            map.put("errorCode", -1);
            map.put("errorMsg", dae.getMessage());
        }
        return map;
    }

    @PostMapping("daily-attnd")
    public ModelMap registDayAttd(@RequestBody DayAttdTO dayAttd) {

        map = new ModelMap();

        try {
            ResultTO resultTO = attdMgmtService.registDayAttd(dayAttd);
            map.put("errorMsg", resultTO.getErrorMsg());
            map.put("errorCode", resultTO.getErrorCode());

        } catch (Exception dae) {
            map.clear();
            map.put("errorCode", -1);
            map.put("errorMsg", dae.getMessage());
        }
        return map;
    }

    @DeleteMapping("daily-attnd")
    public ModelMap removeDayAttdList(@RequestBody ArrayList<DayAttdTO> dayAttdList) {

        map = new ModelMap();

        try {
            attdMgmtService.removeDayAttdList(dayAttdList);
            map.put("errorMsg", "success");
            map.put("errorCode", 0);

        } catch (Exception dae) {
            map.clear();
            map.put("errorCode", -1);
            map.put("errorMsg", dae.getMessage());
        }
        return map;
    }


//    public ModelMap insertDayAttd(HttpServletRequest request, HttpServletResponse response) {
//
//        map = new ModelMap();
//        String sendData = request.getParameter("sendData");
//        response.setContentType("application/json; charset=UTF-8");
//
//        try {
//            Gson gson = new Gson();
//            DayAttdTO dayAttd = gson.fromJson(sendData, new TypeToken<DayAttdTO>() {
//            }.getType());
//            attdMgmtService.insertDayAttd(dayAttd);
//            map.put("errorMsg", "success");
//            map.put("errorCode", 0);
//
//        } catch (Exception dae) {
//            map.clear();
//            map.put("errorCode", -1);
//            map.put("errorMsg", dae.getMessage());
//        }
//        return map;
//    }
}
