package kr.co.seoulit.insa.retirementsvc.retirementmgmt.controller;

import kr.co.seoulit.insa.retirementsvc.retirementmgmt.service.RetirementMgmtService;
import kr.co.seoulit.insa.retirementsvc.retirementmgmt.to.RetirementSetMgmtTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;

@RequestMapping("/retirementmgmt/*")
@RestController
public class RetirementSetMgmtController {
    @Autowired
    private RetirementMgmtService retirementMgmtService;

    ModelMap map = null;

    @GetMapping("retirementmgmt")
    public ModelMap findRetirementSetMgmtDetail() {
        map = new ModelMap();
        ArrayList<RetirementSetMgmtTO> retirementSetMgmtList = retirementMgmtService.findRetirementSetMgmtDetail();
        map.put("retirementMgmt", retirementSetMgmtList);
        map.put("errorMsg", "success");
        map.put("errorCode", 0);
        return map;
    }

    @PutMapping("retirementmgmt")
    public ModelMap modifyRetirementSetMgmt(@RequestBody RetirementSetMgmtTO retirementSetMgmtTO) {
        map = new ModelMap();
        retirementMgmtService.modifyRetirementSetMgmt(retirementSetMgmtTO);
        map.put("errorMsg", "success");
        map.put("errorCode", 0);
        return map;
    }
}
