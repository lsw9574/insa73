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
import kr.co.seoulit.insa.attdsvc.attdappvl.to.DayAttdMgtTO;

@RestController
@RequestMapping("/attdappvl/*")
public class DailyAttendanceMgtController {

    @Autowired
    private AttdAppvlService attdAppvlService;
    ModelMap map = null;

    @GetMapping("day-attnd")
    public ModelMap findDayAttdMgtList(@RequestParam String applyDay,String workplaceCode) {

        map = new ModelMap();

        try {
            ArrayList<DayAttdMgtTO> dayAttdMgtList = attdAppvlService.findDayAttdMgtList(applyDay,workplaceCode);
            map.put("dayAttdMgtList", dayAttdMgtList);
            map.put("errorMsg", "success");
            map.put("errorCode", 0);

        } catch (Exception dae) {
            map.clear();
            map.put("errorCode", -1);
            map.put("errorMsg", dae.getMessage());
        }
        return map;
    }

    @PutMapping("day-attnd")
    public ModelMap modifyDayAttdList(@RequestBody ArrayList<DayAttdMgtTO> dayAttdMgtList) {

        map = new ModelMap();

        try {
            attdAppvlService.modifyDayAttdMgtList(dayAttdMgtList);
            map.put("errorMsg", "success");
            map.put("errorCode", 0);

        } catch (Exception dae) {
            map.clear();
            map.put("errorCode", -1);
            map.put("errorMsg", dae.getMessage());
        }
        return map;
    }

}
