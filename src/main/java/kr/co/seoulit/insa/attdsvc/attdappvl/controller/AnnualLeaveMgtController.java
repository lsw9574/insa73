package kr.co.seoulit.insa.attdsvc.attdappvl.controller;

import java.util.ArrayList;

import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import kr.co.seoulit.insa.attdsvc.attdappvl.service.AttdAppvlService;
import kr.co.seoulit.insa.attdsvc.attdappvl.to.AnnualLeaveMgtTO;

@RestController
@RequestMapping("/attdappvl/*")
public class AnnualLeaveMgtController {

    @Autowired
    private AttdAppvlService attdAppvlService;
    ModelMap map = null;

    @GetMapping("annual-leaveMgt")
    public ModelMap findAnnualVacationMgtList(@RequestParam String applyYearMonth) {
        map = new ModelMap();
        try {

            ArrayList<AnnualLeaveMgtTO> annualVacationMgtList = attdAppvlService.findAnnualVacationMgtList(applyYearMonth);

            map.put("annualVacationMgtList", annualVacationMgtList);
            map.put("errorMsg", "success");
            map.put("errorCode", 0);

        } catch (Exception dae) {
            map.clear();
            map.put("errorCode", -1);
            map.put("errorMsg", dae.getMessage());
        }
        return map;
    }


    @PutMapping("annual-leaveMgt")
    public ModelMap modifyAnnualVacationMgtList(@RequestBody ArrayList<AnnualLeaveMgtTO> annualVacationMgtList) {
        map = new ModelMap();
        try {
            attdAppvlService.modifyAnnualVacationMgtList(annualVacationMgtList);
            map.put("errorMsg", "success");
            map.put("errorCode", 0);

        } catch (Exception dae) {
            map.clear();
            map.put("errorCode", -1);
            map.put("errorMsg", dae.getMessage());
        }
        return map;
    }


    @PutMapping("annual-leaveMgt-cancel")
    public ModelMap cancelAnnualVacationMgtList(@RequestBody ArrayList<AnnualLeaveMgtTO> annualVacationMgtList) {
        map = new ModelMap();
        try {
            attdAppvlService.cancelAnnualVacationMgtList(annualVacationMgtList);
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