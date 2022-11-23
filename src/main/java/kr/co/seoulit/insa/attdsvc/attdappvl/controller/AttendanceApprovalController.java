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
import kr.co.seoulit.insa.attdsvc.attdmgmt.to.RestAttdTO;

@RestController
@RequestMapping("/attdappvl/*")
public class AttendanceApprovalController {

    @Autowired
    private AttdAppvlService attdAppvlService;
    ModelMap map = null;

    @GetMapping("attnd-approval")
    public ModelMap findRestAttdListByDept(@RequestParam String startDate, String endDate, String deptName,String workplaceCode) {

        map = new ModelMap();

        try {
            ArrayList<RestAttdTO> restAttdList = attdAppvlService.findRestAttdListByDept(deptName, startDate, endDate,workplaceCode);
            map.put("errorMsg", "success");
            map.put("errorCode", 0);
            map.put("restAttdList", restAttdList);

        } catch (Exception dae) {
            map.clear();
            map.put("errorCode", -1);
            map.put("errorMsg", dae.getMessage());
        }
        return map;
    }


    @PutMapping("attnd-approval")
    public ModelMap modifyRestAttdList(@RequestBody ArrayList<RestAttdTO> restAttdList) {
        map = new ModelMap();

        try {
            attdAppvlService.modifyRestAttdList(restAttdList);
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
