package kr.co.seoulit.insa.retirementsvc.retirementmgmt.controller;

import kr.co.seoulit.insa.retirementsvc.retirementmgmt.service.RetirementMgmtService;
import kr.co.seoulit.insa.retirementsvc.retirementmgmt.to.RetirementPayTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;

@RequestMapping("/retirementmgmt/*")
@RestController
public class RetirementPayController {
    @Autowired
    private RetirementMgmtService retirementMgmtService;

    ModelMap map = null;

    @GetMapping("retirementpay")
    public ModelMap findRetirementPay(@RequestParam String empCode) {
        map = new ModelMap();
        try {
            HashMap<String, Object> hashMap = retirementMgmtService.findRetirementPay(empCode);
            ArrayList<RetirementPayTO> retirementPayList = (ArrayList<RetirementPayTO>) hashMap.get("result");
            map.put("retirementPay", retirementPayList);
            map.put("errorCode", hashMap.get("errorCode"));
            map.put("errorMsg",hashMap.get("errorMsg"));

        } catch (Exception dae) {
            map.clear();
            map.put("errorCode", -1);
            map.put("errorMsg", dae.getMessage());
        }
        return map;
    }
}