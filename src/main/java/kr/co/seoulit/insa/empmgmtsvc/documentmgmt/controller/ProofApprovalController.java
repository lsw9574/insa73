package kr.co.seoulit.insa.empmgmtsvc.documentmgmt.controller;

import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import kr.co.seoulit.insa.empmgmtsvc.documentmgmt.service.DocumentMgmtService;
import kr.co.seoulit.insa.empmgmtsvc.documentmgmt.to.proofTO;


@RequestMapping("/documentmgmt/*")
@RestController
public class ProofApprovalController {

    @Autowired
    private DocumentMgmtService documentMgmtService;
    ModelMap map = null;

    @GetMapping("proof-approval")
    public ModelMap findProofAttdListByDept(@RequestParam String startDate, String endDate, String deptName,String workplaceCode) {

        map = new ModelMap();

        try {

            ArrayList<proofTO> proofAttdList = documentMgmtService.findProofListByDept(deptName, startDate, endDate,workplaceCode);
            map.put("errorMsg", "success");
            map.put("errorCode", 0);
            map.put("proofAttdList", proofAttdList);

        } catch (Exception dae) {
            map.clear();
            map.put("errorCode", -1);
            map.put("errorMsg", dae.getMessage());
        }
        return map;
    }


    @PutMapping("proof-approval")
    public ModelMap modifyProofList(@RequestBody ArrayList<proofTO> proofList) {

        map = new ModelMap();

        try {
            documentMgmtService.modifyProofList(proofList);
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
